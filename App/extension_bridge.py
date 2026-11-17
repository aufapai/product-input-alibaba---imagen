# -*- coding: utf-8 -*-
"""
Chrome Extension Bridge API Module
Menghubungkan Database/alibaba_master.db + Output/flow_product_input_jobs.json
dengan Chrome Extension (Manifest V3) pada localhost:8888.
"""

import os
import json
import shutil
import sqlite3
from typing import Dict, Any, List, Optional
from PIL import Image

from flow_photobank.category_mapper import PHOTOBANK_CATEGORIES, resolve_photobank_category

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(BASE_DIR, "Database", "alibaba_master.db")
FLOW_JOBS_JSON = os.path.join(BASE_DIR, "Output", "flow_product_input_jobs.json")
PHOTOBANK_ROOT = os.path.join(BASE_DIR, "Output", "Photobank_Siap_Upload")
FLOW_GENERATED_ROOT = os.path.join(BASE_DIR, "Output", "Flow_Generated")
FLOW_PROJECT_URL = "https://flow.google.com/project/5a88c3fd-477c-4eed-a126-f812ccfb079c"
CHROME_ACCOUNT_EMAIL = "aufahots@gmail.com"

CATEGORY_NAME_TO_FOLDER = {
    "ap safety boots": ("01_Safety_Boots", "AP Safety Boots"),
    "petrova heavy duty safety": ("01_Safety_Boots", "AP Safety Boots"),
    "ap terra series": ("02_Terra_Series", "AP Terra Series"),
    "ap orca series": ("03_Orca_Series", "AP Orca Series"),
    "ap chef series": ("04_Chef_Series", "AP Chef Series"),
    "ap medic series": ("05_Medic_Series", "AP Medic Series"),
    "ap biker & casual": ("06_Biker_Casual", "AP Biker & Casual"),
    "ap classic boots": ("07_Classic_Boots", "AP Classic Boots"),
    "ap kids boots": ("08_Kids_Boots", "AP Kids Boots"),
    "ap sandals & clogs": ("09_Sandals_Clogs", "AP Sandals & Clogs"),
    "ap kasual sneakers": ("10_Kasual_Sneakers", "AP Kasual Sneakers"),
}


def _resolve_category_folder(category_name: str, orig_sku: str, title: str):
    cat_low = (category_name or "").strip().lower()
    if cat_low in CATEGORY_NAME_TO_FOLDER:
        return CATEGORY_NAME_TO_FOLDER[cat_low]
    for k, v in CATEGORY_NAME_TO_FOLDER.items():
        if k in cat_low or cat_low in k:
            return v
    pb_folder, pb_group, _ = resolve_photobank_category(orig_sku, title, category_name)
    return pb_folder, pb_group


def _get_conn():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    return conn


def _parse_keywords(raw_kw: str, brand: str, model_name: str, cat_name: str) -> List[str]:
    kws = []
    if raw_kw:
        parts = [x.strip() for x in raw_kw.replace("\n", ",").split(",") if x.strip()]
        kws.extend(parts)
    defaults = [
        f"{brand} {model_name}".strip(),
        f"Waterproof PVC {cat_name}".strip(),
        "Industrial Safety Boots Indonesia Wholesale",
    ]
    for d in defaults:
        if len(kws) >= 3:
            break
        if d and d not in kws:
            kws.append(d)
    return kws[:3]


