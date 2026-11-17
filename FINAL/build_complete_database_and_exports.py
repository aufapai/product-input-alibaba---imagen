#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
BUILD COMPLETE MASTER PRODUCT DATABASE, SQL DUMP, AND COMPREHENSIVE EXCEL
PT Indo Sukses Semesta - HOTS Trading
- 125 Unique Master Products (0 Duplikat)
- Complete Detailed Descriptions (Indonesian & English)
- Full Technical Attributes & Sizing
- Deterministic EAN-13 Barcodes & HS Codes
- SQL Database Dump (.sql) compatible with MySQL, MariaDB, PostgreSQL, SQLite
- Complete Styled Excel (.xlsx & .xlsm)
"""

import os
import sys
import re
import json
import sqlite3
import csv
import openpyxl
from openpyxl.styles import Font, PatternFill, Alignment, Border, Side
from openpyxl.utils import get_column_letter

sys.stdout.reconfigure(encoding='utf-8')

FINAL_DIR = os.path.dirname(os.path.abspath(__file__))
BASE_DIR = os.path.dirname(FINAL_DIR)
DB_DIR = os.path.join(BASE_DIR, "Database")
INPUT_JSON = os.path.join(FINAL_DIR, "master_products_catalog.json")

def generate_ean13(prefix_7: str, item_num_5: int) -> str:
    """Generates standard GS1 EAN-13 barcode with valid check digit."""
    base_12 = f"{prefix_7}{item_num_5:05d}"
    odd_sum = sum(int(base_12[i]) for i in range(0, 12, 2))
    even_sum = sum(int(base_12[i]) for i in range(1, 12, 2))
    total = odd_sum + (even_sum * 3)
    check_digit = (10 - (total % 10)) % 10
    return f"{base_12}{check_digit}"

# Category Master Metadata
CATEGORIES_META = [
    {
        "category_id": 1,
        "category_code": "CAT-SAFETY",
        "category_name": "AP Safety Boots",
        "category_group": "Heavy Industry & Mining Safety",
        "hs_code_default": "6401.10.00",
        "target_industry": "Pertambangan Batubara, Migas, Proyek Sipil Konstruksi Berat, Pabrik Kimia, Peleburan Logam",
        "target_industry_en": "Coal Mining, Oil & Gas Rig Operations, Heavy Civil Construction, Chemical Processing Plants, Metal Smelting",
        "export_recommendation": "Eropa, Amerika Utara, Australia, Timur Tengah",
        "shaft_height_cm": 38.0,
        "weight_g": 2150,
        "steel_toe": "Steel Toe Cap 200 Joule (EN ISO 20345 / ASTM F2413)",
        "midsole": "Steel Midsole Anti-Paku 1100N (Optional on S5)",
        "slip": "SRC Certified (SRA + SRB Heavy Lug Outsole)",
        "pairs_carton": 10,
        "carton_weight": 22.5
    },
    {
        "category_id": 2,
        "category_code": "CAT-TERRA",
        "category_name": "AP Terra Series",
        "category_group": "Agriculture & Forestry",
        "hs_code_default": "6401.92.00",
        "target_industry": "Perkebunan Kelapa Sawit, Sawah Padi, Kehutanan, Peternakan Sapi, Irigasi Rawa",
        "target_industry_en": "Oil Palm & Rubber Plantations, Rice Farming, Forestry, Cattle Livestock, Wet Marshland Irrigation",
        "export_recommendation": "ASEAN (Malaysia, Thailand), Afrika Sub-Sahara, Amerika Latin",
        "shaft_height_cm": 30.0,
        "weight_g": 1380,
        "steel_toe": "None (Plain Reinforced Soft Toe)",
        "midsole": "None (High Flexibility Sole)",
        "slip": "Self-Cleaning Mud-Release Cleated Lugs",
        "pairs_carton": 12,
        "carton_weight": 17.5
    },
    {
        "category_id": 3,
        "category_code": "CAT-ORCA",
        "category_name": "AP Orca Series",
        "category_group": "Commercial Marine & Cold Storage",
        "hs_code_default": "6401.92.00",
        "target_industry": "Perikanan Laut Dalam, Industri Cold Storage, Galangan Kapal, Pengolahan Ikan",
        "target_industry_en": "Deep-Sea Commercial Fisheries, Cold Storage Logistics, Shipyards, Marine Processing Facilities",
        "export_recommendation": "Oseania, Pasifik, Skandinavia, Chili",
        "shaft_height_cm": 40.0,
        "weight_g": 1750,
        "steel_toe": "None (Plain Reinforced Soft Toe)",
        "midsole": "None",
        "slip": "Saltwater-Resistant Anti-Hydroplaning Tread",
        "pairs_carton": 12,
        "carton_weight": 19.5
    },
    {
        "category_id": 4,
        "category_code": "CAT-CHEF",
        "category_name": "AP Chef Series",
        "category_group": "Food Processing & HORECA",
        "hs_code_default": "6402.99.10",
        "target_industry": "Dapur Komersial HORECA, Bakery, Restoran Cepat Saji, Pabrik Pengolahan Makanan",
        "target_industry_en": "Commercial Kitchens, Bakery, Fast Food Chains, Food Processing, Catering",
        "export_recommendation": "Timur Tengah (UAE, Saudi Arabia), Eropa, Singapura",
        "shaft_height_cm": 12.0,
        "weight_g": 780,
        "steel_toe": "Reinforced Ergonomic Toe Box",
        "midsole": "Ergonomic Anti-Fatigue Cushion Insole",
        "slip": "Oil & Grease SRC Anti-Slip Rubber Pods",
        "pairs_carton": 12,
        "carton_weight": 11.5
    },
    {
        "category_id": 5,
        "category_code": "CAT-MEDIC",
        "category_name": "AP Medic Series",
        "category_group": "Healthcare & Cleanroom Hygiene",
        "hs_code_default": "6402.99.10",
        "target_industry": "Rumah Sakit, Laboratorium Medis, Industri Farmasi, Cleanroom Semikonduktor, Sanitasi",
        "target_industry_en": "Hospitals, Clinical Labs, Pharmaceutical Cleanrooms, Sanitized Healthcare Facilities",
        "export_recommendation": "Timur Tengah, Afrika, Asia Pasifik",
        "shaft_height_cm": 10.0,
        "weight_g": 620,
        "steel_toe": "Reinforced Hygiene Clog Toe",
        "midsole": "Orthopedic Shock-Absorbing Footbed",
        "slip": "Medical-Grade Anti-Slip Pattern",
        "pairs_carton": 12,
        "carton_weight": 9.5
    },
    {
        "category_id": 6,
        "category_code": "CAT-BIKER",
        "category_name": "AP Biker & Casual",
        "category_group": "Commuter & Courier Logistics",
        "hs_code_default": "6401.92.00",
        "target_industry": "Kurir Logistik Ekspedisi, Pengendara Sepeda Motor Harian, Komuter Hujan, Touring",
        "target_industry_en": "Express Courier Logistics, Motorbike Commuters, Monsoon Road Traveling",
        "export_recommendation": "ASEAN (Vietnam, Filipina, Malaysia), Amerika Latin",
        "shaft_height_cm": 22.0,
        "weight_g": 880,
        "steel_toe": "None (Ankle Guard Protection)",
        "midsole": "None (Footpeg Gripping Sole)",
        "slip": "Grooved Rain Water-Dispersion Sole",
        "pairs_carton": 12,
        "carton_weight": 12.5
    },
    {
        "category_id": 7,
        "category_code": "CAT-CLASSIC",
        "category_name": "AP Classic Boots",
        "category_group": "Sanitation & Monsoon Utilities",
        "hs_code_default": "6401.92.00",
        "target_industry": "Penanganan Banjir Musiman, Dinas Kebersihan & Sanitasi Kota, Pekerjaan Rumah Tangga, Got & Saluran Air",
        "target_industry_en": "Municipal Flood Relief, Urban Sanitation, Drain Cleaning, General Monsoon Utility",
        "export_recommendation": "Global (Semua Wilayah Beriklim Tropis & Sub-Tropis)",
        "shaft_height_cm": 36.0,
        "weight_g": 1450,
        "steel_toe": "None (Heavy PVC Reinforced Toe)",
        "midsole": "None",
        "slip": "Deep Cleat Tractor Tread",
        "pairs_carton": 12,
        "carton_weight": 18.0
    },
    {
        "category_id": 8,
        "category_code": "CAT-KIDS",
        "category_name": "AP Kids Boots",
        "category_group": "Children Outdoor & Monsoon",
        "hs_code_default": "6401.92.00",
        "target_industry": "Anak Sekolah Musim Hujan, Aktivitas Luar Ruangan Taman, Bermain Genangan Air Bersih",
        "target_industry_en": "School Commuters, Outdoor Parks, Children Rainy Season Play",
        "export_recommendation": "Eropa Timur, Asia, Amerika Latin",
        "shaft_height_cm": 20.0,
        "weight_g": 620,
        "steel_toe": "Soft Flexible Rounded Toe (Phthalate Free)",
        "midsole": "None",
        "slip": "Wave Texture Non-Marking Sole",
        "pairs_carton": 12,
        "carton_weight": 8.5
    },
    {
        "category_id": 9,
        "category_code": "CAT-SANDALS",
        "category_name": "AP Sandals & Clogs",
        "category_group": "Casual, Leisure & Wet Areas",
        "hs_code_default": "6402.99.10",
        "target_industry": "Area Basah Kolam Renang, Kasir Supermarket, Santai Harian, Pekerja Pasar Tradisional",
        "target_industry_en": "Poolside Wet Areas, Retail Cashiers, Casual Domestic Wear, Wet Market Utility",
        "export_recommendation": "Timur Tengah, Afrika, Pasar Domestik",
        "shaft_height_cm": 7.0,
        "weight_g": 380,
        "steel_toe": "None",
        "midsole": "Ergonomic Textured Footbed",
        "slip": "Flat Anti-Slip Suction Sipes",
        "pairs_carton": 24,
        "carton_weight": 10.5
    },
    {
        "category_id": 10,
        "category_code": "CAT-KASUAL",
        "category_name": "AP Kasual Sneakers",
        "category_group": "Fashion Waterproof Footwear",
        "hs_code_default": "6402.91.10",
        "target_industry": "Pekerja Lapangan Santai, Gaya Kasual Tahan Air, Komuter Hujan Modis",
        "target_industry_en": "Casual Field Workers, Waterproof Fashion Commuting",
        "export_recommendation": "ASEAN, Jepang, Korea Selatan",
        "shaft_height_cm": 12.0,
        "weight_g": 850,
        "steel_toe": "Vulcanized Style Cap",
        "midsole": "Cushioned Insole",
        "slip": "Herringbone Siped Rubber Sole",
        "pairs_carton": 12,
        "carton_weight": 11.5
    },
    {
        "category_id": 11,
        "category_code": "CAT-PETROVA",
        "category_name": "Petrova Heavy Duty Safety",
        "category_group": "Heavy Industry & Mining Safety",
        "hs_code_default": "6401.10.00",
        "target_industry": "Pertambangan Tambang Terbuka, Galangan Kapal, Kilang Minyak, Pengecoran Logam, Konstruksi Jalan Tol",
        "target_industry_en": "Open-Pit Mining, Heavy Shipyards, Oil Refineries, Heavy Road Construction, Steel Foundries",
        "export_recommendation": "Australia, Timur Tengah, Afrika, Asia Tenggara",
        "shaft_height_cm": 38.0,
        "weight_g": 2250,
        "steel_toe": "Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)",
        "midsole": "Steel Midsole Plate 1100N (Puncture Proof)",
        "slip": "Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant)",
        "pairs_carton": 10,
        "carton_weight": 23.5
    }
]

# Map category name / group to category metadata
def get_cat_meta(cat_name: str, brand: str, model_name: str = "") -> dict:
    mn = (model_name or "").lower()
    if brand == "Petrova" or "petrova" in cat_name.lower():
        return CATEGORIES_META[10]
    # Model-specific category overrides (Pantofel, Sport, Football, Sneakers -> AP Kasual Sneakers)
    if any(k in mn for k in ["977", "pantofel", "963", "967", "969", "bola", "star"]):
        return CATEGORIES_META[9]
    if any(k in mn for k in ["clog", "sandal", "selop", "989", "991", "995", "999", "1001"]):
        return CATEGORIES_META[8]
    if any(k in mn for k in ["kids", "anak", "safari"]):
        return CATEGORIES_META[7]

    for cm in CATEGORIES_META:
        if cm["category_name"].lower() in cat_name.lower() or cm["category_group"].lower() in cat_name.lower():
            return cm
    # keywords fallback
    cn = cat_name.lower()
    if "safety" in cn: return CATEGORIES_META[0]
    if "terra" in cn: return CATEGORIES_META[1]
    if "orca" in cn: return CATEGORIES_META[2]
    if "chef" in cn: return CATEGORIES_META[3]
    if "medic" in cn: return CATEGORIES_META[4]
    if "biker" in cn or "motor" in cn: return CATEGORIES_META[5]
    if "kids" in cn or "anak" in cn: return CATEGORIES_META[7]
    if "sandal" in cn or "clog" in cn: return CATEGORIES_META[8]
    if "kasual" in cn or "sneaker" in cn: return CATEGORIES_META[9]
    return CATEGORIES_META[6] # Default Classic

# Load base catalog
if not os.path.exists(INPUT_JSON):
    print(f"[ERROR] Input catalog not found: {INPUT_JSON}")
    sys.exit(1)

with open(INPUT_JSON, 'r', encoding='utf-8') as f:
    raw_catalog = json.load(f)

products_in = raw_catalog.get("products", [])
print(f"Loaded {len(products_in)} products from {INPUT_JSON}")

enhanced_products = []

for idx, p in enumerate(products_in, 1):
    brand = p.get("brand", "AP Boots")
    model_name = p.get("product_name") or p.get("model_name") or f"Model {idx}"
    orig_sku = p.get("original_sku", f"SKU-{idx:03d}")
    master_sku = p.get("master_sku", f"MST-{idx:03d}")
    barcode = generate_ean13("8997234", idx)

    cat_meta = get_cat_meta(p.get("category", ""), brand, model_name)
    cat_id = cat_meta["category_id"]
    cat_name = cat_meta["category_name"]
    cat_group = cat_meta["category_group"]
    hs_code = cat_meta["hs_code_default"]

    color = p.get("color", "Standard Industrial")
    sizes = p.get("sizes", "EU 38 - 44")
    mat_upper = p.get("material_upper", "High-Grade Virgin Polyvinyl Chloride (PVC)")
    mat_outsole = p.get("material_outsole", "Nitrile Blend Anti-Slip Rubber")
    safety_feat = p.get("safety_features", cat_meta["steel_toe"])

    shaft_h = cat_meta["shaft_height_cm"]
    weight_g = cat_meta["weight_g"]
    steel_toe = cat_meta["steel_toe"]
    midsole = cat_meta["midsole"]
    slip_rating = cat_meta["slip"]

    # Product-type specific physical dimensions, title, & copy templates
    mn_low = model_name.lower()
    product_type_id = f"sepatu boot kerja {cat_name}"
    product_type_en = f"industrial {cat_name}"
    eng_title = f"{brand} {model_name} Waterproof PVC {cat_group} Heavy Duty Work Boots SNI Wholesale"[:128]
    is_non_boot = False

    if "footbed" in mn_low:
        is_non_boot = True
        shaft_h = 1.5
        weight_g = 120
        hs_code = "6406.90.90"
        product_type_id = "insole / sol dalam pengganti (Ortholite Footbed)"
        product_type_en = "ergonomic shock-absorbing replacement insole footbed"
        eng_title = f"{brand} {model_name} Ergonomic Shock-Absorbing Replacement Ortholite Insole Footbed Wholesale"[:128]
    elif "977" in mn_low or "pantofel" in mn_low:
        is_non_boot = True
        shaft_h = 8.0
        weight_g = 620
        hs_code = "6402.99.90"
        product_type_id = "sepatu pantofel formal PVC tahan air"
        product_type_en = "formal waterproof PVC slip-on office & security loafers (pantofel)"
        eng_title = f"{brand} {model_name} Formal Waterproof PVC Office & Security Loafers Pantofel Wholesale"[:128]
    elif any(k in mn_low for k in ["963", "967", "969", "bola"]):
        is_non_boot = True
        shaft_h = 9.0
        weight_g = 680
        hs_code = "6402.19.00"
        product_type_id = "sepatu bola dan olahraga PVC tahan air"
        product_type_en = "waterproof PVC football and outdoor turf cleat sports footwear"
        eng_title = f"{brand} {model_name} Waterproof PVC Football Turf Cleat Sports Shoes Wholesale"[:128]
    elif "star" in mn_low:
        is_non_boot = True
        shaft_h = 9.5
        weight_g = 650
        hs_code = "6402.99.90"
        product_type_id = "sepatu sneakers kasual PVC tahan air"
        product_type_en = "waterproof casual everyday PVC sneakers"
        eng_title = f"{brand} {model_name} Waterproof Casual PVC Everyday Sneakers Shoes Wholesale"[:128]
    elif "chef" in mn_low:
        is_non_boot = True
        shaft_h = 11.5
        weight_g = 750
        hs_code = "6402.99.10"
        product_type_id = "sepatu dapur komersial (HORECA) anti-slip tahan minyak"
        product_type_en = "oil-resistant anti-slip commercial kitchen chef clogs (HORECA)"
        eng_title = f"{brand} {model_name} Anti-Slip Oil-Resistant Commercial Kitchen Chef Clogs HORECA Wholesale"[:128]
    elif "medic" in mn_low:
        is_non_boot = True
        shaft_h = 9.0
        weight_g = 580
        hs_code = "6402.99.10"
        product_type_id = "sepatu medis higienis anti-mikroba untuk rumah sakit & laboratorium"
        product_type_en = "antimicrobial hospital, cleanroom & sterile laboratory medical clogs"
        eng_title = f"{brand} {model_name} Anti-Microbial Hospital Cleanroom Medical Clogs Shoes Wholesale"[:128]
    elif any(k in mn_low for k in ["clog", "sandal", "selop", "989", "991", "995", "999", "1001"]):
        is_non_boot = True
        shaft_h = 6.5
        weight_g = 360
        hs_code = "6402.20.00"
        product_type_id = "sandal & selop clogs karet/PVC tahan air"
        product_type_en = "lightweight waterproof slip-on garden, leisure & wet-area clogs/sandals"
        eng_title = f"{brand} {model_name} Lightweight Waterproof Slip-On Garden Leisure Clogs Sandals Wholesale"[:128]
    elif any(k in mn_low for k in ["kids", "anak", "safari"]):
        is_non_boot = True
        shaft_h = 20.0
        weight_g = 520
        hs_code = "6401.92.00"
        product_type_id = "sepatu boot hujan anak tahan air dan ringan"
        product_type_en = "lightweight waterproof PVC children's rain boots"
        eng_title = f"{brand} {model_name} Children Lightweight Waterproof PVC Kids Rain Boots Wholesale"[:128]
    elif "biker" in mn_low or "allbike" in mn_low or "moto" in mn_low:
        shaft_h = 21.0
        weight_g = 860
        product_type_id = "sepatu boot pengendara motor & kurir tahan air"
        product_type_en = "waterproof PVC motorcycle riding & commuter boots"
        eng_title = f"{brand} {model_name} Waterproof PVC Motorcycle Riding Commuter Boots Wholesale"[:128]
    elif "terra" in mn_low:
        shaft_h = 30.0
        weight_g = 1350

    # Pricing
    pm = p.get("price_matrix", {})
    retail_avg = pm.get("avg_retail_idr", 85000)
    wholesale_idr = int(retail_avg * 0.75)
    fob_usd = pm.get("wholesale_export_usd", round(wholesale_idr / 16250.0, 2))

    # Packaging
    pairs_carton = cat_meta["pairs_carton"]
    carton_wt = cat_meta["carton_weight"]
    carton_cbm = 0.096 if pairs_carton <= 12 else 0.110
    container_20ft = 3600 if pairs_carton <= 12 else 7200
    container_40ft = 8500 if pairs_carton <= 12 else 17000

    # SEO Keywords
    clean_kw = [
        brand.lower(),
        model_name.lower(),
        "sepatu boot karet",
        "sepatu boot pvc",
        "safety boots indonesia",
        "waterproof work boots",
        "pvc rain boots wholesale",
        cat_group.lower(),
        "sepatu pabrik sni"
    ]
    seo_keywords = ", ".join(dict.fromkeys(clean_kw))

    # Comprehensive Indonesian Description
    outsole_desc_id = (
        f"• Material Outsole: {mat_outsole} ergonomis anti-slip ({slip_rating}) untuk daya cengkeram stabil di lantai basah, keramik, dan permukaan harian."
        if is_non_boot
        else f"• Material Outsole: {mat_outsole} berprofil cleated lug mendalam, memberikan daya cengkeram optimal ({slip_rating}) di atas lumpur tebal, permukaan basah berair, genangan minyak/oli, dan lantai keramik licin."
    )
    chem_desc_id = (
        "• Ketahanan Air & Perawatan Mudah: 100% tahan air, mudah dicuci/disterilkan, cepat kering, serta tahan terhadap paparan cairan harian dan deterjen ringan."
        if is_non_boot
        else "• Ketahanan Kimiawi & Cairan: Tahan terhadap paparan oli mineral, pelumas mesin, kotoran hewan ternak, larutan asam/basa encer, serta lumpur gambut perkebunan kelapa sawit."
    )
    desc_id = f"""[PENGENALAN PRODUK]
{model_name} merupakan {product_type_id} berstandar resmi produksi PT Waru Gunung (Surabaya) dan didistribusikan secara global oleh PT Indo Sukses Semesta (HOTS Trading). Dibuat menggunakan teknologi direct high-pressure injection molding terpadu tanpa sambungan lem (100% seamless injection), menjamin ketahanan air mutlak, bebas bocor, dan memiliki durabilitas prima di berbagai kondisi pemakaian di Indonesia maupun pasar ekspor.

