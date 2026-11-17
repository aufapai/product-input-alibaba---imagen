#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
SYNCHRONIZE DATABASE/ALIBABA_MASTER.DB WITH UNIFIED MASTER DATASET (125 SKU)
- Copies `master_products`, `product_reference_images`, and `product_marketplace_crossref`
  into `Database/alibaba_master.db`
- Upserts all 125 master products into `products` table for the local manager app
- Updates image paths to local assets (/assets/tokopedia/..., /assets/shopee/...)
"""

import os
import sys
import json
import sqlite3

sys.stdout.reconfigure(encoding='utf-8')

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
FINAL_DIR = os.path.join(BASE_DIR, "FINAL")
ALIBABA_DB_PATH = os.path.join(BASE_DIR, "Database", "alibaba_master.db")
MASTER_DB_PATH = os.path.join(FINAL_DIR, "master_products_consolidated.db")
JSON_PATH = os.path.join(FINAL_DIR, "master_products_catalog.json")

print(f"Connecting to: {ALIBABA_DB_PATH}")
target_conn = sqlite3.connect(ALIBABA_DB_PATH)
target_cur = target_conn.cursor()

source_conn = sqlite3.connect(MASTER_DB_PATH)
source_cur = source_conn.cursor()

# 1. Clone tables directly from MASTER_DB_PATH
for tbl in ["master_products", "product_reference_images", "product_marketplace_crossref"]:
    print(f"Cloning table: {tbl}...")
    source_cur.execute(f"SELECT sql FROM sqlite_master WHERE type='table' AND name='{tbl}'")
    create_sql = source_cur.fetchone()[0]
    
    target_cur.execute(f"DROP TABLE IF EXISTS {tbl}")
    target_cur.execute(create_sql)
    
    source_cur.execute(f"SELECT * FROM {tbl}")
    rows = source_cur.fetchall()
    if rows:
        placeholders = ", ".join(["?"] * len(rows[0]))
        target_cur.executemany(f"INSERT INTO {tbl} VALUES ({placeholders})", rows)
    print(f"✓ Cloned {len(rows)} rows into {tbl}")

# Recreate unified view
target_cur.execute("DROP VIEW IF EXISTS v_master_products_full")
target_cur.execute("""CREATE VIEW v_master_products_full AS
SELECT 
    p.id,
    p.master_sku,
    p.original_sku,
    p.barcode_ean13,
    p.brand,
    p.model_name,
    p.english_title,
    p.category_name,
    p.category_group,
    p.hs_code,
    p.color,
    p.sizes_available,
    p.material_upper,
    p.material_outsole,
    p.shaft_height_cm,
    p.weight_per_pair_g,
    p.steel_toe_cap,
    p.anti_puncture_midsole,
    p.slip_resistance_rating,
    p.price_retail_avg_idr,
    p.price_wholesale_idr,
    p.price_fob_usd,
    p.currency,
    p.moq_pairs,
    p.packaging_type,
    p.pairs_per_carton,
    p.carton_volume_cbm,
    p.carton_gross_weight_kg,
    p.container_20ft_capacity_pairs,
    p.container_40ft_hq_capacity_pairs,
    p.port_of_loading,
    p.primary_image_url,
    p.primary_image_source,
    p.total_reference_images,
    p.description_id,
    p.description_en,
    c.shopee_folder,
    c.shopee_sku,
    c.tokopedia_id,
    c.blibli_id,
    c.lazada_id