def _build_local_image_list(conn: sqlite3.Connection, master_sku: str, primary_url: str) -> List[Dict[str, Any]]:
    cur = conn.cursor()
    cur.execute(
        """
        SELECT source_flag, flag_label, image_title, image_type, image_url, is_primary
        FROM product_reference_images
        WHERE master_sku = ?
        ORDER BY
            CASE source_flag
                WHEN 'FLOW_GENERATED' THEN 1
                WHEN 'PHOTOBANK' THEN 2
                WHEN 'SHOPEE' THEN 3
                WHEN 'TOKOPEDIA_LOCAL' THEN 4
                ELSE 5
            END,
            is_primary DESC,
            id ASC
        """,
        (master_sku,),
    )
    rows = cur.fetchall()
    imgs = []
    seen = set()
    for r in rows:
        url = r["image_url"] or ""
        if not url or url in seen:
            continue
        # Only include local/offline-safe paths first, or http fallback
        full_url = f"http://localhost:8888{url}" if url.startswith("/") else url
        imgs.append(
            {
                "source": r["source_flag"],
                "flag": r["flag_label"],
                "title": r["image_title"],
                "type": r["image_type"],
                "url": full_url,
                "path": url,
                "filename": os.path.basename(url.split("?")[0]),
                "is_local": url.startswith("/"),
            }
        )
        seen.add(url)
        if len(imgs) >= 10:
            break

    if not imgs and primary_url:
        full_url = f"http://localhost:8888{primary_url}" if primary_url.startswith("/") else primary_url
        imgs.append(
            {
                "source": "MASTER",
                "flag": "[MASTER]",
                "title": "Primary Boot Image",
                "type": "Hero",
                "url": full_url,
                "path": primary_url,
                "filename": os.path.basename(primary_url.split("?")[0]),
                "is_local": primary_url.startswith("/"),
            }
        )
    return imgs


def get_ext_health() -> Dict[str, Any]:
    conn = _get_conn()
    cur = conn.cursor()
    cur.execute("SELECT COUNT(*) FROM master_products")
    total_master = cur.fetchone()[0]
    cur.execute(
        "SELECT COUNT(*) FROM products WHERE source = 'MASTER_FINAL' AND alibaba_product_id IS NOT NULL AND alibaba_product_id != ''"
    )
    live_count = cur.fetchone()[0]
    conn.close()
    return {
        "success": True,
        "status": "ONLINE",
        "bridge_version": "1.0.0-tahap1",
        "chrome_profile_target": CHROME_ACCOUNT_EMAIL,
        "flow_project_url": FLOW_PROJECT_URL,
        "total_master_skus": total_master,
        "live_alibaba_skus": live_count,
    }


def get_ext_categories() -> Dict[str, Any]:
    conn = _get_conn()
    cur = conn.cursor()
    cur.execute("SELECT master_sku, original_sku, model_name, category_name FROM master_products")
    rows = cur.fetchall()
    conn.close()

    counts: Dict[str, int] = {k: 0 for k in PHOTOBANK_CATEGORIES.keys()}
    for r in rows:
        folder, _ = _resolve_category_folder(
            r["category_name"] or "",
            r["original_sku"] or r["master_sku"],
            r["model_name"] or "",
        )
        counts[folder] = counts.get(folder, 0) + 1

    cats = []
    for folder, meta in PHOTOBANK_CATEGORIES.items():
        cats.append(
            {
                "folder": folder,
                "label": meta["group_name"],
                "count": counts.get(folder, 0),
            }
        )
    return {"success": True, "categories": cats}


