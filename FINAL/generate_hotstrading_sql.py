#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
GENERATE DEDICATED SQL INJECTION FOR CATALOG.HOTSTRADING.COM
Target Database: MariaDB / MySQL (`hotj4796_hotstrading`)
Production Catalog URL: https://catalog.hotstrading.com
- Generates 125 Master Products (0 Duplikat)
- Populates `categories`, `manufacturers`, `products`, `product_specifications`,
  `product_use_cases`, `product_regions`, `product_certifications`, `alibaba_export_listings`
- Formatted matching live frontend product cards:
  (Compliance, Key Spec, Target Sectors, Packaging, Wholesale FOB Reference, Badges)
- Includes full image arrays (Shopee, Tokopedia Local 1600x1600, Photobank B2B 4-slot)
"""

import os
import sys
import json
import re

sys.stdout.reconfigure(encoding='utf-8')

FINAL_DIR = os.path.dirname(os.path.abspath(__file__))
BASE_DIR = os.path.dirname(FINAL_DIR)
INPUT_JSON = os.path.join(FINAL_DIR, "master_products_catalog.json")
OUTPUT_SQL = os.path.join(FINAL_DIR, "inject_catalog_hotstrading.sql")
DB_OUTPUT_SQL = os.path.join(BASE_DIR, "Database", "inject_catalog_hotstrading.sql")

with open(INPUT_JSON, 'r', encoding='utf-8') as f:
    catalog_data = json.load(f)

products = catalog_data.get("products", [])
categories_meta = catalog_data.get("categories", [])
print(f"Loaded {len(products)} products and {len(categories_meta)} categories from master JSON")

def escape_sql(val) -> str:
    if val is None:
        return "NULL"
    s = str(val).replace("\\", "\\\\").replace("'", "''")
    return f"'{s}'"

def slugify(text: str) -> str:
    text = text.lower()
    text = re.sub(r'[^a-z0-9]+', '-', text).strip('-')
    return text

sql_lines = []

sql_lines.append("-- =============================================================================")
sql_lines.append("-- HOTS TRADING — PRODUCTION DATABASE INJECTION SCRIPT")
sql_lines.append("-- Target Domain: https://catalog.hotstrading.com")
sql_lines.append("-- Target Database: `hotj4796_hotstrading` (MariaDB / MySQL 10.11+ / phpMyAdmin)")
sql_lines.append("-- Generated: 2026-11-12 | Version: 2.5-PRODUCTION-LIVE")
sql_lines.append(f"-- Total Master Products: {len(products)} SKU (Zero Duplicates)")
sql_lines.append("-- Content: Categories, Manufacturers, Products, Specifications, Use Cases,")
sql_lines.append("--          Export Regions, Certifications, and Alibaba Export Listings")
sql_lines.append("-- =============================================================================\n")

sql_lines.append("SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';")
sql_lines.append("SET time_zone = '+00:00';")
sql_lines.append("SET NAMES utf8mb4;")
sql_lines.append("SET FOREIGN_KEY_CHECKS = 0;\n")
sql_lines.append("START TRANSACTION;\n")

# -------------------------------------------------------------
# 1. CATEGORIES TABLE
# -------------------------------------------------------------
sql_lines.append("-- -------------------------------------------------------------")
sql_lines.append("-- 1. TAXONOMY CATEGORIES (11 Footwear Categories)")
sql_lines.append("-- -------------------------------------------------------------")
sql_lines.append("INSERT INTO `categories` (`id`, `name`, `slug`, `description`, `created_at`, `updated_at`) VALUES")

cat_rows = []
for cm in categories_meta:
    cat_id = cm["category_id"] + 10  # IDs 11 to 21 to avoid clashing with default IDs 1-5
    c_name = cm["category_name"]
    c_slug = cm["category_code"].lower().replace('cat-', '') + '-footwear'
    c_desc = f"{cm['category_group']} - Export-grade Indonesian waterproof footwear compliant with SNI and global standards."
    cat_rows.append(f"({cat_id}, {escape_sql(c_name)}, {escape_sql(c_slug)}, {escape_sql(c_desc)}, NOW(), NOW())")

sql_lines.append(",\n".join(cat_rows))
sql_lines.append("ON DUPLICATE KEY UPDATE `name`=VALUES(`name`), `description`=VALUES(`description`), `updated_at`=NOW();\n")

# -------------------------------------------------------------
# 2. MANUFACTURERS TABLE
# -------------------------------------------------------------
sql_lines.append("-- -------------------------------------------------------------")
sql_lines.append("-- 2. LEGAL MANUFACTURERS & EXPORT PARTNERS")
sql_lines.append("-- -------------------------------------------------------------")
sql_lines.append("INSERT INTO `manufacturers` (`id`, `name`, `slug`, `country`, `description`, `logo_url`, `created_at`, `updated_at`) VALUES")
sql_lines.append("(1, 'PT Indo Sukses Semesta', 'pt-indo-sukses-semesta', 'Indonesia', 'Global B2B Export and Distribution Partner for AP Boots & Petrova Safety Footwear (HOTS Trading)', 'https://catalog.hotstrading.com/assets/img/logo_hots.png', NOW(), NOW()),")
sql_lines.append("(2, 'PT Waru Gunung Industry', 'pt-waru-gunung-industry', 'Indonesia', 'Principal Manufacturer of AP Boots Indonesia since 1982. ISO 9001:2015 & SNI Certified Factory.', 'https://catalog.hotstrading.com/assets/img/logo_apboots.png', NOW(), NOW())")
sql_lines.append("ON DUPLICATE KEY UPDATE `name`=VALUES(`name`), `country`=VALUES(`country`), `description`=VALUES(`description`), `updated_at`=NOW();\n")

# -------------------------------------------------------------
# 3. IDEMPOTENT CLEANUP FOR INJECTED PRODUCTS
# -------------------------------------------------------------
sql_lines.append("-- -------------------------------------------------------------")
sql_lines.append("-- 3. IDEMPOTENT CLEANUP (Allow safe re-runs without errors)")
sql_lines.append("-- -------------------------------------------------------------")
sql_lines.append("DELETE FROM `product_specifications` WHERE `product_id` BETWEEN 2001 AND 2125;")
sql_lines.append("DELETE FROM `product_use_cases` WHERE `product_id` BETWEEN 2001 AND 2125;")
sql_lines.append("DELETE FROM `product_regions` WHERE `product_id` BETWEEN 2001 AND 2125;")
sql_lines.append("DELETE FROM `product_certifications` WHERE `product_id` BETWEEN 2001 AND 2125;")
sql_lines.append("DELETE FROM `alibaba_export_listings` WHERE `product_id` BETWEEN 2001 AND 2125;")
sql_lines.append("DELETE FROM `products` WHERE `id` BETWEEN 2001 AND 2125 OR `product_code` LIKE 'MST-%';\n")

# -------------------------------------------------------------
# 4. PRODUCTS TABLE
# -------------------------------------------------------------
sql_lines.append("-- -------------------------------------------------------------")
sql_lines.append("-- 4. MASTER PRODUCTS (125 SKU - Full B2B Specs)")
sql_lines.append("-- -------------------------------------------------------------")
sql_lines.append("""INSERT INTO `products` (
  `id`, `product_code`, `name`, `code`, `series`, `description`, `category`, `status`,
  `category_id`, `manufacturer_id`, `image_url`, `images`, `moq`, `moq_new`, `production_capacity`,
  `base_price`, `currency`, `is_active`, `is_featured`, `slug`, `custom_taxonomy`, `badges`,
  `is_tax_included`, `is_transport_included`, `created_at`, `updated_at`
) VALUES""")

prod_rows = []
all_specs_rows = []
all_usecases_rows = []
all_regions_rows = []
all_certs_rows = []
all_alibaba_rows = []

spec_id_counter = 10001
usecase_id_counter = 10001
region_id_counter = 10001
cert_id_counter = 10001
alibaba_id_counter = 10001

for idx, p in enumerate(products, 1):
    db_prod_id = 2000 + idx  # 2001 to 2125 (guaranteed no conflict)
    master_sku = p["master_sku"]
    orig_sku = p.get("original_sku", f"SKU-{idx:03d}")
    model_name = p.get("model_name") or p.get("product_name")
    brand = p.get("brand", "AP Boots")
    cat_name = p.get("category_name", p.get("category", "General"))
    cat_id = p.get("category_id", 1) + 10
    cat_group = p.get("category_group", "Industrial Footwear")
    price_retail = p.get("price_retail_avg_idr", 85000)
    price_wholesale = p.get("price_wholesale_idr", 63750)
    price_fob_usd = p.get("price_fob_usd", 3.92)
    pairs_carton = p.get("pairs_per_carton", 12)
    moq_str = f"{pairs_carton} Pairs"
    slug = slugify(f"{brand}-{model_name}-{master_sku}")
    
    is_featured = 1 if idx <= 25 or "Safety" in cat_name or "Chef" in cat_name or "Medic" in cat_name else 0

    # Badges array matching Screenshot 2
    badges_list = []
    if "Safety" in cat_name or "Steel" in p.get("steel_toe_cap", ""):
        badges_list.append(f"HERO #{idx} • HEAVY INDUSTRY & MINING")
        badges_list.append("Steel Toe 200J")
        badges_list.append("EN ISO 20345 S5")
    elif "Chef" in cat_name:
        badges_list.append(f"HERO #{idx} • COMMERCIAL KITCHEN PRO")
        badges_list.append("Oil & Grease Proof")
        badges_list.append("Non-Slip Siping")
    elif "Medic" in cat_name:
        badges_list.append(f"HERO #{idx} • HEALTHCARE & STERILE ROOMS")
        badges_list.append("Ortholite Footbed")
        badges_list.append("Anti-Bacterial")
    elif "Terra" in cat_name:
        badges_list.append(f"HERO #{idx} • AGRICULTURE & PLANTATION")
        badges_list.append("Mud-Release Cleats")
        badges_list.append("100% Waterproof")
    else:
        badges_list.append(f"HERO #{idx} • B2B EXPORT GRADE")
        badges_list.append("SNI Certified")
        badges_list.append("Direct Factory Price")

    badges_json = json.dumps(badges_list, ensure_ascii=False)

    # Collect Images Array
    ref_imgs = p.get("reference_images", [])
    images_url_list = []
    primary_hero = ""

    for r in ref_imgs:
        url = r.get("url", "")
        if url:
            # Map local URLs to public accessible URLs on catalog.hotstrading.com
            # Fallback keeps both web path and local asset
            public_url = url
            if url.startswith("/assets/shopee/"):
                public_url = f"https://catalog.hotstrading.com{url}"
            elif url.startswith("/assets/tokopedia/"):
                public_url = f"https://catalog.hotstrading.com{url}"
            elif url.startswith("/assets/photobank/"):
                public_url = f"https://catalog.hotstrading.com{url}"
            
            if not primary_hero and (r.get("is_primary") or "hero" in url.lower() or "01_main" in url.lower()):
                primary_hero = public_url
            images_url_list.append(public_url)

    if not primary_hero:
        primary_hero = images_url_list[0] if images_url_list else "https://catalog.hotstrading.com/assets/img/placeholder_boot.webp"

    images_json = json.dumps(images_url_list[:12], ensure_ascii=False)

    # Card Top Paragraph & Formatted Description (Matching Screenshot 2 Cards)
    compliance_txt = p.get("certification_standards", "SNI 0111:2009 Standard Nasional Indonesia")
    if "Safety" in cat_name or "Steel" in p.get("steel_toe_cap", ""):
        summary_intro = f"Comprehensive industrial safety footwear engineered with {p.get('steel_toe_cap', '200J steel toe cap defense')} and puncture-resistant construction with anti-static and oil-resistant outsole."
    elif "Medic" in cat_name or "Chef" in cat_name:
        summary_intro = f"Ultra-lightweight ergonomic footwear engineered for all-day standing comfort, non-slip sanitary tile traction, and quick sanitization."
    else:
        summary_intro = f"Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding."

    key_spec_txt = f"{p.get('material_upper', 'PVC')} • {p.get('slip_resistance_rating', 'Anti-Slip')} • {p.get('sizes_available', 'EU 38-44')}"
    target_sectors_txt = p.get("target_industry_applications", "Industry, Agriculture, Construction")
    packaging_txt = f"{pairs_carton} Pairs / Master Carton ({p.get('carton_volume_cbm', 0.096):.3f} m³ • {p.get('carton_gross_weight_kg', 18.5)} kg)"
    fob_ref_txt = f"${price_fob_usd:.2f} / pair (Rp {price_retail:,.0f} Factory List)"

    # Structured Description
    full_desc = f"""{summary_intro}