FROM master_products p
LEFT JOIN product_marketplace_crossref c ON p.id = c.product_id;
""")
print("✓ Created unified view v_master_products_full in Database/alibaba_master.db")

# 2. Upsert 125 products into `products` table for Alibaba Manager App
with open(JSON_PATH, "r", encoding="utf-8") as f:
    data = json.load(f)

products = data.get("products", [])
print(f"2. Upserting {len(products)} products into Alibaba Manager `products` table...")

upsert_count = 0
for idx, p in enumerate(products, 1):
    sku = p["master_sku"]
    orig_sku = p.get("original_sku", "")
    title = p.get("english_title", "")
    cat = p.get("category_name", p.get("category", "General"))
    cat_group = p.get("category_group", "Industrial Footwear")
    price_idr = p.get("price_retail_avg_idr", 85000)
    price_usd = p.get("price_fob_usd", 3.92)
    brand = p.get("brand", "AP Boots")
    upper = p.get("material_upper", "High-Grade PVC")
    outsole = p.get("material_outsole", "Nitrile Rubber")
    color = p.get("color", "Standard")
    sizes = p.get("sizes_available", "EU 38-44")
    weight_kg = round(p.get("weight_per_pair_g", 1500) / 1000.0, 2)
    moq = p.get("pairs_per_carton", 12)
    
    # Grab local image paths
    ref_imgs = p.get("reference_images", [])
    local_imgs = [r["url"] for r in ref_imgs if r.get("url")]
    img1 = local_imgs[0] if len(local_imgs) > 0 else "/assets/placeholder_boot.webp"
    img2 = local_imgs[1] if len(local_imgs) > 1 else ""
    img3 = local_imgs[2] if len(local_imgs) > 2 else ""
    img4 = local_imgs[3] if len(local_imgs) > 3 else ""
    img5 = local_imgs[4] if len(local_imgs) > 4 else ""
    img6 = local_imgs[5] if len(local_imgs) > 5 else ""

    desc_html = f"""<div class="product-description">
<h3>{p.get('model_name')} - {cat_group}</h3>
<p>{p.get('description_id', '')[:300]}...</p>
<ul>
  <li><strong>Material:</strong> {upper}</li>
  <li><strong>Outsole:</strong> {outsole} ({p.get('slip_resistance_rating', 'Anti-Slip')})</li>
  <li><strong>Safety Feature:</strong> {p.get('steel_toe_cap', 'Reinforced Soft Toe')}</li>
  <li><strong>Packaging:</strong> {moq} pairs/carton ({p.get('carton_volume_cbm', 0.096)} CBM)</li>
  <li><strong>Standards:</strong> {p.get('certification_standards', 'SNI 0111:2009')}</li>
</ul>
</div>"""

    # Check if SKU exists in products table
    target_cur.execute("SELECT id FROM products WHERE sku = ?", (sku,))
    row = target_cur.fetchone()
    if row:
        target_cur.execute("""
            UPDATE products SET
                model_number = ?, product_title = ?, category = ?, category_group = ?,
                image_1 = ?, image_2 = ?, image_3 = ?, image_4 = ?, image_5 = ?, image_6 = ?,
                description_html = ?, place_of_origin = 'Indonesia', brand_name = ?,
                outsole_material = ?, upper_material = ?, price_usd = ?, color = ?,
                size_range = ?, moq1 = ?, status = 'APPROVED', source = 'MASTER_FINAL',
                price_idr = ?, industry_angle = ?, target_keywords = ?, is_flagship = ?
            WHERE sku = ?
        """, (
            orig_sku, title, cat, cat_group,
            img1, img2, img3, img4, img5, img6,
            desc_html, brand, outsole, upper, price_usd, color,
            sizes, moq, price_idr, p.get("target_industry_applications"), p.get("seo_keywords"),
            1 if idx <= 25 else 0, sku
        ))
    else:
        target_cur.execute("""
            INSERT INTO products (
                sku, model_number, product_title, category, category_group,
                image_1, image_2, image_3, image_4, image_5, image_6,
                description_html, place_of_origin, brand_name,
                outsole_material, upper_material, price_usd, color,
                size_range, moq1, status, source, price_idr,
                industry_angle, target_keywords, is_flagship
            ) VALUES (
                ?, ?, ?, ?, ?,
                ?, ?, ?, ?, ?, ?,
                ?, 'Indonesia', ?,
                ?, ?, ?, ?,
                ?, ?, 'APPROVED', 'MASTER_FINAL', ?,
                ?, ?, ?
            )
        """, (
            sku, orig_sku, title, cat, cat_group,
            img1, img2, img3, img4, img5, img6,
            desc_html, brand,
            outsole, upper, price_usd, color,
            sizes, moq, price_idr,
            p.get("target_industry_applications"), p.get("seo_keywords"), 1 if idx <= 25 else 0
        ))
    upsert_count += 1

target_conn.commit()
target_conn.close()
source_conn.close()

print(f"✓ Successfully synchronized {upsert_count} master products into Database/alibaba_master.db!")