def get_ext_queue(
    status_filter: str = "", search_q: str = "", category_filter: str = "", limit: int = 125
) -> Dict[str, Any]:
    conn = _get_conn()
    cur = conn.cursor()
    sql = """
        SELECT
            m.id,
            m.master_sku,
            m.original_sku,
            m.brand,
            m.model_name,
            m.english_title,
            m.category_name,
            m.price_fob_usd,
            m.pairs_per_carton,
            m.moq_pairs,
            m.primary_image_url,
            p.status AS alibaba_status,
            p.alibaba_product_id,
            p.tier3_price,
            p.tier1_price
        FROM master_products m
        LEFT JOIN products p ON p.sku = m.master_sku
        WHERE 1=1
    """
    params: List[Any] = []
    if search_q:
        like = f"%{search_q}%"
        sql += " AND (m.master_sku LIKE ? OR m.original_sku LIKE ? OR m.model_name LIKE ? OR m.english_title LIKE ? OR m.category_name LIKE ?)"
        params.extend([like, like, like, like, like])

    if status_filter:
        sf = status_filter.upper()
        if sf == "LIVE":
            sql += " AND p.alibaba_product_id IS NOT NULL AND p.alibaba_product_id != ''"
        elif sf in ("PENDING", "APPROVED", "DONE", "PHOTOBANK_UPLOADED", "LIVE_ALIBABA"):
            sql += " AND UPPER(COALESCE(p.status, 'PENDING')) = ?"
            params.append(sf)

    sql += " ORDER BY m.id ASC LIMIT ?"
    params.append(limit)
    cur.execute(sql, params)
    rows = cur.fetchall()
    conn.close()

    items = []
    for r in rows:
        pb_folder, pb_group = _resolve_category_folder(
            r["category_name"] or "",
            r["original_sku"] or r["master_sku"],
            r["english_title"] or r["model_name"],
        )
        if category_filter and pb_folder.lower() != category_filter.strip().lower():
            continue
        fob = float(r["price_fob_usd"] or 5.0)
        p_min = float(r["tier3_price"] or round(fob * 0.90, 2))
        p_max = float(r["tier1_price"] or fob)
        moq = int(r["pairs_per_carton"] or r["moq_pairs"] or 12)
        prim = r["primary_image_url"] or "/assets/placeholder_boot.webp"
        items.append(
            {
                "master_sku": r["master_sku"],
                "original_sku": r["original_sku"],
                "brand": r["brand"],
                "model_name": r["model_name"],
                "product_name": (r["english_title"] or r["model_name"])[:128],
                "category_name": r["category_name"],
                "photobank_group": pb_folder,
                "photobank_group_label": pb_group,
                "moq": moq,
                "price_min": round(min(p_min, p_max), 2),
                "price_max": round(max(p_min, p_max), 2),
                "primary_image": f"http://localhost:8888{prim}" if prim.startswith("/") else prim,
                "status": r["alibaba_status"] or "APPROVED",
                "alibaba_product_id": r["alibaba_product_id"] or "",
            }
        )

    return {"success": True, "count": len(items), "items": items}