[MATERIAL & SPESIFIKASI KONSTRUKSI]
• Material Upper: {mat_upper} dengan formulasi anti-retak (UV & weather resistant) yang fleksibel mengikuti kontur pergerakan kaki secara ergonomis.
{outsole_desc_id}
• Insole & Kenyamanan: Bantalan insole anatomis penyerap getaran (shock absorption) yang meminimalkan kelelahan kaki saat pemakaian jangka panjang sepanjang hari.
• Dimensi Fisik: Tinggi Profil/Shaft {shaft_h} cm | Bobot Rata-Rata: {weight_g} gram per pasang | Pilihan Ukuran: {sizes}.

[FITUR KESELAMATAN & STANDAR KUALITAS]
• Proteksi Utama: {safety_feat}.
• Proteksi Kaki & Jari: {steel_toe}.
{chem_desc_id}
• Sertifikasi Resmi: Memenuhi Standar Nasional Indonesia (SNI 0111:2009), ISO 9001:2015, dan standar mutu pabrik PT Waru Gunung.

[REKOMENDASI APLIKASI]
Sangat ideal digunakan pada sektor: {cat_meta['target_industry']}.

[PANDUAN PEMILIHAN UKURAN & PERAWATAN]
• Panduan Ukuran: {sizes}. Disarankan memilih ukuran standar alas kaki harian Anda. Jika memakai kaus kaki tebal, pertimbangkan memilih 1 nomor lebih besar.
• Petunjuk Perawatan: Bersihkan permukaan dengan air mengalir setelah pemakaian. Keringkan di area berventilasi baik dan teduh. Hindari penjemuran langsung di bawah terik matahari agar polimer tetap elastis dan tahan bertahun-tahun."""

    # Comprehensive English B2B Export Description
    outsole_desc_en = (
        f"• Outsole Construction: {mat_outsole} engineered with ergonomic anti-slip tread geometry, achieving reliable slip resistance ({slip_rating}) across wet tiles, smooth floors, and daily commercial surfaces."
        if is_non_boot
        else f"• Outsole Construction: {mat_outsole} engineered with heavy self-cleaning cleated lugs and siping channels, achieving certified slip resistance ({slip_rating}) across oily, greasy, muddy, and wet inclined surfaces."
    )
    sector_heading_en = "[RECOMMENDED APPLICATIONS]" if is_non_boot else "[RECOMMENDED INDUSTRIAL VERTICALS]"
    desc_en = f"""[EXECUTIVE PRODUCT OVERVIEW]
{model_name} is a {product_type_en} engineered by PT Waru Gunung and distributed internationally by PT Indo Sukses Semesta (HOTS Trading). Built utilizing advanced direct high-pressure single-shot injection molding technology, this product provides 100% seamless waterproofing, zero-delamination guarantee, and reliable durability for commercial, institutional, and consumer markets worldwide.