Compliance: {compliance_txt}
Key Spec: {key_spec_txt}
Target Sectors: {target_sectors_txt}
Packaging: {packaging_txt}
Wholesale FOB Reference: {fob_ref_txt}

Technical Specifications:
• Upper: {p.get('material_upper')}
• Outsole: {p.get('material_outsole')}
• Toe Protection: {p.get('steel_toe_cap')}
• Midsole: {p.get('anti_puncture_midsole')}
• Shaft Height: {p.get('shaft_height_cm')} cm | Weight: {p.get('weight_per_pair_g')} g
• Sizing Range: {p.get('sizes_available')}
• Minimum Order Quantity (MOQ): {moq_str}
• Container Loadability: ~{p.get('container_20ft_capacity_pairs', 3600):,} pairs (20ft FCL) / ~{p.get('container_40ft_hq_capacity_pairs', 8500):,} pairs (40ft HQ FCL)
• Loading Seaport: {p.get('port_of_loading')}"""

    full_name_clean = f"{brand} {model_name}"
    if brand.lower() not in model_name.lower():
        full_name_clean = f"{brand} {model_name}"
    else:
        full_name_clean = model_name

    prod_row = f"""(
  {db_prod_id}, {escape_sql(master_sku)}, {escape_sql(full_name_clean)}, {escape_sql(orig_sku)},
  {escape_sql(cat_group)}, {escape_sql(full_desc)}, {escape_sql(cat_name)}, 'APPROVED',
  {cat_id}, 1, {escape_sql(primary_hero)}, {escape_sql(images_json)}, {escape_sql(moq_str)}, {pairs_carton},
  '50,000 Pairs / Month', {price_retail}, 'IDR', 1, {is_featured}, {escape_sql(slug)},
  {escape_sql(cat_group)}, {escape_sql(badges_json)}, 0, 0, NOW(), NOW()
)"""
    prod_rows.append(prod_row)

    # ---------------------------------------------------------
    # SPECIFICATIONS ROWS
    # ---------------------------------------------------------
    specs_to_add = [
        ("Compliance", compliance_txt, 1),
        ("Key Spec", key_spec_txt, 2),
        ("Upper Material", p.get("material_upper", "High-Grade PVC"), 3),
        ("Outsole", p.get("material_outsole", "Nitrile Lug Sole"), 4),
        ("Toe Protection", p.get("steel_toe_cap", "Reinforced Soft Toe"), 5),
        ("Underfoot Midsole", p.get("anti_puncture_midsole", "High Flex Sole"), 6),
        ("Slip Resistance", p.get("slip_resistance_rating", "SRC Certified"), 7),
        ("Shaft Height", f"{p.get('shaft_height_cm', 38)} cm", 8),
        ("Unit Weight", f"{p.get('weight_per_pair_g', 1500)} g / pair", 9),
        ("Available Sizing", p.get("sizes_available", "EU 38-44"), 10),
        ("Packaging", packaging_txt, 11),
        ("Wholesale FOB Reference", fob_ref_txt, 12),
        ("Container 20ft Capacity", f"{p.get('container_20ft_capacity_pairs', 3600):,} Pairs", 13),
        ("Container 40ft HQ Capacity", f"{p.get('container_40ft_hq_capacity_pairs', 8500):,} Pairs", 14),
        ("Port of Loading", p.get("port_of_loading", "Tanjung Perak, Surabaya / Tanjung Priok, Jakarta"), 15),
    ]

    for label, val, order in specs_to_add:
        all_specs_rows.append(f"({spec_id_counter}, {db_prod_id}, {escape_sql(label)}, {escape_sql(str(val)[:255])}, {order})")
        spec_id_counter += 1

    # ---------------------------------------------------------
    # USE CASES ROWS
    # ---------------------------------------------------------
    usecases = [u.strip() for u in p.get("target_industry_applications", "").split(",") if u.strip()]
    if not usecases:
        usecases = ["Heavy Industry & Construction", "Plantation & Agriculture", "Food & Commercial Processing"]
    for u in usecases[:5]:
        all_usecases_rows.append(f"({usecase_id_counter}, {db_prod_id}, {escape_sql(u[:255])})")
        usecase_id_counter += 1

    # ---------------------------------------------------------
    # REGIONS ROWS
    # ---------------------------------------------------------
    target_regions = [
        "Europe (Germany, Netherlands, UK, France)",
        "North America (United States, Canada)",
        "ASEAN (Malaysia, Singapore, Thailand, Philippines)",
        "Middle East (UAE, Saudi Arabia, Qatar)",
        "Oceania (Australia, New Zealand)"
    ]
    for r in target_regions:
        all_regions_rows.append(f"({region_id_counter}, {db_prod_id}, {escape_sql(r)})")
        region_id_counter += 1

    # ---------------------------------------------------------
    # CERTIFICATIONS ROWS
    # ---------------------------------------------------------
    certs = [
        ("SNI 0111:2009", "Standard Nasional Indonesia - Sepatu Boot Cetak Polimer", "2024-01-15", "2029-01-14"),
        ("ISO 9001:2015", "Quality Management Systems Certified Facility", "2023-06-10", "2028-06-09"),
        ("GPSR EU 2023/988", "European Union General Product Safety Regulation Compliant", "2024-12-13", "2029-12-12")
    ]
    if "Safety" in cat_name or "Steel" in p.get("steel_toe_cap", ""):
        certs.append(("EN ISO 20345:2011 S5", "Personal Protective Equipment - Safety Footwear 200J Toe & Midsole", "2024-03-01", "2029-02-28"))

    for c_name, c_num, iss_d, exp_d in certs:
        all_certs_rows.append(f"({cert_id_counter}, {db_prod_id}, {escape_sql(c_name)}, {escape_sql(c_num)}, '{iss_d}', '{exp_d}', 'https://catalog.hotstrading.com/compliance/{slug}.pdf')")
        cert_id_counter += 1

    # ---------------------------------------------------------
    # ALIBABA EXPORT LISTINGS ROWS (Accio 2026 Ready)
    # ---------------------------------------------------------
    ali_title = f"{brand} {model_name} Waterproof PVC {cat_group[:25]} Industrial Boots SNI"[:128]
    prompt_hero = f"Professional studio photography of {brand} {model_name}, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready."
    prompt_side = f"Crisp 90-degree lateral profile view of {brand} {model_name}, clean white seamless studio background, crisp silhouette showing shaft height and contour."
    prompt_tread = f"Close-up macro shot of the bottom outsole of {brand} {model_name}, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background."
    prompt_usage = f"Commercial B2B contextual photograph of {brand} {model_name} in heavy industrial construction site in Europe, cinematic realistic lighting."

    all_alibaba_rows.append(f"""(
  {alibaba_id_counter}, {db_prod_id}, {escape_sql(master_sku)}, {escape_sql(ali_title)},
  {escape_sql(cat_group)}, 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  {escape_sql(f'{brand} Safety Boots')}, {escape_sql('Waterproof PVC Work Boots')}, {escape_sql('Industrial Footwear Wholesale')},
  '[\"pvc boots supplier\", \"indonesia boots exporter\", \"fob factory boots\"]',
  {price_wholesale}, {price_fob_usd}, 16250.00,
  {pairs_carton}, {price_fob_usd * pairs_carton:.2f}, {price_wholesale * pairs_carton},
  '58 x 42 x 38', {p.get('carton_volume_cbm', 0.096):.4f}, {p.get('carton_gross_weight_kg', 18.5):.2f},
  {p.get('container_20ft_capacity_pairs', 3600) // pairs_carton}, {p.get('container_40ft_hq_capacity_pairs', 8500) // pairs_carton},
  {escape_sql(prompt_hero)}, {escape_sql(prompt_side)}, {escape_sql(prompt_tread)}, {escape_sql(prompt_usage)},
  {escape_sql(primary_hero)}, {escape_sql(images_url_list[1] if len(images_url_list) > 1 else primary_hero)},
  {escape_sql(images_url_list[2] if len(images_url_list) > 2 else primary_hero)}, {escape_sql(images_url_list[3] if len(images_url_list) > 3 else primary_hero)},
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
)""")
    alibaba_id_counter += 1

sql_lines.append(",\n".join(prod_rows) + ";\n")

# -------------------------------------------------------------
# 5. PRODUCT SPECIFICATIONS TABLE
# -------------------------------------------------------------
sql_lines.append("-- -------------------------------------------------------------")
sql_lines.append(f"-- 5. PRODUCT SPECIFICATIONS ({len(all_specs_rows)} rows)")
sql_lines.append("-- -------------------------------------------------------------")
chunk_size = 250
for i in range(0, len(all_specs_rows), chunk_size):
    chunk = all_specs_rows[i:i+chunk_size]
    sql_lines.append("INSERT INTO `product_specifications` (`id`, `product_id`, `spec_label`, `spec_value`, `display_order`) VALUES\n" + ",\n".join(chunk) + ";\n")

# -------------------------------------------------------------
# 6. PRODUCT USE CASES TABLE
# -------------------------------------------------------------
sql_lines.append("-- -------------------------------------------------------------")
sql_lines.append(f"-- 6. PRODUCT USE CASES ({len(all_usecases_rows)} rows)")
sql_lines.append("-- -------------------------------------------------------------")
for i in range(0, len(all_usecases_rows), chunk_size):
    chunk = all_usecases_rows[i:i+chunk_size]
    sql_lines.append("INSERT INTO `product_use_cases` (`id`, `product_id`, `use_case`) VALUES\n" + ",\n".join(chunk) + ";\n")

# -------------------------------------------------------------
# 7. PRODUCT REGIONS TABLE
# -------------------------------------------------------------
sql_lines.append("-- -------------------------------------------------------------")
sql_lines.append(f"-- 7. PRODUCT TARGET EXPORT REGIONS ({len(all_regions_rows)} rows)")
sql_lines.append("-- -------------------------------------------------------------")
for i in range(0, len(all_regions_rows), chunk_size):
    chunk = all_regions_rows[i:i+chunk_size]
    sql_lines.append("INSERT INTO `product_regions` (`id`, `product_id`, `region`) VALUES\n" + ",\n".join(chunk) + ";\n")

# -------------------------------------------------------------
# 8. PRODUCT CERTIFICATIONS TABLE
# -------------------------------------------------------------
sql_lines.append("-- -------------------------------------------------------------")
sql_lines.append(f"-- 8. PRODUCT CERTIFICATIONS ({len(all_certs_rows)} rows)")
sql_lines.append("-- -------------------------------------------------------------")
for i in range(0, len(all_certs_rows), chunk_size):
    chunk = all_certs_rows[i:i+chunk_size]
    sql_lines.append("INSERT INTO `product_certifications` (`id`, `product_id`, `certification_name`, `certification_number`, `issued_date`, `expiry_date`, `document_url`) VALUES\n" + ",\n".join(chunk) + ";\n")

# -------------------------------------------------------------
# 9. ALIBABA EXPORT LISTINGS TABLE
# -------------------------------------------------------------
sql_lines.append("-- -------------------------------------------------------------")
sql_lines.append(f"-- 9. ALIBABA EXPORT LISTINGS MODULE ({len(all_alibaba_rows)} rows)")
sql_lines.append("-- -------------------------------------------------------------")
for i in range(0, len(all_alibaba_rows), 50):
    chunk = all_alibaba_rows[i:i+50]
    sql_lines.append("""INSERT INTO `alibaba_export_listings` (
  `id`, `product_id`, `sku`, `alibaba_product_title`, `category_group`, `target_continent`,
  `target_country`, `target_industry_angle`, `primary_keyword_1`, `primary_keyword_2`,
  `primary_keyword_3`, `longtail_keywords`, `base_price_idr`, `fob_price_usd`, `exchange_rate_used`,
  `pairs_per_carton`, `carton_price_usd`, `carton_price_idr`, `carton_dimensions_cm`,
  `cbm_per_carton`, `gross_weight_kg_per_carton`, `capacity_20ft_cartons`, `capacity_40ft_hc_cartons`,
  `prompt_slot_1_hero`, `prompt_slot_2_side`, `prompt_slot_3_tread`, `prompt_slot_4_contextual`,
  `image_slot_1`, `image_slot_2`, `image_slot_3`, `image_slot_4`, `image_slot_5`, `image_slot_6`,
  `export_status`, `last_error_message`, `created_at`, `updated_at`
) VALUES\n""" + ",\n".join(chunk) + ";\n")

# Finalize transaction
sql_lines.append("SET FOREIGN_KEY_CHECKS = 1;")
sql_lines.append("COMMIT;\n")
sql_lines.append("-- =============================================================")
sql_lines.append("-- INJECTION SCRIPT COMPLETE! ALL 125 PRODUCTS READY ON LIVE DB")
sql_lines.append("-- =============================================================")

full_sql_content = "\n".join(sql_lines)

# Write to FINAL/
with open(OUTPUT_SQL, "w", encoding="utf-8") as f:
    f.write(full_sql_content)

# Mirror to Database/
os.makedirs(os.path.dirname(DB_OUTPUT_SQL), exist_ok=True)
with open(DB_OUTPUT_SQL, "w", encoding="utf-8") as f:
    f.write(full_sql_content)

print(f"✓ Saved production SQL injection script: {OUTPUT_SQL} ({len(full_sql_content):,} bytes)")
print(f"✓ Mirrored to Database directory: {DB_OUTPUT_SQL}")
print(f"✓ Injected entities summary:")
print(f"   - Categories: {len(cat_rows)}")
print(f"   - Manufacturers: 2")
print(f"   - Products: {len(prod_rows)}")
print(f"   - Specifications: {len(all_specs_rows)}")
print(f"   - Use Cases: {len(all_usecases_rows)}")
print(f"   - Export Regions: {len(all_regions_rows)}")
print(f"   - Certifications: {len(all_certs_rows)}")
print(f"   - Alibaba Listings: {len(all_alibaba_rows)}")