def get_ext_product(sku: str) -> Optional[Dict[str, Any]]:
    sku_clean = sku.strip().upper()
    conn = _get_conn()
    cur = conn.cursor()
    cur.execute(
        """
        SELECT m.*, p.alibaba_product_id, p.status AS alibaba_status,
               p.tier1_price, p.tier2_price, p.tier3_price, p.moq1, p.keywords, p.description_html
        FROM master_products m
        LEFT JOIN products p ON p.sku = m.master_sku
        WHERE UPPER(m.master_sku) = ? OR UPPER(m.original_sku) = ?
        LIMIT 1
        """,
        (sku_clean, sku_clean),
    )
    row = cur.fetchone()
    if not row:
        conn.close()
        return None

    pb_folder, pb_group = _resolve_category_folder(
        row["category_name"] or "",
        row["original_sku"] or row["master_sku"],
        row["english_title"] or row["model_name"],
    )
    fob = float(row["price_fob_usd"] or 5.0)
    price_min = round(float(row["tier3_price"] or fob * 0.90), 2)
    price_max = round(float(row["tier1_price"] or fob), 2)
    moq = int(row["moq1"] or row["pairs_per_carton"] or row["moq_pairs"] or 12)

    kws = _parse_keywords(
        row["seo_keywords"] or row["keywords"] or "",
        row["brand"] or "AP Boots",
        row["model_name"] or "",
        row["category_name"] or "",
    )

    cat_lower = (row["category_name"] or "").lower()
    if "safety" in cat_lower or "petrova" in cat_lower:
        cat_path = "Security & Protection > Personal Protective Equipment > Safety Footwear"
    elif "sandal" in cat_lower or "clog" in cat_lower:
        cat_path = "Shoes & Accessories > Men's Shoes > Slides & Slippers"
    elif "kids" in cat_lower:
        cat_path = "Shoes & Accessories > Children's Shoes > Rain Boots"
    else:
        cat_path = "Shoes & Accessories > Men's Shoes > Rain Boots"

    imgs = _build_local_image_list(conn, row["master_sku"], row["primary_image_url"] or "")
    conn.close()

    rdict = dict(row)
    shaft_cm = float(rdict.get("shaft_height_cm") or 30.0)
    if "kids" in cat_lower or "anak" in (rdict.get("model_name") or "").lower():
        gender_val = "Children"
    else:
        gender_val = "Unisex"

    if shaft_cm >= 32:
        boot_height_val = "Knee-High"
    elif shaft_cm >= 18:
        boot_height_val = "Mid-Calf"
    else:
        boot_height_val = "Ankle"

    steel_raw = (rdict.get("steel_toe_cap") or "").lower()
    toe_style_val = "Steel Toe" if ("steel" in steel_raw and "non" not in steel_raw and "tanpa" not in steel_raw) else "Round Toe"
    midsole_raw = (rdict.get("midsole_protection") or "").lower()
    midsole_mat_val = "Steel" if ("steel" in midsole_raw and "non" not in midsole_raw) else "PVC"
    feature_val = "Waterproof, Anti-Slip, Oil Resistant" + (", Steel Toe" if toe_style_val == "Steel Toe" else "")

    return {
        "success": True,
        "lock": True,
        "master_sku": row["master_sku"],
        "original_sku": row["original_sku"],
        "Product_Name": (row["english_title"] or row["model_name"])[:128],
        "Keyword_1": kws[0],
        "Keyword_2": kws[1],
        "Keyword_3": kws[2],
        "Category_Path": cat_path,
        "MOQ": moq,
        "Price_Min": min(price_min, price_max),
        "Price_Max": max(price_min, price_max),
        "Currency": "USD",
        "Photobank_Group": pb_folder,
        "Photobank_Group_Label": pb_group,
        "Image_Filename": imgs[0]["filename"] if imgs else "",
        "images": imgs,
        "Status": row["alibaba_status"] or "APPROVED",
        "alibaba_product_id": row["alibaba_product_id"] or "",
        "attributes": {
            "brand_name": row["brand"] or "AP Boots",
            "model_number": row["original_sku"] or row["master_sku"],
            "place_of_origin": row["origin_country"] or "Indonesia",
            "upper_material": row["material_upper"] or "PVC",
            "outsole_material": row["material_outsole"] or "PVC / Nitrile Rubber",
            "midsole_material": midsole_mat_val,
            "lining_material": "PVC",
            "gender": gender_val,
            "boot_height": boot_height_val,
            "toe_style": toe_style_val,
            "feature": feature_val,
            "season": "All Seasons",
            "unit": "Pair",
            "color": row["color"] or "Standard",
            "size_range": row["sizes_available"] or "EU 38-44",
            "weight_kg": round(float(row["weight_per_pair_g"] or 1500) / 1000.0, 2),
            "hs_code": row["hs_code"] or "6401.92.00",
            "steel_toe": row["steel_toe_cap"] or "None",
            "certification": row["certification_standards"] or "SNI 0111:2009",
        },
        "description_en": row["description_en"] or "",
        "description_html": row["description_html"] or "",
    }