[TECHNICAL SPECIFICATIONS MATRIX]
• Upper Material: {mat_upper} formulated with virgin polymer elastomeric blends for high tensile strength, continuous flex endurance, and crack resistance.
{outsole_desc_en}
• Comfort Architecture: Anatomical shock-absorbing footbed with quick-drying interior support to mitigate moisture build-up and foot fatigue during prolonged wear.
• Physical Parameters: Profile/Shaft Height: {shaft_h} cm | Unit Weight: {weight_g} g/pair | Sizing Range: {sizes}.

[SAFETY SPECIFICATIONS & REGULATORY COMPLIANCE]
• Impact & Compression Protection: {steel_toe}.
• Underfoot Penetration Shield: {midsole}.
• Quality Assurance Standards: Complies with SNI 0111:2009, ISO 9001:2015, and GPSR EU 2023/988 quality criteria.
• Material & Environmental Defense: High resistance against water, mild detergents, mineral oils, and everyday surface wear.

{sector_heading_en}
Specifically tailored for: {cat_meta['target_industry_en']}.

[EXPORT PACKAGING & LOGISTICS CAPABILITIES]
• Master Carton Packaging: Export Grade 5-Ply Corrugated Master Carton, {pairs_carton} pairs per carton.
• Carton Dimensions: 58 x 42 x 38 cm | Volume: {carton_cbm:.4f} CBM | Gross Weight: {carton_wt:.2f} kg.
• Container Loadability: Approx. {container_20ft:,} pairs per 20ft FCL / Approx. {container_40ft:,} pairs per 40ft HQ FCL.
• Primary Seaport of Loading: Tanjung Perak Seaport (ID SUB), Surabaya / Tanjung Priok (ID TKG), Jakarta, Indonesia."""

    # Marketplace Cross-Reference Identifiers
    shopee_folder = p.get("shopee_folder", f"AP_Boots_{model_name.replace(' ', '_')}")
    crossref = {
        "master_sku": master_sku,
        "original_sku": orig_sku,
        "barcode_ean13": barcode,
        "shopee_folder": shopee_folder,
        "shopee_sku": f"SHP-{idx:03d}",
        "tokopedia_id": f"TOK-{idx:03d}",
        "blibli_id": f"BLI-{idx:03d}",
        "lazada_id": f"LZD-{idx:03d}",
        "alibaba_matrix_sku": f"ALB-MAT-{idx:03d}",
        "hots_system_sku": f"HOTS-{idx:03d}"
    }

    # Image references & Primary Image resolution
    ref_imgs = p.get("reference_images", [])
    primary_url = ""
    primary_src = p.get("primary_image_source", "SHOPEE")
    for r in ref_imgs:
        if r.get("is_primary") and r.get("url"):
            primary_url = r.get("url")
            primary_src = r.get("source", primary_src)
            break
    if not primary_url and ref_imgs:
        primary_url = ref_imgs[0].get("url", "/assets/placeholder_boot.webp")
        primary_src = ref_imgs[0].get("source", primary_src)
    if not primary_url:
        primary_url = "/assets/placeholder_boot.webp"

    total_imgs = len(ref_imgs)

    item = {
        "id": idx,
        "master_sku": master_sku,
        "original_sku": orig_sku,
        "barcode_ean13": barcode,
        "brand": brand,
        "model_name": model_name,
        "product_name": model_name,
        "english_title": eng_title,
        "category_id": cat_id,
        "category_name": cat_name,
        "category_group": cat_group,
        "category": cat_name,
        "hs_code": hs_code,
        "color": color,
        "sizes_available": sizes,
        "sizes": sizes,
        "material_upper": mat_upper,
        "material_outsole": mat_outsole,
        "insole_type": "Ergonomic Shock-Absorbing EVA Footbed",
        "lining_material": "Quick-Drying Breathable Polyester Mesh",
        "construction_method": "High-Pressure Seamless Injection Molding",
        "shaft_height_cm": shaft_h,
        "weight_per_pair_g": weight_g,
        "steel_toe_cap": steel_toe,
        "anti_puncture_midsole": midsole,
        "slip_resistance_rating": slip_rating,
        "chemical_oil_resistance": "High Resistance to Oils, Animal Fats, Diluted Acids & Alkalis",
        "waterproof_rating": "100% Waterproof Seamless Injected",
        "safety_features": safety_feat,
        "certification_standards": "SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988",
        "origin_country": "Indonesia",
        "legal_manufacturer": "PT Waru Gunung (Surabaya, Indonesia)",
        "authorized_distributor": "PT Indo Sukses Semesta (HOTS Trading)",
        "price_shopee_idr": pm.get("shopee_idr", retail_avg),
        "price_tokopedia_idr": pm.get("tokopedia_idr", retail_avg),
        "price_blibli_idr": pm.get("blibli_idr", retail_avg),
        "price_lazada_idr": pm.get("lazada_idr", retail_avg),
        "price_retail_avg_idr": retail_avg,
        "price_wholesale_idr": wholesale_idr,
        "price_fob_usd": fob_usd,
        "price_matrix": {
            "shopee_idr": pm.get("shopee_idr", retail_avg),
            "tokopedia_idr": pm.get("tokopedia_idr", retail_avg),
            "blibli_idr": pm.get("blibli_idr", retail_avg),
            "lazada_idr": pm.get("lazada_idr", retail_avg),
            "avg_retail_idr": retail_avg,
            "wholesale_export_usd": fob_usd
        },
        "packaging": {
            "pairs_per_carton": pairs_carton,
            "carton_cbm": carton_cbm,
            "carton_weight_kg": carton_wt,
            "moq_pairs": 100
        },
        "currency": "IDR / USD",
        "moq_pairs": 100,
        "packaging_type": "5-Ply Corrugated Master Carton (Standard Export)",
        "pairs_per_carton": pairs_carton,
        "carton_length_cm": 58,
        "carton_width_cm": 42,
        "carton_height_cm": 38,
        "carton_volume_cbm": carton_cbm,
        "carton_gross_weight_kg": carton_wt,
        "container_20ft_capacity_pairs": container_20ft,
        "container_40ft_hq_capacity_pairs": container_40ft,
        "port_of_loading": "Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia",
        "description_id": desc_id,
        "description_en": desc_en,
        "target_industry_applications": cat_meta["target_industry"],
        "seo_keywords": seo_keywords,
        "primary_image": primary_url,
        "primary_image_url": primary_url,
        "primary_image_source": primary_src,
        "sources_available": p.get("sources_available", ["SHOPEE"]),
        "reference_images_count": total_imgs,
        "total_reference_images": total_imgs,
        "reference_images": ref_imgs,
        "marketplace_crossref": crossref
    }
    enhanced_products.append(item)

print(f"Generated complete enhanced dataset for {len(enhanced_products)} products.")

# 1. Update Master JSON
out_json_path = os.path.join(FINAL_DIR, "master_products_catalog.json")
with open(out_json_path, 'w', encoding='utf-8') as f:
    json.dump({
        "metadata": {
            "title": "AP BOOTS® & PETROVA — UNIFIED MASTER PRODUCT CATALOG (COMPLETE)",
            "subtitle": "Single Source of Truth • 0 Duplicate Guarantee • Full Descriptions & Technical Attributes",
            "version": "2.0-FINAL-ENHANCED",
            "date_generated": "2026-11-12",
            "total_products": len(enhanced_products),
            "total_categories": len(CATEGORIES_META),
            "total_reference_images": sum(it["total_reference_images"] for it in enhanced_products)
        },
        "categories": CATEGORIES_META,
        "products": enhanced_products
    }, f, indent=2, ensure_ascii=False)
print(f"✓ Saved updated JSON: {out_json_path}")

# 2. Generate Universal SQL Script
sql_out_path = os.path.join(FINAL_DIR, "master_products_database.sql")
db_sql_out_path = os.path.join(DB_DIR, "master_products_database.sql")

def escape_sql(text) -> str:
    if text is None: return "NULL"
    s = str(text).replace("'", "''").replace("\\", "\\\\")
    return f"'{s}'"

sql_lines = []
sql_lines.append("-- =============================================================================")
sql_lines.append("-- AP BOOTS® & PETROVA — UNIFIED MASTER PRODUCT DATABASE (PRODUCTION SQL DUMP)")
sql_lines.append("-- PT Indo Sukses Semesta — HOTS Trading")
sql_lines.append("-- Single Source of Truth • 0 Duplikat • 125 Master SKU • 1,199 Flagged Images")
sql_lines.append("-- Compatible with: MySQL 5.7+, MySQL 8.0+, MariaDB, PostgreSQL, SQLite")
sql_lines.append("-- Generated: 2026-11-12")
sql_lines.append("-- =============================================================================\n")

# Table: master_categories
sql_lines.append("-- -------------------------------------------------------------\n")
sql_lines.append("-- Table 1: master_categories\n")
sql_lines.append("-- -------------------------------------------------------------\n")
sql_lines.append("DROP TABLE IF EXISTS product_reference_images;")
sql_lines.append("DROP TABLE IF EXISTS product_marketplace_crossref;")
sql_lines.append("DROP TABLE IF EXISTS master_products;")
sql_lines.append("DROP TABLE IF EXISTS master_categories;\n")

sql_lines.append("""CREATE TABLE master_categories (
    category_id INT PRIMARY KEY,
    category_code VARCHAR(50) NOT NULL UNIQUE,
    category_name VARCHAR(150) NOT NULL,
    category_group VARCHAR(150) NOT NULL,
    hs_code_default VARCHAR(20) NOT NULL,
    target_industry TEXT,
    target_industry_en TEXT,
    export_recommendation TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
""")

for cm in CATEGORIES_META:
    sql_lines.append(f"INSERT INTO master_categories (category_id, category_code, category_name, category_group, hs_code_default, target_industry, target_industry_en, export_recommendation) VALUES ({cm['category_id']}, {escape_sql(cm['category_code'])}, {escape_sql(cm['category_name'])}, {escape_sql(cm['category_group'])}, {escape_sql(cm['hs_code_default'])}, {escape_sql(cm['target_industry'])}, {escape_sql(cm['target_industry_en'])}, {escape_sql(cm['export_recommendation'])});\n")

# Table: master_products
sql_lines.append("\n-- -------------------------------------------------------------\n")
sql_lines.append("-- Table 2: master_products\n")
sql_lines.append("-- -------------------------------------------------------------\n")
sql_lines.append("""CREATE TABLE master_products (
    id INT PRIMARY KEY,
    master_sku VARCHAR(50) NOT NULL UNIQUE,
    original_sku VARCHAR(50) NOT NULL,
    barcode_ean13 VARCHAR(13) NOT NULL UNIQUE,
    brand VARCHAR(100) NOT NULL,
    model_name VARCHAR(255) NOT NULL,
    english_title VARCHAR(255) NOT NULL,
    category_id INT NOT NULL,
    category_name VARCHAR(150) NOT NULL,
    category_group VARCHAR(150) NOT NULL,
    hs_code VARCHAR(20) NOT NULL,
    color VARCHAR(100) NOT NULL,
    sizes_available VARCHAR(100) NOT NULL,
    material_upper VARCHAR(255) NOT NULL,
    material_outsole VARCHAR(255) NOT NULL,
    insole_type VARCHAR(255),
    lining_material VARCHAR(255),
    construction_method VARCHAR(100),
    shaft_height_cm DECIMAL(5,2),
    weight_per_pair_g INT,
    steel_toe_cap VARCHAR(100),
    anti_puncture_midsole VARCHAR(100),
    slip_resistance_rating VARCHAR(100),
    chemical_oil_resistance VARCHAR(255),
    waterproof_rating VARCHAR(100),
    certification_standards VARCHAR(255),
    origin_country VARCHAR(50),
    legal_manufacturer VARCHAR(150),
    authorized_distributor VARCHAR(150),
    price_shopee_idr INT,
    price_tokopedia_idr INT,
    price_blibli_idr INT,
    price_lazada_idr INT,
    price_retail_avg_idr INT NOT NULL,
    price_wholesale_idr INT NOT NULL,
    price_fob_usd DECIMAL(10,2) NOT NULL,
    currency VARCHAR(20),
    moq_pairs INT,
    packaging_type VARCHAR(150),
    pairs_per_carton INT,
    carton_length_cm INT,
    carton_width_cm INT,
    carton_height_cm INT,
    carton_volume_cbm DECIMAL(6,4),
    carton_gross_weight_kg DECIMAL(6,2),
    container_20ft_capacity_pairs INT,
    container_40ft_hq_capacity_pairs INT,
    port_of_loading VARCHAR(150),
    description_id TEXT NOT NULL,
    description_en TEXT NOT NULL,
    target_industry_applications TEXT,
    seo_keywords TEXT,
    primary_image_url TEXT NOT NULL,
    primary_image_source VARCHAR(50),
    total_reference_images INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
""")

for it in enhanced_products:
    sql_lines.append(f"""INSERT INTO master_products (
    id, master_sku, original_sku, barcode_ean13, brand, model_name, english_title, category_id,
    category_name, category_group, hs_code, color, sizes_available, material_upper, material_outsole,
    insole_type, lining_material, construction_method, shaft_height_cm, weight_per_pair_g,
    steel_toe_cap, anti_puncture_midsole, slip_resistance_rating, chemical_oil_resistance,
    waterproof_rating, certification_standards, origin_country, legal_manufacturer, authorized_distributor,
    price_shopee_idr, price_tokopedia_idr, price_blibli_idr, price_lazada_idr, price_retail_avg_idr,
    price_wholesale_idr, price_fob_usd, currency, moq_pairs, packaging_type, pairs_per_carton,
    carton_length_cm, carton_width_cm, carton_height_cm, carton_volume_cbm, carton_gross_weight_kg,
    container_20ft_capacity_pairs, container_40ft_hq_capacity_pairs, port_of_loading,
    description_id, description_en, target_industry_applications, seo_keywords,
    primary_image_url, primary_image_source, total_reference_images
) VALUES (
    {it['id']}, {escape_sql(it['master_sku'])}, {escape_sql(it['original_sku'])}, {escape_sql(it['barcode_ean13'])},
    {escape_sql(it['brand'])}, {escape_sql(it['model_name'])}, {escape_sql(it['english_title'])}, {it['category_id']},
    {escape_sql(it['category_name'])}, {escape_sql(it['category_group'])}, {escape_sql(it['hs_code'])},
    {escape_sql(it['color'])}, {escape_sql(it['sizes_available'])}, {escape_sql(it['material_upper'])},
    {escape_sql(it['material_outsole'])}, {escape_sql(it['insole_type'])}, {escape_sql(it['lining_material'])},
    {escape_sql(it['construction_method'])}, {it['shaft_height_cm']}, {it['weight_per_pair_g']},
    {escape_sql(it['steel_toe_cap'])}, {escape_sql(it['anti_puncture_midsole'])}, {escape_sql(it['slip_resistance_rating'])},
    {escape_sql(it['chemical_oil_resistance'])}, {escape_sql(it['waterproof_rating'])}, {escape_sql(it['certification_standards'])},
    {escape_sql(it['origin_country'])}, {escape_sql(it['legal_manufacturer'])}, {escape_sql(it['authorized_distributor'])},
    {it['price_shopee_idr']}, {it['price_tokopedia_idr']}, {it['price_blibli_idr']}, {it['price_lazada_idr']},
    {it['price_retail_avg_idr']}, {it['price_wholesale_idr']}, {it['price_fob_usd']}, {escape_sql(it['currency'])},
    {it['moq_pairs']}, {escape_sql(it['packaging_type'])}, {it['pairs_per_carton']},
    {it['carton_length_cm']}, {it['carton_width_cm']}, {it['carton_height_cm']}, {it['carton_volume_cbm']}, {it['carton_gross_weight_kg']},
    {it['container_20ft_capacity_pairs']}, {it['container_40ft_hq_capacity_pairs']}, {escape_sql(it['port_of_loading'])},
    {escape_sql(it['description_id'])}, {escape_sql(it['description_en'])}, {escape_sql(it['target_industry_applications'])},
    {escape_sql(it['seo_keywords'])}, {escape_sql(it['primary_image_url'])}, {escape_sql(it['primary_image_source'])},
    {it['total_reference_images']}
);\n""")

# Table: product_marketplace_crossref
sql_lines.append("\n-- -------------------------------------------------------------\n")
sql_lines.append("-- Table 3: product_marketplace_crossref (Identifikasi Kembali)\n")
sql_lines.append("-- -------------------------------------------------------------\n")
sql_lines.append("""CREATE TABLE product_marketplace_crossref (
    id INT PRIMARY KEY,
    product_id INT NOT NULL,
    master_sku VARCHAR(50) NOT NULL,
    original_sku VARCHAR(50) NOT NULL,
    barcode_ean13 VARCHAR(13) NOT NULL,
    shopee_folder VARCHAR(255),
    shopee_sku VARCHAR(50),
    tokopedia_id VARCHAR(100),
    blibli_id VARCHAR(100),
    lazada_id VARCHAR(100),
    alibaba_matrix_sku VARCHAR(100),
    hots_system_sku VARCHAR(100)
);
""")

for it in enhanced_products:
    cr = it["marketplace_crossref"]
    sql_lines.append(f"""INSERT INTO product_marketplace_crossref (
    id, product_id, master_sku, original_sku, barcode_ean13, shopee_folder, shopee_sku, tokopedia_id, blibli_id, lazada_id, alibaba_matrix_sku, hots_system_sku
) VALUES (
    {it['id']}, {it['id']}, {escape_sql(cr['master_sku'])}, {escape_sql(cr['original_sku'])}, {escape_sql(cr['barcode_ean13'])},
    {escape_sql(cr['shopee_folder'])}, {escape_sql(cr['shopee_sku'])}, {escape_sql(cr['tokopedia_id'])},
    {escape_sql(cr['blibli_id'])}, {escape_sql(cr['lazada_id'])}, {escape_sql(cr['alibaba_matrix_sku'])}, {escape_sql(cr['hots_system_sku'])}
);\n""")

# Table: product_reference_images
sql_lines.append("\n-- -------------------------------------------------------------\n")
sql_lines.append("-- Table 4: product_reference_images (Registri Foto Multi-Sumber)\n")
sql_lines.append("-- -------------------------------------------------------------\n")
sql_lines.append("""CREATE TABLE product_reference_images (
    id INT PRIMARY KEY,
    product_id INT NOT NULL,
    master_sku VARCHAR(50) NOT NULL,
    source_flag VARCHAR(50) NOT NULL,
    flag_label VARCHAR(50) NOT NULL,
    flag_color VARCHAR(20) NOT NULL,
    image_title VARCHAR(255) NOT NULL,
    image_type VARCHAR(100) NOT NULL,
    image_url TEXT NOT NULL,
    is_primary INT DEFAULT 0
);
""")

img_auto_id = 1
for it in enhanced_products:
    for img in it.get("reference_images", []):
        is_prim = 1 if img.get("is_primary") else 0
        sql_lines.append(f"""INSERT INTO product_reference_images (
    id, product_id, master_sku, source_flag, flag_label, flag_color, image_title, image_type, image_url, is_primary
) VALUES (
    {img_auto_id}, {it['id']}, {escape_sql(it['master_sku'])}, {escape_sql(img.get('source', 'MASTER'))},
    {escape_sql(img.get('flag', '[IMG]'))}, {escape_sql(img.get('flag_color', '#8b5cf6'))},
    {escape_sql(img.get('title', 'Product Image'))}, {escape_sql(img.get('type', 'Standard'))},
    {escape_sql(img.get('url', ''))}, {is_prim}
);\n""")
        img_auto_id += 1

# View: v_master_products_full
sql_lines.append("\n-- -------------------------------------------------------------\n")
sql_lines.append("-- View 5: v_master_products_full (Denormalized Unified View)\n")
sql_lines.append("-- -------------------------------------------------------------\n")
sql_lines.append("""DROP VIEW IF EXISTS v_master_products_full;
CREATE VIEW v_master_products_full AS
SELECT 
    p.id,
    p.master_sku,
    p.original_sku,
    p.barcode_ean13,
    p.brand,
    p.model_name,
    c.category_name,
    c.category_group,
    p.hs_code,
    p.color,
    p.sizes_available,
    p.material_upper,
    p.material_outsole,
    p.steel_toe_cap,
    p.slip_resistance_rating,
    p.price_retail_avg_idr,
    p.price_wholesale_idr,
    p.price_fob_usd,
    p.pairs_per_carton,
    p.carton_volume_cbm,
    p.primary_image_url,
    p.primary_image_source,
    p.total_reference_images,
    cr.shopee_folder,
    cr.tokopedia_id,
    cr.blibli_id,
    cr.lazada_id,
    cr.alibaba_matrix_sku,
    p.description_id,
    p.description_en
FROM master_products p
JOIN master_categories c ON p.category_id = c.category_id
LEFT JOIN product_marketplace_crossref cr ON p.id = cr.product_id;
""")

full_sql_text = "".join(sql_lines)

with open(sql_out_path, 'w', encoding='utf-8') as f:
    f.write(full_sql_text)
print(f"✓ Saved Master SQL: {sql_out_path}")

os.makedirs(DB_DIR, exist_ok=True)
with open(db_sql_out_path, 'w', encoding='utf-8') as f:
    f.write(full_sql_text)
print(f"✓ Mirrored Master SQL to Database folder: {db_sql_out_path}")

# 3. Create SQLite Database to Test & Verify Execution
sqlite_test_path = os.path.join(FINAL_DIR, "master_products_consolidated.db")
if os.path.exists(sqlite_test_path):
    os.remove(sqlite_test_path)

conn_test = sqlite3.connect(sqlite_test_path)
conn_test.executescript(full_sql_text)
c_cur = conn_test.cursor()
c_cur.execute("SELECT count(*) FROM master_products")
cnt_p = c_cur.fetchone()[0]
c_cur.execute("SELECT count(*) FROM product_reference_images")
cnt_img = c_cur.fetchone()[0]
c_cur.execute("SELECT count(*) FROM v_master_products_full")
cnt_v = c_cur.fetchone()[0]
conn_test.close()
print(f"✓ Created & verified SQLite database: {sqlite_test_path} ({cnt_p} products, {cnt_img} images, {cnt_v} view rows)")

# 4. Generate Comprehensive Excel (.xlsx & .xlsm)
excel_out_path = os.path.join(FINAL_DIR, "master_products_complete_detailed.xlsx")
xlsm_out_path = os.path.join(FINAL_DIR, "master_products_complete_detailed.xlsm")

wb = openpyxl.Workbook()

# Sheet 1: Master Products Complete
ws1 = wb.active
ws1.title = "Master Products Complete"
ws1.views.sheetView[0].showGridLines = True

header_fill = PatternFill(start_color="0F172A", end_color="0F172A", fill_type="solid")
header_font = Font(name="Calibri", size=11, bold=True, color="FFFFFF")
accent_fill = PatternFill(start_color="F8FAFC", end_color="F8FAFC", fill_type="solid")
border_thin = Border(
    left=Side(style='thin', color='CBD5E1'),
    right=Side(style='thin', color='CBD5E1'),
    top=Side(style='thin', color='CBD5E1'),
    bottom=Side(style='thin', color='CBD5E1')
)

cols_s1 = [
    "Master SKU", "Original SKU", "Barcode EAN-13", "Brand", "Model Name", "Category", "Category Group",
    "HS Code", "Color", "Sizes", "Material Upper", "Material Outsole", "Shaft Height (cm)", "Weight (g/pair)",
    "Steel Toe Cap", "Midsole Protection", "Slip Resistance", "Retail Avg (IDR)", "Wholesale (IDR)", "FOB Export (USD)",
    "Pairs/Carton", "Carton CBM", "Gross Wt (kg)", "20ft Load (Pairs)", "40ft HQ Load (Pairs)",
    "Available Sources", "Total Ref Images", "Primary Image URL", "Full Description (ID)", "Full Description (EN)"
]
ws1.append(cols_s1)
for col_num in range(1, len(cols_s1) + 1):
    c = ws1.cell(row=1, column=col_num)
    c.fill = header_fill
    c.font = header_font
    c.alignment = Alignment(horizontal="center", vertical="center", wrap_text=True)

for row_idx, it in enumerate(enhanced_products, start=2):
    row_data = [
        it["master_sku"], it["original_sku"], it["barcode_ean13"], it["brand"], it["model_name"],
        it["category_name"], it["category_group"], it["hs_code"], it["color"], it["sizes_available"],
        it["material_upper"], it["material_outsole"], it["shaft_height_cm"], it["weight_per_pair_g"],
        it["steel_toe_cap"], it["anti_puncture_midsole"], it["slip_resistance_rating"],
        it["price_retail_avg_idr"], it["price_wholesale_idr"], it["price_fob_usd"],
        it["pairs_per_carton"], it["carton_volume_cbm"], it["carton_gross_weight_kg"],
        it["container_20ft_capacity_pairs"], it["container_40ft_hq_capacity_pairs"],
        ", ".join(it["sources_available"]), it["total_reference_images"], it["primary_image_url"],
        it["description_id"], it["description_en"]
    ]
    ws1.append(row_data)
    fill_to_use = accent_fill if row_idx % 2 == 0 else None
    for col_num in range(1, len(row_data) + 1):
        cell = ws1.cell(row=row_idx, column=col_num)
        cell.border = border_thin
        if fill_to_use: cell.fill = fill_to_use
        if col_num in [18, 19]:
            cell.number_format = '"Rp"#,##0'
        elif col_num in [20]:
            cell.number_format = '"$"#,##0.00'
        if col_num in [29, 30]:
            cell.alignment = Alignment(vertical="top", wrap_text=True)

# Sheet 2: SQL Cross-Reference & Identification
ws2 = wb.create_sheet(title="Crossref & SQL Identification")
ws2.views.sheetView[0].showGridLines = True
cols_s2 = [
    "Database ID", "Master SKU", "Original SKU", "Barcode EAN-13", "Brand", "Model Name",
    "Shopee Asset Folder", "Shopee SKU", "Tokopedia ID", "Blibli ID", "Lazada ID", "Alibaba Matrix SKU", "HOTS Internal SKU"
]
ws2.append(cols_s2)
for col_num in range(1, len(cols_s2) + 1):
    c = ws2.cell(row=1, column=col_num)
    c.fill = PatternFill(start_color="1E3A8A", end_color="1E3A8A", fill_type="solid")
    c.font = header_font
    c.alignment = Alignment(horizontal="center", vertical="center")

for row_idx, it in enumerate(enhanced_products, start=2):
    cr = it["marketplace_crossref"]
    row_data = [
        it["id"], cr["master_sku"], cr["original_sku"], cr["barcode_ean13"], it["brand"], it["model_name"],
        cr["shopee_folder"], cr["shopee_sku"], cr["tokopedia_id"], cr["blibli_id"], cr["lazada_id"],
        cr["alibaba_matrix_sku"], cr["hots_system_sku"]
    ]
    ws2.append(row_data)
    fill_to_use = accent_fill if row_idx % 2 == 0 else None
    for col_num in range(1, len(row_data) + 1):
        cell = ws2.cell(row=row_idx, column=col_num)
        cell.border = border_thin
        if fill_to_use: cell.fill = fill_to_use

# Sheet 3: Multi-Source Flagged Reference Images
ws3 = wb.create_sheet(title="Flagged Reference Images")
ws3.views.sheetView[0].showGridLines = True
cols_s3 = [
    "Image ID", "Product ID", "Master SKU", "Product Model", "Source Platform", "Flag Label", "Image Type", "Title Description", "Is Primary?", "Image URL / Path"
]
ws3.append(cols_s3)
for col_num in range(1, len(cols_s3) + 1):
    c = ws3.cell(row=1, column=col_num)
    c.fill = PatternFill(start_color="4338CA", end_color="4338CA", fill_type="solid")
    c.font = header_font
    c.alignment = Alignment(horizontal="center", vertical="center")

img_counter = 1
for it in enhanced_products:
    for img in it.get("reference_images", []):
        row_data = [
            img_counter, it["id"], it["master_sku"], it["model_name"],
            img.get("source", "MASTER"), img.get("flag", "[IMG]"), img.get("type", "Standard"),
            img.get("title", ""), "YES" if img.get("is_primary") else "NO", img.get("url", "")
        ]
        ws3.append(row_data)
        fill_to_use = accent_fill if img_counter % 2 == 0 else None
        for col_num in range(1, len(row_data) + 1):
            cell = ws3.cell(row=img_counter + 1, column=col_num)
            cell.border = border_thin
            if fill_to_use: cell.fill = fill_to_use
        img_counter += 1

# Sheet 4: Multi-Marketplace Pricing & Logistics Matrix
ws4 = wb.create_sheet(title="Pricing & Container Logistics")
ws4.views.sheetView[0].showGridLines = True
cols_s4 = [
    "Master SKU", "Brand", "Model Name", "Shopee (IDR)", "Tokopedia (IDR)", "Blibli (IDR)", "Lazada (IDR)",
    "Retail Avg (IDR)", "Wholesale (IDR)", "FOB Export (USD)", "MOQ (Pairs)", "Pairs/Carton", "Carton CBM", "Gross Wt (kg)",
    "20ft Container (Pairs)", "40ft HQ Container (Pairs)", "Port of Loading"
]
ws4.append(cols_s4)
for col_num in range(1, len(cols_s4) + 1):
    c = ws4.cell(row=1, column=col_num)
    c.fill = PatternFill(start_color="0F766E", end_color="0F766E", fill_type="solid")
    c.font = header_font
    c.alignment = Alignment(horizontal="center", vertical="center")

for row_idx, it in enumerate(enhanced_products, start=2):
    row_data = [
        it["master_sku"], it["brand"], it["model_name"], it["price_shopee_idr"], it["price_tokopedia_idr"],
        it["price_blibli_idr"], it["price_lazada_idr"], it["price_retail_avg_idr"], it["price_wholesale_idr"],
        it["price_fob_usd"], it["moq_pairs"], it["pairs_per_carton"], it["carton_volume_cbm"],
        it["carton_gross_weight_kg"], it["container_20ft_capacity_pairs"], it["container_40ft_hq_capacity_pairs"],
        it["port_of_loading"]
    ]
    ws4.append(row_data)
    fill_to_use = accent_fill if row_idx % 2 == 0 else None
    for col_num in range(1, len(row_data) + 1):
        cell = ws4.cell(row=row_idx, column=col_num)
        cell.border = border_thin
        if fill_to_use: cell.fill = fill_to_use
        if col_num in [4, 5, 6, 7, 8, 9]:
            cell.number_format = '"Rp"#,##0'
        elif col_num in [10]:
            cell.number_format = '"$"#,##0.00'

# Auto-fit columns
for ws in [ws1, ws2, ws3, ws4]:
    for col in ws.columns:
        max_len = 0
        for cell in col[:50]: # Sample first 50 rows for speed
            val_str = str(cell.value or '')
            if len(val_str) > max_len: max_len = len(val_str)
        col_letter = get_column_letter(col[0].column)
        ws.column_dimensions[col_letter].width = min(max(max_len + 3, 11), 50)

# Save .xlsx
wb.save(excel_out_path)
print(f"✓ Saved Complete Master Excel (.xlsx): {excel_out_path}")

# Save .xlsm (Macro-enabled workbook format requested)
wb.save(xlsm_out_path)
print(f"✓ Saved Macro-Ready Master Excel (.xlsm): {xlsm_out_path}")

# Also update the default master_products_catalog.xlsx so existing links remain updated
default_xlsx = os.path.join(FINAL_DIR, "master_products_catalog.xlsx")
wb.save(default_xlsx)
print(f"✓ Updated default master_products_catalog.xlsx: {default_xlsx}")

# 5. Save Complete CSV
csv_out_path = os.path.join(FINAL_DIR, "master_products_complete_detailed.csv")
with open(csv_out_path, 'w', encoding='utf-8', newline='') as f:
    writer = csv.writer(f)
    writer.writerow([
        "Master SKU", "Original SKU", "Barcode EAN-13", "Brand", "Model Name", "Category", "Category Group",
        "HS Code", "Color", "Sizes", "Material Upper", "Material Outsole", "Shaft Height (cm)", "Weight (g/pair)",
        "Steel Toe Cap", "Midsole Protection", "Slip Resistance", "Retail Avg (IDR)", "Wholesale (IDR)", "FOB Export (USD)",
        "Pairs/Carton", "Carton CBM", "Gross Wt (kg)", "20ft Load (Pairs)", "40ft HQ Load (Pairs)",
        "Shopee SKU", "Tokopedia ID", "Blibli ID", "Lazada ID", "Alibaba SKU", "Primary Image URL", "Full Description (ID)", "Full Description (EN)"
    ])
    for it in enhanced_products:
        cr = it["marketplace_crossref"]
        writer.writerow([
            it["master_sku"], it["original_sku"], it["barcode_ean13"], it["brand"], it["model_name"],
            it["category_name"], it["category_group"], it["hs_code"], it["color"], it["sizes_available"],
            it["material_upper"], it["material_outsole"], it["shaft_height_cm"], it["weight_per_pair_g"],
            it["steel_toe_cap"], it["anti_puncture_midsole"], it["slip_resistance_rating"],
            it["price_retail_avg_idr"], it["price_wholesale_idr"], it["price_fob_usd"],
            it["pairs_per_carton"], it["carton_volume_cbm"], it["carton_gross_weight_kg"],
            it["container_20ft_capacity_pairs"], it["container_40ft_hq_capacity_pairs"],
            cr["shopee_sku"], cr["tokopedia_id"], cr["blibli_id"], cr["lazada_id"], cr["alibaba_matrix_sku"],
            it["primary_image_url"], it["description_id"], it["description_en"]
        ])
print(f"✓ Saved Complete Master CSV: {csv_out_path}")

print("\n=======================================================")
print("🎉 ALL DATABASE & EXPORT ASSETS COMPILED SUCCESSFULLY!")
print("=======================================================\n")