def get_ext_flow_jobs(sku: str) -> Optional[Dict[str, Any]]:
    prod = get_ext_product(sku)
    if not prod:
        return None

    m_sku = prod["master_sku"]
    o_sku = prod["original_sku"]
    matched_jobs: List[Dict[str, Any]] = []

    if os.path.exists(FLOW_JOBS_JSON):
        try:
            with open(FLOW_JOBS_JSON, "r", encoding="utf-8") as f:
                data = json.load(f)
            all_jobs = data.get("jobs", []) if isinstance(data, dict) else data
            matched_jobs = [
                j for j in all_jobs if str(j.get("sku", "")).upper() in (m_sku.upper(), o_sku.upper())
            ]
        except Exception:
            matched_jobs = []

    ref_img = prod["images"][0]["url"] if prod["images"] else "http://localhost:8888/assets/placeholder_boot.webp"
    name = prod["Product_Name"]

    if not matched_jobs:
        slot_defs = [
            (
                "slot_1_hero",
                "Slot 1 - Hero White BG",
                f"Using the attached reference photo, create a professional commercial studio product photograph of {name}. 3/4 upright front view, occupying 85% of a pure seamless white background RGB(255,255,255), soft studio lighting, crisp texture, 1:1 square, no text.",
            ),
            (
                "slot_2_side",
                "Slot 2 - 90° Side Profile",
                f"Using the attached reference photo, create a clean orthogonal 90-degree lateral side profile photograph of {name} on pure seamless white background RGB(255,255,255), showing exact shaft height and outsole contour, 1:1 square, no text.",
            ),
            (
                "slot_3_tread",
                "Slot 3 - Outsole Tread Cleats",
                f"Using the attached reference photo, create a sharp close-up bottom outsole tread view of {name}, highlighting deep anti-slip cleats and mud-release channels on pure white background RGB(255,255,255), 1:1 square.",
            ),
            (
                "slot_4_contextual",
                "Slot 4 - Contextual In-Use",
                f"Using the attached reference photo, create a realistic B2B commercial photograph of {name} worn on wet industrial or plantation terrain, framing from knees down with no visible human face, natural daylight, 1:1 square.",
            ),
        ]
        for slot_key, slot_label, prompt_text in slot_defs:
            matched_jobs.append(
                {
                    "job_id": f"{m_sku}_{slot_key}",
                    "sku": m_sku,
                    "product_name": name,
                    "slot_key": slot_key,
                    "slot_label": slot_label,
                    "target_folder": prod["Photobank_Group"],
                    "target_filename": f"{m_sku}_{slot_key}.webp",
                    "reference_image_local": ref_img,
                    "prompt": prompt_text,
                    "status": "ready",
                }
            )
    else:
        for j in matched_jobs:
            j["reference_image_local"] = ref_img

    return {
        "success": True,
        "master_sku": m_sku,
        "original_sku": o_sku,
        "flow_project_url": FLOW_PROJECT_URL,
        "chrome_account": CHROME_ACCOUNT_EMAIL,
        "photobank_group": prod["Photobank_Group"],
        "reference_image_local": ref_img,
        "jobs": matched_jobs[:4],
    }


def update_ext_status(sku: str, status: str, alibaba_product_id: str = "") -> Dict[str, Any]:
    sku_clean = sku.strip().upper()
    conn = _get_conn()
    cur = conn.cursor()
    cur.execute(
        "SELECT id, sku FROM products WHERE UPPER(sku) = ? OR UPPER(model_number) = ? LIMIT 1",
        (sku_clean, sku_clean),
    )
    row = cur.fetchone()
    if not row:
        conn.close()
        return {"success": False, "error": f"SKU {sku} tidak ditemukan di products"}

    if alibaba_product_id:
        cur.execute(
            "UPDATE products SET status = ?, alibaba_product_id = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?",
            (status, alibaba_product_id, row["id"]),
        )
    else:
        cur.execute(
            "UPDATE products SET status = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?",
            (status, row["id"]),
        )
    conn.commit()
    conn.close()
    return {
        "success": True,
        "sku": row["sku"],
        "status": status,
        "alibaba_product_id": alibaba_product_id,
    }


def sync_alibaba_list(items: List[Dict[str, Any]]) -> Dict[str, Any]:
    """
    Sinkronisasi daftar produk yang sudah tayang di i.alibaba.com/products/list-manage
    ke tabel products di Database/alibaba_master.db agar tidak terjadi duplikasi.
    """
    conn = _get_conn()
    cur = conn.cursor()
    cur.execute("SELECT id, master_sku, original_sku, model_name, english_title FROM master_products")
    masters = cur.fetchall()

    matched_count = 0
    for it in items:
        ali_id = str(it.get("alibaba_product_id", "")).strip()
        ali_title = str(it.get("title", "")).strip()
        ali_model = str(it.get("model_number", "")).strip()
        if not ali_title and not ali_id:
            continue

        ali_low = f"{ali_title} {ali_model}".lower()
        best_sku = None
        for m in masters:
            m_sku = (m["master_sku"] or "").lower()
            o_sku = (m["original_sku"] or "").lower()
            m_name = (m["model_name"] or "").lower()
            if (o_sku and o_sku in ali_low) or (m_sku and m_sku in ali_low) or (m_name and len(m_name) > 3 and m_name in ali_low):
                best_sku = m["master_sku"]
                break

        if best_sku:
            cur.execute(
                """
                UPDATE products
                SET alibaba_product_id = COALESCE(NULLIF(?, ''), alibaba_product_id),
                    status = 'LIVE_ALIBABA',
                    updated_at = CURRENT_TIMESTAMP
                WHERE sku = ?
                """,
                (ali_id, best_sku),
            )
            matched_count += 1

    conn.commit()
    conn.close()
    return {
        "success": True,
        "scanned_count": len(items),
        "matched_master_skus": matched_count,
    }


def handle_flow_downloaded(sku: str, download_path: str = "", slot_index: int = 1, resolution: str = "2K") -> Dict[str, Any]:
    """
    Memindahkan & mengonversi gambar hasil unduhan Google Flow (2K/1K) dari folder Downloads
    ke folder terpisah Output/Flow_Generated/<Photobank_Group>/<master_sku>/
    dan mendaftarkannya ke product_reference_images agar langsung muncul di Foto Lokal Produk.
    """
    prod = get_ext_product(sku)
    if not prod:
        return {"success": False, "error": f"SKU {sku} tidak ditemukan"}

    src_path = download_path
    if not src_path or not os.path.exists(src_path):
        dl_dir = os.path.join(os.path.expanduser("~"), "Downloads")
        if os.path.exists(dl_dir):
            candidates = [
                os.path.join(dl_dir, f)
                for f in os.listdir(dl_dir)
                if f.lower().endswith((".png", ".jpg", ".jpeg", ".webp"))
            ]
            if candidates:
                src_path = max(candidates, key=os.path.getmtime)

    if not src_path or not os.path.exists(src_path):
        return {"success": False, "error": "File unduhan Google Flow tidak ditemukan di folder Downloads"}

    pb_folder = prod["Photobank_Group"]
    dest_dir = os.path.join(FLOW_GENERATED_ROOT, pb_folder, prod["master_sku"])
    os.makedirs(dest_dir, exist_ok=True)

    slot_names = {1: "slot_1_hero", 2: "slot_2_side", 3: "slot_3_tread", 4: "slot_4_contextual"}
    slot_key = slot_names.get(int(slot_index), f"slot_{slot_index}")
    out_filename = f"{prod['master_sku']}_{prod['original_sku']}_{slot_key}_{resolution}.webp"
    out_path = os.path.join(dest_dir, out_filename)

    try:
        with Image.open(src_path) as im:
            im = im.convert("RGB")
            im.save(out_path, "WEBP", quality=92)
    except Exception:
        shutil.copy2(src_path, out_path)

    web_url = f"/assets/flow-generated/{pb_folder}/{prod['master_sku']}/{out_filename}"
    conn = _get_conn()
    cur = conn.cursor()
    cur.execute("SELECT id FROM master_products WHERE master_sku = ?", (prod["master_sku"],))
    mrow = cur.fetchone()
    if mrow:
        cur.execute(
            "DELETE FROM product_reference_images WHERE master_sku = ? AND image_url = ?",
            (prod["master_sku"], web_url),
        )
        cur.execute(
            """
            INSERT INTO product_reference_images (
                id, product_id, master_sku, source_flag, flag_label, flag_color,
                image_title, image_type, image_url, is_primary
            )
            SELECT COALESCE(MAX(id), 0) + 1, ?, ?, 'FLOW_GENERATED', ?, '#7c3aed',
                   ?, ?, ?, ?
            FROM product_reference_images
            """,
            (
                mrow["id"],
                prod["master_sku"],
                f"[FLOW {resolution}]",
                f"Google Flow {slot_key} ({resolution})",
                f"Flow Agent {resolution}",
                web_url,
                1 if int(slot_index) == 1 else 0,
            ),
        )
        conn.commit()
    conn.close()

    return {
        "success": True,
        "master_sku": prod["master_sku"],
        "photobank_group": pb_folder,
        "saved_path": out_path,
        "web_url": web_url,
        "resolution": resolution,
    }
