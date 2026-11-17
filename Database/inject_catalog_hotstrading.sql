-- =============================================================================
-- HOTS TRADING — PRODUCTION DATABASE INJECTION SCRIPT
-- Target Domain: https://catalog.hotstrading.com
-- Target Database: `hotj4796_hotstrading` (MariaDB / MySQL 10.11+ / phpMyAdmin)
-- Generated: 2026-11-12 | Version: 2.5-PRODUCTION-LIVE
-- Total Master Products: 125 SKU (Zero Duplicates)
-- Content: Categories, Manufacturers, Products, Specifications, Use Cases,
--          Export Regions, Certifications, and Alibaba Export Listings
-- =============================================================================

SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';
SET time_zone = '+00:00';
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

START TRANSACTION;

-- -------------------------------------------------------------
-- 1. TAXONOMY CATEGORIES (11 Footwear Categories)
-- -------------------------------------------------------------
INSERT INTO `categories` (`id`, `name`, `slug`, `description`, `created_at`, `updated_at`) VALUES
(11, 'AP Safety Boots', 'safety-footwear', 'Heavy Industry & Mining Safety - Export-grade Indonesian waterproof footwear compliant with SNI and global standards.', NOW(), NOW()),
(12, 'AP Terra Series', 'terra-footwear', 'Agriculture & Forestry - Export-grade Indonesian waterproof footwear compliant with SNI and global standards.', NOW(), NOW()),
(13, 'AP Orca Series', 'orca-footwear', 'Commercial Marine & Cold Storage - Export-grade Indonesian waterproof footwear compliant with SNI and global standards.', NOW(), NOW()),
(14, 'AP Chef Series', 'chef-footwear', 'Food Processing & HORECA - Export-grade Indonesian waterproof footwear compliant with SNI and global standards.', NOW(), NOW()),
(15, 'AP Medic Series', 'medic-footwear', 'Healthcare & Cleanroom Hygiene - Export-grade Indonesian waterproof footwear compliant with SNI and global standards.', NOW(), NOW()),
(16, 'AP Biker & Casual', 'biker-footwear', 'Commuter & Courier Logistics - Export-grade Indonesian waterproof footwear compliant with SNI and global standards.', NOW(), NOW()),
(17, 'AP Classic Boots', 'classic-footwear', 'Sanitation & Monsoon Utilities - Export-grade Indonesian waterproof footwear compliant with SNI and global standards.', NOW(), NOW()),
(18, 'AP Kids Boots', 'kids-footwear', 'Children Outdoor & Monsoon - Export-grade Indonesian waterproof footwear compliant with SNI and global standards.', NOW(), NOW()),
(19, 'AP Sandals & Clogs', 'sandals-footwear', 'Casual, Leisure & Wet Areas - Export-grade Indonesian waterproof footwear compliant with SNI and global standards.', NOW(), NOW()),
(20, 'AP Kasual Sneakers', 'kasual-footwear', 'Fashion Waterproof Footwear - Export-grade Indonesian waterproof footwear compliant with SNI and global standards.', NOW(), NOW()),
(21, 'Petrova Heavy Duty Safety', 'petrova-footwear', 'Heavy Industry & Mining Safety - Export-grade Indonesian waterproof footwear compliant with SNI and global standards.', NOW(), NOW())
ON DUPLICATE KEY UPDATE `name`=VALUES(`name`), `description`=VALUES(`description`), `updated_at`=NOW();

-- -------------------------------------------------------------
-- 2. LEGAL MANUFACTURERS & EXPORT PARTNERS
-- -------------------------------------------------------------
INSERT INTO `manufacturers` (`id`, `name`, `slug`, `country`, `description`, `logo_url`, `created_at`, `updated_at`) VALUES
(1, 'PT Indo Sukses Semesta', 'pt-indo-sukses-semesta', 'Indonesia', 'Global B2B Export and Distribution Partner for AP Boots & Petrova Safety Footwear (HOTS Trading)', 'https://catalog.hotstrading.com/assets/img/logo_hots.png', NOW(), NOW()),
(2, 'PT Waru Gunung Industry', 'pt-waru-gunung-industry', 'Indonesia', 'Principal Manufacturer of AP Boots Indonesia since 1982. ISO 9001:2015 & SNI Certified Factory.', 'https://catalog.hotstrading.com/assets/img/logo_apboots.png', NOW(), NOW())
ON DUPLICATE KEY UPDATE `name`=VALUES(`name`), `country`=VALUES(`country`), `description`=VALUES(`description`), `updated_at`=NOW();

-- -------------------------------------------------------------
-- 3. IDEMPOTENT CLEANUP (Allow safe re-runs without errors)
-- -------------------------------------------------------------
DELETE FROM `product_specifications` WHERE `product_id` BETWEEN 2001 AND 2125;
DELETE FROM `product_use_cases` WHERE `product_id` BETWEEN 2001 AND 2125;
DELETE FROM `product_regions` WHERE `product_id` BETWEEN 2001 AND 2125;
DELETE FROM `product_certifications` WHERE `product_id` BETWEEN 2001 AND 2125;
DELETE FROM `alibaba_export_listings` WHERE `product_id` BETWEEN 2001 AND 2125;
DELETE FROM `products` WHERE `id` BETWEEN 2001 AND 2125 OR `product_code` LIKE 'MST-%';

-- -------------------------------------------------------------
-- 4. MASTER PRODUCTS (125 SKU - Full B2B Specs)
-- -------------------------------------------------------------
INSERT INTO `products` (
  `id`, `product_code`, `name`, `code`, `series`, `description`, `category`, `status`,
  `category_id`, `manufacturer_id`, `image_url`, `images`, `moq`, `moq_new`, `production_capacity`,
  `base_price`, `currency`, `is_active`, `is_featured`, `slug`, `custom_taxonomy`, `badges`,
  `is_tax_included`, `is_transport_included`, `created_at`, `updated_at`
) VALUES
(
  2001, 'MST-001', 'AP Boots AP MAX Coklat Hitam', 'APB-016',
  'Heavy Industry & Mining Safety', 'Comprehensive industrial safety footwear engineered with Steel Toe Cap 200 Joule (EN ISO 20345 / ASTM F2413) and puncture-resistant construction with anti-static and oil-resistant outsole.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Heavy-Duty PVC / Nitrile Rubber • SRC Certified (SRA + SRB Heavy Lug Outsole) • EU 39 - 44
Target Sectors: Pertambangan Batubara, Migas, Proyek Sipil Konstruksi Berat, Pabrik Kimia, Peleburan Logam
Packaging: 10 Pairs / Master Carton (0.096 m³ • 22.5 kg)
Wholesale FOB Reference: $13.54 / pair (Rp 314,425 Factory List)

Technical Specifications:
• Upper: Heavy-Duty PVC / Nitrile Rubber
• Outsole: Nitrile Blend Anti-Slip Rubber
• Toe Protection: Steel Toe Cap 200 Joule (EN ISO 20345 / ASTM F2413)
• Midsole: Steel Midsole Anti-Paku 1100N (Optional on S5)
• Shaft Height: 38.0 cm | Weight: 2150 g
• Sizing Range: EU 39 - 44
• Minimum Order Quantity (MOQ): 10 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Safety Boots', 'APPROVED',
  11, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC/hero_AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC/hero_AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC/side_AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP MAX Coklat Hitam - Sepatu Safety PVC - 39/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP MAX Coklat Hitam - Sepatu Safety PVC - 39/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP MAX Coklat Hitam - Sepatu Safety PVC - 39/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP MAX Coklat Hitam - Sepatu Safety PVC - 39/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP MAX Coklat Hitam - Sepatu Safety PVC - 39/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/06_AP_Safety_Boots/AP Boots AP MAX -Sepatu Boot Safety - 39/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/06_AP_Safety_Boots/AP Boots AP MAX -Sepatu Boot Safety - 39/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/06_AP_Safety_Boots/AP Boots AP MAX -Sepatu Boot Safety - 39/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/06_AP_Safety_Boots/AP Boots AP MAX -Sepatu Boot Safety - 39/04_gallery.jpg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/5356ff5360e94c33a851e64e4963efec~tplv-aphluv4xwc-white-pad-v1:1600:1600.jpeg"]', '10 Pairs', 10,
  '50,000 Pairs / Month', 314425, 'IDR', 1, 1, 'ap-boots-ap-max-coklat-hitam-mst-001',
  'Heavy Industry & Mining Safety', '["HERO #1 • HEAVY INDUSTRY & MINING", "Steel Toe 200J", "EN ISO 20345 S5"]', 0, 0, NOW(), NOW()
),
(
  2002, 'MST-002', 'AP Boots AP METAGUARD', 'APB-025',
  'Heavy Industry & Mining Safety', 'Comprehensive industrial safety footwear engineered with Steel Toe Cap 200 Joule (EN ISO 20345 / ASTM F2413) and puncture-resistant construction with anti-static and oil-resistant outsole.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Injeksi PVC Khusus • SRC Certified (SRA + SRB Heavy Lug Outsole) • EU 39 - 44
Target Sectors: Pertambangan Batubara, Migas, Proyek Sipil Konstruksi Berat, Pabrik Kimia, Peleburan Logam
Packaging: 10 Pairs / Master Carton (0.096 m³ • 22.5 kg)
Wholesale FOB Reference: $12.94 / pair (Rp 300,400 Factory List)

Technical Specifications:
• Upper: Injeksi PVC Khusus
• Outsole: Nitrile Blend Anti-Slip Rubber
• Toe Protection: Steel Toe Cap 200 Joule (EN ISO 20345 / ASTM F2413)
• Midsole: Steel Midsole Anti-Paku 1100N (Optional on S5)
• Shaft Height: 38.0 cm | Weight: 2150 g
• Sizing Range: EU 39 - 44
• Minimum Order Quantity (MOQ): 10 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Safety Boots', 'APPROVED',
  11, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_METAGUARD_Black_Sepatu_Boot_PVC/hero_AP_Boots_METAGUARD_Black_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_METAGUARD_Black_Sepatu_Boot_PVC/hero_AP_Boots_METAGUARD_Black_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_METAGUARD_Black_Sepatu_Boot_PVC/side_AP_Boots_METAGUARD_Black_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots METAGUARD Black - Sepatu Boot PVC Shoes - 39/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots METAGUARD Black - Sepatu Boot PVC Shoes - 39/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots METAGUARD Black - Sepatu Boot PVC Shoes - 39/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots METAGUARD Black - Sepatu Boot PVC Shoes - 39/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots METAGUARD Black - Sepatu Boot PVC Shoes - 39/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/06_AP_Safety_Boots/AP Boots METAGUARD - Sepatu Boot Safety PVC Shoes Karet Kerja - 39/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/06_AP_Safety_Boots/AP Boots METAGUARD - Sepatu Boot Safety PVC Shoes Karet Kerja - 39/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/06_AP_Safety_Boots/AP Boots METAGUARD - Sepatu Boot Safety PVC Shoes Karet Kerja - 39/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/06_AP_Safety_Boots/AP Boots METAGUARD - Sepatu Boot Safety PVC Shoes Karet Kerja - 39/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/06_AP_Safety_Boots/AP Boots METAGUARD - Sepatu Boot Safety PVC Shoes Karet Kerja - 39/05_gallery.jpg"]', '10 Pairs', 10,
  '50,000 Pairs / Month', 300400, 'IDR', 1, 1, 'ap-boots-ap-metaguard-mst-002',
  'Heavy Industry & Mining Safety', '["HERO #2 • HEAVY INDUSTRY & MINING", "Steel Toe 200J", "EN ISO 20345 S5"]', 0, 0, NOW(), NOW()
),
(
  2003, 'MST-003', 'AP Boots AP MAX Safety S5 Steel Toe', 'APB-026',
  'Heavy Industry & Mining Safety', 'Comprehensive industrial safety footwear engineered with Steel Toe Cap 200 Joule (EN ISO 20345 / ASTM F2413) and puncture-resistant construction with anti-static and oil-resistant outsole.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: High Density PVC / Nitrile • SRC Certified (SRA + SRB Heavy Lug Outsole) • EU 38 - 45
Target Sectors: Pertambangan Batubara, Migas, Proyek Sipil Konstruksi Berat, Pabrik Kimia, Peleburan Logam
Packaging: 10 Pairs / Master Carton (0.096 m³ • 22.5 kg)
Wholesale FOB Reference: $12.86 / pair (Rp 298,533 Factory List)

Technical Specifications:
• Upper: High Density PVC / Nitrile
• Outsole: Nitrile Blend Anti-Slip Rubber
• Toe Protection: Steel Toe Cap 200 Joule (EN ISO 20345 / ASTM F2413)
• Midsole: Steel Midsole Anti-Paku 1100N (Optional on S5)
• Shaft Height: 38.0 cm | Weight: 2150 g
• Sizing Range: EU 38 - 45
• Minimum Order Quantity (MOQ): 10 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Safety Boots', 'APPROVED',
  11, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC/hero_AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC/hero_AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC/side_AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP MAX Coklat Hitam - Sepatu Safety PVC - 39/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP MAX Coklat Hitam - Sepatu Safety PVC - 39/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP MAX Coklat Hitam - Sepatu Safety PVC - 39/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP MAX Coklat Hitam - Sepatu Safety PVC - 39/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP MAX Coklat Hitam - Sepatu Safety PVC - 39/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S5 BLACK - Sepatu Boot PVC Shoes Karet - 39/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S5 BLACK - Sepatu Boot PVC Shoes Karet - 39/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S5 BLACK - Sepatu Boot PVC Shoes Karet - 39/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S5 BLACK - Sepatu Boot PVC Shoes Karet - 39/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S5 BLACK - Sepatu Boot PVC Shoes Karet - 39/05_gallery.jpg"]', '10 Pairs', 10,
  '50,000 Pairs / Month', 298533, 'IDR', 1, 1, 'ap-boots-ap-max-safety-s5-steel-toe-mst-003',
  'Heavy Industry & Mining Safety', '["HERO #3 • HEAVY INDUSTRY & MINING", "Steel Toe 200J", "EN ISO 20345 S5"]', 0, 0, NOW(), NOW()
),
(
  2004, 'MST-004', 'AP Boots AP Safety S5 BLACK', 'APB-073',
  'Heavy Industry & Mining Safety', 'Comprehensive industrial safety footwear engineered with Steel Toe Cap 200 Joule (EN ISO 20345 / ASTM F2413) and puncture-resistant construction with anti-static and oil-resistant outsole.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Virgin PVC / Nitrile Blend • SRC Certified (SRA + SRB Heavy Lug Outsole) • EU 39 - 44
Target Sectors: Pertambangan Batubara, Migas, Proyek Sipil Konstruksi Berat, Pabrik Kimia, Peleburan Logam
Packaging: 10 Pairs / Master Carton (0.096 m³ • 22.5 kg)
Wholesale FOB Reference: $12.86 / pair (Rp 298,500 Factory List)

Technical Specifications:
• Upper: Virgin PVC / Nitrile Blend
• Outsole: Nitrile Blend Anti-Slip Rubber
• Toe Protection: Steel Toe Cap 200 Joule (EN ISO 20345 / ASTM F2413)
• Midsole: Steel Midsole Anti-Paku 1100N (Optional on S5)
• Shaft Height: 38.0 cm | Weight: 2150 g
• Sizing Range: EU 39 - 44
• Minimum Order Quantity (MOQ): 10 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Safety Boots', 'APPROVED',
  11, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_Safety_S5_BLACK_Sepatu_Boot_PVC/hero_AP_Boots_Safety_S5_BLACK_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_Safety_S5_BLACK_Sepatu_Boot_PVC/hero_AP_Boots_Safety_S5_BLACK_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_Safety_S5_BLACK_Sepatu_Boot_PVC/side_AP_Boots_Safety_S5_BLACK_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S5 BLACK - Sepatu Boot PVC Shoes Karet - 39/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S5 BLACK - Sepatu Boot PVC Shoes Karet - 39/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S5 BLACK - Sepatu Boot PVC Shoes Karet - 39/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S5 BLACK - Sepatu Boot PVC Shoes Karet - 39/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S5 BLACK - Sepatu Boot PVC Shoes Karet - 39/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/06_AP_Safety_Boots/AP Boots Safety S5 - Sepatu Boot Safety PVC Shoes Karet/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/06_AP_Safety_Boots/AP Boots Safety S5 - Sepatu Boot Safety PVC Shoes Karet/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/06_AP_Safety_Boots/AP Boots Safety S5 - Sepatu Boot Safety PVC Shoes Karet/03_gallery.jpg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/1cce65d156e64ae983d2df31029020cd~tplv-aphluv4xwc-white-pad-v1:1600:1600.jpeg", "https://p16-images-common-sign-sg.tokopedia-static.net/tos-maliva-i-o3syd03w52-us/96012615e382481eafa5384755414286~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg"]', '10 Pairs', 10,
  '50,000 Pairs / Month', 298500, 'IDR', 1, 1, 'ap-boots-ap-safety-s5-black-mst-004',
  'Heavy Industry & Mining Safety', '["HERO #4 • HEAVY INDUSTRY & MINING", "Steel Toe 200J", "EN ISO 20345 S5"]', 0, 0, NOW(), NOW()
),
(
  2005, 'MST-005', 'AP Boots AP METAGUARD Black', 'APB-074',
  'Heavy Industry & Mining Safety', 'Comprehensive industrial safety footwear engineered with Steel Toe Cap 200 Joule (EN ISO 20345 / ASTM F2413) and puncture-resistant construction with anti-static and oil-resistant outsole.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Heavy PVC Armor • SRC Certified (SRA + SRB Heavy Lug Outsole) • EU 39 - 45
Target Sectors: Pertambangan Batubara, Migas, Proyek Sipil Konstruksi Berat, Pabrik Kimia, Peleburan Logam
Packaging: 10 Pairs / Master Carton (0.096 m³ • 22.5 kg)
Wholesale FOB Reference: $12.94 / pair (Rp 300,400 Factory List)

Technical Specifications:
• Upper: Heavy PVC Armor
• Outsole: Nitrile Blend Anti-Slip Rubber
• Toe Protection: Steel Toe Cap 200 Joule (EN ISO 20345 / ASTM F2413)
• Midsole: Steel Midsole Anti-Paku 1100N (Optional on S5)
• Shaft Height: 38.0 cm | Weight: 2150 g
• Sizing Range: EU 39 - 45
• Minimum Order Quantity (MOQ): 10 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Safety Boots', 'APPROVED',
  11, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_METAGUARD_Black_Sepatu_Boot_PVC/hero_AP_Boots_METAGUARD_Black_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_METAGUARD_Black_Sepatu_Boot_PVC/hero_AP_Boots_METAGUARD_Black_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_METAGUARD_Black_Sepatu_Boot_PVC/side_AP_Boots_METAGUARD_Black_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots METAGUARD Black - Sepatu Boot PVC Shoes - 39/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots METAGUARD Black - Sepatu Boot PVC Shoes - 39/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots METAGUARD Black - Sepatu Boot PVC Shoes - 39/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots METAGUARD Black - Sepatu Boot PVC Shoes - 39/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots METAGUARD Black - Sepatu Boot PVC Shoes - 39/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/06_AP_Safety_Boots/AP Boots METAGUARD - Sepatu Boot Safety PVC Shoes Karet Kerja - 39/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/06_AP_Safety_Boots/AP Boots METAGUARD - Sepatu Boot Safety PVC Shoes Karet Kerja - 39/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/06_AP_Safety_Boots/AP Boots METAGUARD - Sepatu Boot Safety PVC Shoes Karet Kerja - 39/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/06_AP_Safety_Boots/AP Boots METAGUARD - Sepatu Boot Safety PVC Shoes Karet Kerja - 39/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/06_AP_Safety_Boots/AP Boots METAGUARD - Sepatu Boot Safety PVC Shoes Karet Kerja - 39/05_gallery.jpg"]', '10 Pairs', 10,
  '50,000 Pairs / Month', 300400, 'IDR', 1, 1, 'ap-boots-ap-metaguard-black-mst-005',
  'Heavy Industry & Mining Safety', '["HERO #5 • HEAVY INDUSTRY & MINING", "Steel Toe 200J", "EN ISO 20345 S5"]', 0, 0, NOW(), NOW()
),
(
  2006, 'MST-006', 'AP Boots AP Safety S4 Black', 'APB-081',
  'Heavy Industry & Mining Safety', 'Comprehensive industrial safety footwear engineered with Steel Toe Cap 200 Joule (EN ISO 20345 / ASTM F2413) and puncture-resistant construction with anti-static and oil-resistant outsole.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: High Grade PVC / PVC Sole • SRC Certified (SRA + SRB Heavy Lug Outsole) • EU 39 - 44
Target Sectors: Pertambangan Batubara, Migas, Proyek Sipil Konstruksi Berat, Pabrik Kimia, Peleburan Logam
Packaging: 10 Pairs / Master Carton (0.096 m³ • 22.5 kg)
Wholesale FOB Reference: $11.78 / pair (Rp 273,566 Factory List)

Technical Specifications:
• Upper: High Grade PVC / PVC Sole
• Outsole: Nitrile Blend Anti-Slip Rubber
• Toe Protection: Steel Toe Cap 200 Joule (EN ISO 20345 / ASTM F2413)
• Midsole: Steel Midsole Anti-Paku 1100N (Optional on S5)
• Shaft Height: 38.0 cm | Weight: 2150 g
• Sizing Range: EU 39 - 44
• Minimum Order Quantity (MOQ): 10 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Safety Boots', 'APPROVED',
  11, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_Safety_S4_Black_Sepatu_Boot_PVC/hero_AP_Boots_Safety_S4_Black_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_Safety_S4_Black_Sepatu_Boot_PVC/hero_AP_Boots_Safety_S4_Black_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_Safety_S4_Black_Sepatu_Boot_PVC/side_AP_Boots_Safety_S4_Black_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S4 Black - Sepatu Boot PVC - 39/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S4 Black - Sepatu Boot PVC - 39/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S4 Black - Sepatu Boot PVC - 39/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S4 Black - Sepatu Boot PVC - 39/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S4 Black - Sepatu Boot PVC - 39/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/03_gallery.jpg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/VqbcmM/2023/6/26/fca9bed1-b4b3-431f-b87b-61a4fafc2d78.jpg~tplv-aphluv4xwc-white-pad-v1:1600:1600.jpeg", "https://p19-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/VqbcmM/2023/5/25/fa14fdd1-a341-499b-ac07-a48bd960fb66.jpg~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg"]', '10 Pairs', 10,
  '50,000 Pairs / Month', 273566, 'IDR', 1, 1, 'ap-boots-ap-safety-s4-black-mst-006',
  'Heavy Industry & Mining Safety', '["HERO #6 • HEAVY INDUSTRY & MINING", "Steel Toe 200J", "EN ISO 20345 S5"]', 0, 0, NOW(), NOW()
),
(
  2007, 'MST-007', 'AP Boots AP Safety S5', 'APB-096',
  'Heavy Industry & Mining Safety', 'Comprehensive industrial safety footwear engineered with Steel Toe Cap 200 Joule (EN ISO 20345 / ASTM F2413) and puncture-resistant construction with anti-static and oil-resistant outsole.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Nitrile Compound PVC • SRC Certified (SRA + SRB Heavy Lug Outsole) • EU 38 - 45
Target Sectors: Pertambangan Batubara, Migas, Proyek Sipil Konstruksi Berat, Pabrik Kimia, Peleburan Logam
Packaging: 10 Pairs / Master Carton (0.096 m³ • 22.5 kg)
Wholesale FOB Reference: $12.86 / pair (Rp 298,500 Factory List)

Technical Specifications:
• Upper: Nitrile Compound PVC
• Outsole: Nitrile Blend Anti-Slip Rubber
• Toe Protection: Steel Toe Cap 200 Joule (EN ISO 20345 / ASTM F2413)
• Midsole: Steel Midsole Anti-Paku 1100N (Optional on S5)
• Shaft Height: 38.0 cm | Weight: 2150 g
• Sizing Range: EU 38 - 45
• Minimum Order Quantity (MOQ): 10 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Safety Boots', 'APPROVED',
  11, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_Safety_S5_BLACK_Sepatu_Boot_PVC/hero_AP_Boots_Safety_S5_BLACK_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_Safety_S5_BLACK_Sepatu_Boot_PVC/hero_AP_Boots_Safety_S5_BLACK_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_Safety_S5_BLACK_Sepatu_Boot_PVC/side_AP_Boots_Safety_S5_BLACK_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S5 BLACK - Sepatu Boot PVC Shoes Karet - 39/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S5 BLACK - Sepatu Boot PVC Shoes Karet - 39/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S5 BLACK - Sepatu Boot PVC Shoes Karet - 39/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S5 BLACK - Sepatu Boot PVC Shoes Karet - 39/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S5 BLACK - Sepatu Boot PVC Shoes Karet - 39/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/06_AP_Safety_Boots/AP Boots Safety S5 - Sepatu Boot Safety PVC Shoes Karet/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/06_AP_Safety_Boots/AP Boots Safety S5 - Sepatu Boot Safety PVC Shoes Karet/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/06_AP_Safety_Boots/AP Boots Safety S5 - Sepatu Boot Safety PVC Shoes Karet/03_gallery.jpg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/1cce65d156e64ae983d2df31029020cd~tplv-aphluv4xwc-white-pad-v1:1600:1600.jpeg", "https://p16-images-common-sign-sg.tokopedia-static.net/tos-maliva-i-o3syd03w52-us/96012615e382481eafa5384755414286~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg"]', '10 Pairs', 10,
  '50,000 Pairs / Month', 298500, 'IDR', 1, 1, 'ap-boots-ap-safety-s5-mst-007',
  'Heavy Industry & Mining Safety', '["HERO #7 • HEAVY INDUSTRY & MINING", "Steel Toe 200J", "EN ISO 20345 S5"]', 0, 0, NOW(), NOW()
),
(
  2008, 'MST-008', 'AP Boots AP TERRA ECO 3 Hijau', 'APB-007',
  'Agriculture & Forestry', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Fleksibel PVC / Sol Karet • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 44
Target Sectors: Perkebunan Kelapa Sawit, Sawah Padi, Kehutanan, Peternakan Sapi, Irigasi Rawa
Packaging: 12 Pairs / Master Carton (0.096 m³ • 17.5 kg)
Wholesale FOB Reference: $4.23 / pair (Rp 98,100 Factory List)

Technical Specifications:
• Upper: Fleksibel PVC / Sol Karet
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Plain Reinforced Soft Toe)
• Midsole: None (High Flexibility Sole)
• Shaft Height: 30.0 cm | Weight: 1350 g
• Sizing Range: EU 38 - 44
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Terra Series', 'APPROVED',
  12, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_3_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_3_Hijau_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_3_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_3_Hijau_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_3_Hijau_Sepatu_Boot_PVC/side_AP_Boots_TERRA_ECO_3_Hijau_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Hijau - Sepatu Boot PVC Karet Shoes - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Hijau - Sepatu Boot PVC Karet Shoes - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Hijau - Sepatu Boot PVC Karet Shoes - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Hijau - Sepatu Boot PVC Karet Shoes - 38/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Hijau - Sepatu Boot PVC Karet Shoes - 38/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 98100, 'IDR', 1, 1, 'ap-boots-ap-terra-eco-3-hijau-mst-008',
  'Agriculture & Forestry', '["HERO #8 • AGRICULTURE & PLANTATION", "Mud-Release Cleats", "100% Waterproof"]', 0, 0, NOW(), NOW()
),
(
  2009, 'MST-009', 'AP Boots AP TERRA ECO 3 Hitam', 'APB-008',
  'Agriculture & Forestry', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Fleksibel PVC / Sol Hitam • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 44
Target Sectors: Perkebunan Kelapa Sawit, Sawah Padi, Kehutanan, Peternakan Sapi, Irigasi Rawa
Packaging: 12 Pairs / Master Carton (0.096 m³ • 17.5 kg)
Wholesale FOB Reference: $3.47 / pair (Rp 80,625 Factory List)

Technical Specifications:
• Upper: Fleksibel PVC / Sol Hitam
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Plain Reinforced Soft Toe)
• Midsole: None (High Flexibility Sole)
• Shaft Height: 30.0 cm | Weight: 1350 g
• Sizing Range: EU 38 - 44
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Terra Series', 'APPROVED',
  12, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC/side_AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Hitam - Sepatu Boot PVC Karet Shoes - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Hitam - Sepatu Boot PVC Karet Shoes - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Hitam - Sepatu Boot PVC Karet Shoes - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Hitam - Sepatu Boot PVC Karet Shoes - 38/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Hitam - Sepatu Boot PVC Karet Shoes - 38/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 80625, 'IDR', 1, 1, 'ap-boots-ap-terra-eco-3-hitam-mst-009',
  'Agriculture & Forestry', '["HERO #9 • AGRICULTURE & PLANTATION", "Mud-Release Cleats", "100% Waterproof"]', 0, 0, NOW(), NOW()
),
(
  2010, 'MST-010', 'AP Boots AP TERRA ECO 3 Kuning', 'APB-009',
  'Agriculture & Forestry', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: High-Visibility PVC • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 44
Target Sectors: Perkebunan Kelapa Sawit, Sawah Padi, Kehutanan, Peternakan Sapi, Irigasi Rawa
Packaging: 12 Pairs / Master Carton (0.096 m³ • 17.5 kg)
Wholesale FOB Reference: $4.63 / pair (Rp 107,400 Factory List)

Technical Specifications:
• Upper: High-Visibility PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Plain Reinforced Soft Toe)
• Midsole: None (High Flexibility Sole)
• Shaft Height: 30.0 cm | Weight: 1350 g
• Sizing Range: EU 38 - 44
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Terra Series', 'APPROVED',
  12, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_3_Kuning_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_3_Kuning_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_3_Kuning_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_3_Kuning_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_3_Kuning_Sepatu_Boot_PVC/side_AP_Boots_TERRA_ECO_3_Kuning_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Kuning - Sepatu Boot PVC Karet Shoes - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Kuning - Sepatu Boot PVC Karet Shoes - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Kuning - Sepatu Boot PVC Karet Shoes - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Kuning - Sepatu Boot PVC Karet Shoes - 38/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Kuning - Sepatu Boot PVC Karet Shoes - 38/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 107400, 'IDR', 1, 1, 'ap-boots-ap-terra-eco-3-kuning-mst-010',
  'Agriculture & Forestry', '["HERO #10 • AGRICULTURE & PLANTATION", "Mud-Release Cleats", "100% Waterproof"]', 0, 0, NOW(), NOW()
),
(
  2011, 'MST-011', 'AP Boots AP TERRA ECO 3 Orange', 'APB-010',
  'Agriculture & Forestry', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: High-Visibility PVC • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 44
Target Sectors: Perkebunan Kelapa Sawit, Sawah Padi, Kehutanan, Peternakan Sapi, Irigasi Rawa
Packaging: 12 Pairs / Master Carton (0.096 m³ • 17.5 kg)
Wholesale FOB Reference: $4.91 / pair (Rp 114,066 Factory List)

Technical Specifications:
• Upper: High-Visibility PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Plain Reinforced Soft Toe)
• Midsole: None (High Flexibility Sole)
• Shaft Height: 30.0 cm | Weight: 1350 g
• Sizing Range: EU 38 - 44
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Terra Series', 'APPROVED',
  12, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_3_Orange_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_3_Orange_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_3_Orange_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_3_Orange_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_3_Orange_Sepatu_Boot_PVC/side_AP_Boots_TERRA_ECO_3_Orange_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Orange - Sepatu Boot PVC Karet Shoes - 39/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Orange - Sepatu Boot PVC Karet Shoes - 39/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Orange - Sepatu Boot PVC Karet Shoes - 39/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Orange - Sepatu Boot PVC Karet Shoes - 39/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Orange - Sepatu Boot PVC Karet Shoes - 39/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 114066, 'IDR', 1, 1, 'ap-boots-ap-terra-eco-3-orange-mst-011',
  'Agriculture & Forestry', '["HERO #11 • AGRICULTURE & PLANTATION", "Mud-Release Cleats", "100% Waterproof"]', 0, 0, NOW(), NOW()
),
(
  2012, 'MST-012', 'AP Boots AP TERRA GP Hitam', 'APB-015',
  'Agriculture & Forestry', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Virgin Rubber Blend PVC • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 45
Target Sectors: Perkebunan Kelapa Sawit, Sawah Padi, Kehutanan, Peternakan Sapi, Irigasi Rawa
Packaging: 12 Pairs / Master Carton (0.096 m³ • 17.5 kg)
Wholesale FOB Reference: $2.71 / pair (Rp 62,900 Factory List)

Technical Specifications:
• Upper: Virgin Rubber Blend PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Plain Reinforced Soft Toe)
• Midsole: None (High Flexibility Sole)
• Shaft Height: 30.0 cm | Weight: 1350 g
• Sizing Range: EU 38 - 45
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Terra Series', 'APPROVED',
  12, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_GP_Hitam_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_GP_Hitam_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_GP_Hitam_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_GP_Hitam_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_GP_Hitam_Sepatu_Boot_PVC/side_AP_Boots_TERRA_GP_Hitam_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA GP Hitam - Sepatu Boot PVC Shoes Karet Kerja - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA GP Hitam - Sepatu Boot PVC Shoes Karet Kerja - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA GP Hitam - Sepatu Boot PVC Shoes Karet Kerja - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA GP Hitam - Sepatu Boot PVC Shoes Karet Kerja - 38/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA GP Hitam - Sepatu Boot PVC Shoes Karet Kerja - 38/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 62900, 'IDR', 1, 1, 'ap-boots-ap-terra-gp-hitam-mst-012',
  'Agriculture & Forestry', '["HERO #12 • AGRICULTURE & PLANTATION", "Mud-Release Cleats", "100% Waterproof"]', 0, 0, NOW(), NOW()
),
(
  2013, 'MST-013', 'AP Boots AP TERRA 1 Kuning', 'APB-021',
  'Agriculture & Forestry', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Tebal PVC Injeksi • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 43
Target Sectors: Perkebunan Kelapa Sawit, Sawah Padi, Kehutanan, Peternakan Sapi, Irigasi Rawa
Packaging: 12 Pairs / Master Carton (0.096 m³ • 17.5 kg)
Wholesale FOB Reference: $5.92 / pair (Rp 137,400 Factory List)

Technical Specifications:
• Upper: Tebal PVC Injeksi
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Plain Reinforced Soft Toe)
• Midsole: None (High Flexibility Sole)
• Shaft Height: 30.0 cm | Weight: 1350 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Terra Series', 'APPROVED',
  12, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_TERRA_3_HITAM_KUNING_Sepatu_boots_PVC/hero_AP_Boots_AP_TERRA_3_HITAM_KUNING_Sepatu_boots_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_TERRA_3_HITAM_KUNING_Sepatu_boots_PVC/hero_AP_Boots_AP_TERRA_3_HITAM_KUNING_Sepatu_boots_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_TERRA_3_HITAM_KUNING_Sepatu_boots_PVC/side_AP_Boots_AP_TERRA_3_HITAM_KUNING_Sepatu_boots_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Kuning - Sepatu Boot PVC Shoes Karet - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Kuning - Sepatu Boot PVC Shoes Karet - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Kuning - Sepatu Boot PVC Shoes Karet - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Kuning - Sepatu Boot PVC Shoes Karet - 38/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Kuning - Sepatu Boot PVC Shoes Karet - 38/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Kuning - Sepatu Boot PVC Karet Shoes - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Kuning - Sepatu Boot PVC Karet Shoes - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Kuning - Sepatu Boot PVC Karet Shoes - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Kuning - Sepatu Boot PVC Karet Shoes - 38/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Kuning - Sepatu Boot PVC Karet Shoes - 38/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 137400, 'IDR', 1, 1, 'ap-boots-ap-terra-1-kuning-mst-013',
  'Agriculture & Forestry', '["HERO #13 • AGRICULTURE & PLANTATION", "Mud-Release Cleats", "100% Waterproof"]', 0, 0, NOW(), NOW()
),
(
  2014, 'MST-014', 'AP Boots AP TERRA 1 Hijau', 'APB-022',
  'Agriculture & Forestry', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Tebal PVC Injeksi • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 43
Target Sectors: Perkebunan Kelapa Sawit, Sawah Padi, Kehutanan, Peternakan Sapi, Irigasi Rawa
Packaging: 12 Pairs / Master Carton (0.096 m³ • 17.5 kg)
Wholesale FOB Reference: $5.47 / pair (Rp 126,999 Factory List)

Technical Specifications:
• Upper: Tebal PVC Injeksi
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Plain Reinforced Soft Toe)
• Midsole: None (High Flexibility Sole)
• Shaft Height: 30.0 cm | Weight: 1350 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Terra Series', 'APPROVED',
  12, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC/side_AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Hijau - Sepatu Boot PVC Shoes Karet - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Hijau - Sepatu Boot PVC Shoes Karet - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Hijau - Sepatu Boot PVC Shoes Karet - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Hijau - Sepatu Boot PVC Shoes Karet - 38/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 2 HIJAU - Sepatu Boot PVC Karet Shoes - 25/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 2 HIJAU - Sepatu Boot PVC Karet Shoes - 25/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 2 HIJAU - Sepatu Boot PVC Karet Shoes - 25/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 2 HIJAU - Sepatu Boot PVC Karet Shoes - 25/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 2 HIJAU - Sepatu Boot PVC Karet Shoes - 25/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 126999, 'IDR', 1, 1, 'ap-boots-ap-terra-1-hijau-mst-014',
  'Agriculture & Forestry', '["HERO #14 • AGRICULTURE & PLANTATION", "Mud-Release Cleats", "100% Waterproof"]', 0, 0, NOW(), NOW()
),
(
  2015, 'MST-015', 'AP Boots AP TERRA 1 Putih', 'APB-023',
  'Agriculture & Forestry', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Food & Farm Safe PVC • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 43
Target Sectors: Perkebunan Kelapa Sawit, Sawah Padi, Kehutanan, Peternakan Sapi, Irigasi Rawa
Packaging: 12 Pairs / Master Carton (0.096 m³ • 17.5 kg)
Wholesale FOB Reference: $6.24 / pair (Rp 144,900 Factory List)

Technical Specifications:
• Upper: Food & Farm Safe PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Plain Reinforced Soft Toe)
• Midsole: None (High Flexibility Sole)
• Shaft Height: 30.0 cm | Weight: 1350 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Terra Series', 'APPROVED',
  12, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_1_Putih_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_1_Putih_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_1_Putih_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_1_Putih_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_1_Putih_Sepatu_Boot_PVC/side_AP_Boots_TERRA_1_Putih_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Putih - Sepatu Boot PVC Shoes Karet - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Putih - Sepatu Boot PVC Shoes Karet - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Putih - Sepatu Boot PVC Shoes Karet - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Putih - Sepatu Boot PVC Shoes Karet - 38/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Putih - Sepatu Boot PVC Shoes Karet - 38/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA ARMY - Sepatu Boot PVC Karet Shoes - 40/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA ARMY - Sepatu Boot PVC Karet Shoes - 40/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA ARMY - Sepatu Boot PVC Karet Shoes - 40/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA ARMY - Sepatu Boot PVC Karet Shoes - 40/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA ARMY - Sepatu Boot PVC Karet Shoes - 40/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 144900, 'IDR', 1, 1, 'ap-boots-ap-terra-1-putih-mst-015',
  'Agriculture & Forestry', '["HERO #15 • AGRICULTURE & PLANTATION", "Mud-Release Cleats", "100% Waterproof"]', 0, 0, NOW(), NOW()
),
(
  2016, 'MST-016', 'AP Boots AP TERRA ECO 5', 'APB-029',
  'Agriculture & Forestry', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: PVC Daur Ulang Ramah Lingkungan • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 44
Target Sectors: Perkebunan Kelapa Sawit, Sawah Padi, Kehutanan, Peternakan Sapi, Irigasi Rawa
Packaging: 12 Pairs / Master Carton (0.096 m³ • 17.5 kg)
Wholesale FOB Reference: $4.07 / pair (Rp 94,400 Factory List)

Technical Specifications:
• Upper: PVC Daur Ulang Ramah Lingkungan
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Plain Reinforced Soft Toe)
• Midsole: None (High Flexibility Sole)
• Shaft Height: 30.0 cm | Weight: 1350 g
• Sizing Range: EU 38 - 44
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Terra Series', 'APPROVED',
  12, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC/side_AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Hijau - Sepatu Boot PVC Karet Shoes - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Hijau - Sepatu Boot PVC Karet Shoes - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Hijau - Sepatu Boot PVC Karet Shoes - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Hijau - Sepatu Boot PVC Karet Shoes - 38/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Hijau - Sepatu Boot PVC Karet Shoes - 38/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 94400, 'IDR', 1, 1, 'ap-boots-ap-terra-eco-5-mst-016',
  'Agriculture & Forestry', '["HERO #16 • AGRICULTURE & PLANTATION", "Mud-Release Cleats", "100% Waterproof"]', 0, 0, NOW(), NOW()
),
(
  2017, 'MST-017', 'AP Boots AP TERRA ECO 2 Full Hitam', 'APB-040',
  'Agriculture & Forestry', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Elastis PVC • Self-Cleaning Mud-Release Cleated Lugs • EU 39 - 43
Target Sectors: Perkebunan Kelapa Sawit, Sawah Padi, Kehutanan, Peternakan Sapi, Irigasi Rawa
Packaging: 12 Pairs / Master Carton (0.096 m³ • 17.5 kg)
Wholesale FOB Reference: $3.47 / pair (Rp 80,625 Factory List)

Technical Specifications:
• Upper: Elastis PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Plain Reinforced Soft Toe)
• Midsole: None (High Flexibility Sole)
• Shaft Height: 30.0 cm | Weight: 1350 g
• Sizing Range: EU 39 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Terra Series', 'APPROVED',
  12, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC/side_AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Hitam - Sepatu Boot PVC Karet Shoes - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Hitam - Sepatu Boot PVC Karet Shoes - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Hitam - Sepatu Boot PVC Karet Shoes - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Hitam - Sepatu Boot PVC Karet Shoes - 38/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Hitam - Sepatu Boot PVC Karet Shoes - 38/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 80625, 'IDR', 1, 1, 'ap-boots-ap-terra-eco-2-full-hitam-mst-017',
  'Agriculture & Forestry', '["HERO #17 • AGRICULTURE & PLANTATION", "Mud-Release Cleats", "100% Waterproof"]', 0, 0, NOW(), NOW()
),
(
  2018, 'MST-018', 'AP Boots AP TERRA 3 Hijau Merah', 'APB-041',
  'Agriculture & Forestry', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Dual Tone PVC Injeksi • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 44
Target Sectors: Perkebunan Kelapa Sawit, Sawah Padi, Kehutanan, Peternakan Sapi, Irigasi Rawa
Packaging: 12 Pairs / Master Carton (0.096 m³ • 17.5 kg)
Wholesale FOB Reference: $5.41 / pair (Rp 125,566 Factory List)

Technical Specifications:
• Upper: Dual Tone PVC Injeksi
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Plain Reinforced Soft Toe)
• Midsole: None (High Flexibility Sole)
• Shaft Height: 30.0 cm | Weight: 1350 g
• Sizing Range: EU 38 - 44
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Terra Series', 'APPROVED',
  12, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_3_Hijau_Merah_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_3_Hijau_Merah_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_3_Hijau_Merah_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_3_Hijau_Merah_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_3_Hijau_Merah_Sepatu_Boot_PVC/side_AP_Boots_TERRA_3_Hijau_Merah_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 3 Hijau Merah - Sepatu Boot PVC Shoes Karet - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 3 Hijau Merah - Sepatu Boot PVC Shoes Karet - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 3 Hijau Merah - Sepatu Boot PVC Shoes Karet - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 3 Hijau Merah - Sepatu Boot PVC Shoes Karet - 38/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 3 Hijau Merah - Sepatu Boot PVC Shoes Karet - 38/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Hijau - Sepatu Boot PVC Shoes Karet - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Hijau - Sepatu Boot PVC Shoes Karet - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Hijau - Sepatu Boot PVC Shoes Karet - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Hijau - Sepatu Boot PVC Shoes Karet - 38/04_gallery.jpg", "https://p16-images-common-sign-sg.tokopedia-static.net/tos-maliva-i-o3syd03w52-us/c93700afebfb4c11b319b721dd2a14c5~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 125566, 'IDR', 1, 1, 'ap-boots-ap-terra-3-hijau-merah-mst-018',
  'Agriculture & Forestry', '["HERO #18 • AGRICULTURE & PLANTATION", "Mud-Release Cleats", "100% Waterproof"]', 0, 0, NOW(), NOW()
),
(
  2019, 'MST-019', 'AP Boots AP TERRA ARMY', 'APB-052',
  'Agriculture & Forestry', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Camouflage PVC Pattern • Self-Cleaning Mud-Release Cleated Lugs • EU 39 - 44
Target Sectors: Perkebunan Kelapa Sawit, Sawah Padi, Kehutanan, Peternakan Sapi, Irigasi Rawa
Packaging: 12 Pairs / Master Carton (0.096 m³ • 17.5 kg)
Wholesale FOB Reference: $7.36 / pair (Rp 170,900 Factory List)

Technical Specifications:
• Upper: Camouflage PVC Pattern
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Plain Reinforced Soft Toe)
• Midsole: None (High Flexibility Sole)
• Shaft Height: 30.0 cm | Weight: 1350 g
• Sizing Range: EU 39 - 44
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Terra Series', 'APPROVED',
  12, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_TERRA_ARMY_Sepatu_Boot_PVC/hero_AP_Boots_AP_TERRA_ARMY_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_TERRA_ARMY_Sepatu_Boot_PVC/hero_AP_Boots_AP_TERRA_ARMY_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_TERRA_ARMY_Sepatu_Boot_PVC/side_AP_Boots_AP_TERRA_ARMY_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA ARMY - Sepatu Boot PVC Karet Shoes - 40/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA ARMY - Sepatu Boot PVC Karet Shoes - 40/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA ARMY - Sepatu Boot PVC Karet Shoes - 40/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA ARMY - Sepatu Boot PVC Karet Shoes - 40/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA ARMY - Sepatu Boot PVC Karet Shoes - 40/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA FOREST - Sepatu Boot PVC Karet Shoes - 40/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA FOREST - Sepatu Boot PVC Karet Shoes - 40/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA FOREST - Sepatu Boot PVC Karet Shoes - 40/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA FOREST - Sepatu Boot PVC Karet Shoes - 40/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA FOREST - Sepatu Boot PVC Karet Shoes - 40/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 170900, 'IDR', 1, 1, 'ap-boots-ap-terra-army-mst-019',
  'Agriculture & Forestry', '["HERO #19 • AGRICULTURE & PLANTATION", "Mud-Release Cleats", "100% Waterproof"]', 0, 0, NOW(), NOW()
),
(
  2020, 'MST-020', 'AP Boots AP TERRA FOREST', 'APB-053',
  'Agriculture & Forestry', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Earth Tone PVC • Self-Cleaning Mud-Release Cleated Lugs • EU 39 - 44
Target Sectors: Perkebunan Kelapa Sawit, Sawah Padi, Kehutanan, Peternakan Sapi, Irigasi Rawa
Packaging: 12 Pairs / Master Carton (0.096 m³ • 17.5 kg)
Wholesale FOB Reference: $7.36 / pair (Rp 170,900 Factory List)

Technical Specifications:
• Upper: Earth Tone PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Plain Reinforced Soft Toe)
• Midsole: None (High Flexibility Sole)
• Shaft Height: 30.0 cm | Weight: 1350 g
• Sizing Range: EU 39 - 44
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Terra Series', 'APPROVED',
  12, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_TERRA_FOREST_Sepatu_Boot_PVC/hero_AP_Boots_AP_TERRA_FOREST_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_TERRA_FOREST_Sepatu_Boot_PVC/hero_AP_Boots_AP_TERRA_FOREST_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_TERRA_FOREST_Sepatu_Boot_PVC/side_AP_Boots_AP_TERRA_FOREST_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA FOREST - Sepatu Boot PVC Karet Shoes - 40/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA FOREST - Sepatu Boot PVC Karet Shoes - 40/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA FOREST - Sepatu Boot PVC Karet Shoes - 40/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA FOREST - Sepatu Boot PVC Karet Shoes - 40/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA FOREST - Sepatu Boot PVC Karet Shoes - 40/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA ARMY - Sepatu Boot PVC Karet Shoes - 40/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA ARMY - Sepatu Boot PVC Karet Shoes - 40/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA ARMY - Sepatu Boot PVC Karet Shoes - 40/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA ARMY - Sepatu Boot PVC Karet Shoes - 40/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA ARMY - Sepatu Boot PVC Karet Shoes - 40/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 170900, 'IDR', 1, 1, 'ap-boots-ap-terra-forest-mst-020',
  'Agriculture & Forestry', '["HERO #20 • AGRICULTURE & PLANTATION", "Mud-Release Cleats", "100% Waterproof"]', 0, 0, NOW(), NOW()
),
(
  2021, 'MST-021', 'AP Boots AP TERRA 3 HITAM KUNING', 'APB-072',
  'Agriculture & Forestry', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Heavy Duty PVC • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 44
Target Sectors: Perkebunan Kelapa Sawit, Sawah Padi, Kehutanan, Peternakan Sapi, Irigasi Rawa
Packaging: 12 Pairs / Master Carton (0.096 m³ • 17.5 kg)
Wholesale FOB Reference: $5.34 / pair (Rp 124,066 Factory List)

Technical Specifications:
• Upper: Heavy Duty PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Plain Reinforced Soft Toe)
• Midsole: None (High Flexibility Sole)
• Shaft Height: 30.0 cm | Weight: 1350 g
• Sizing Range: EU 38 - 44
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Terra Series', 'APPROVED',
  12, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_TERRA_3_HITAM_KUNING_Sepatu_boots_PVC/hero_AP_Boots_AP_TERRA_3_HITAM_KUNING_Sepatu_boots_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_TERRA_3_HITAM_KUNING_Sepatu_boots_PVC/hero_AP_Boots_AP_TERRA_3_HITAM_KUNING_Sepatu_boots_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_TERRA_3_HITAM_KUNING_Sepatu_boots_PVC/side_AP_Boots_AP_TERRA_3_HITAM_KUNING_Sepatu_boots_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Kuning - Sepatu Boot PVC Shoes Karet - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Kuning - Sepatu Boot PVC Shoes Karet - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Kuning - Sepatu Boot PVC Shoes Karet - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Kuning - Sepatu Boot PVC Shoes Karet - 38/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Kuning - Sepatu Boot PVC Shoes Karet - 38/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 124066, 'IDR', 1, 1, 'ap-boots-ap-terra-3-hitam-kuning-mst-021',
  'Agriculture & Forestry', '["HERO #21 • AGRICULTURE & PLANTATION", "Mud-Release Cleats", "100% Waterproof"]', 0, 0, NOW(), NOW()
),
(
  2022, 'MST-022', 'AP Boots AP TERRA 2 HIJAU', 'APB-075',
  'Agriculture & Forestry', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Soft PVC Compound • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 43
Target Sectors: Perkebunan Kelapa Sawit, Sawah Padi, Kehutanan, Peternakan Sapi, Irigasi Rawa
Packaging: 12 Pairs / Master Carton (0.096 m³ • 17.5 kg)
Wholesale FOB Reference: $5.47 / pair (Rp 126,999 Factory List)

Technical Specifications:
• Upper: Soft PVC Compound
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Plain Reinforced Soft Toe)
• Midsole: None (High Flexibility Sole)
• Shaft Height: 30.0 cm | Weight: 1350 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Terra Series', 'APPROVED',
  12, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC/side_AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Hijau - Sepatu Boot PVC Shoes Karet - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Hijau - Sepatu Boot PVC Shoes Karet - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Hijau - Sepatu Boot PVC Shoes Karet - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Hijau - Sepatu Boot PVC Shoes Karet - 38/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 2 HIJAU - Sepatu Boot PVC Karet Shoes - 25/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 2 HIJAU - Sepatu Boot PVC Karet Shoes - 25/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 2 HIJAU - Sepatu Boot PVC Karet Shoes - 25/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 2 HIJAU - Sepatu Boot PVC Karet Shoes - 25/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 2 HIJAU - Sepatu Boot PVC Karet Shoes - 25/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 126999, 'IDR', 1, 1, 'ap-boots-ap-terra-2-hijau-mst-022',
  'Agriculture & Forestry', '["HERO #22 • AGRICULTURE & PLANTATION", "Mud-Release Cleats", "100% Waterproof"]', 0, 0, NOW(), NOW()
),
(
  2023, 'MST-023', 'Ap Boots TERRA 5 HIJAU', 'APB-076',
  'Agriculture & Forestry', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Reinforced PVC • Self-Cleaning Mud-Release Cleated Lugs • EU 39 - 44
Target Sectors: Perkebunan Kelapa Sawit, Sawah Padi, Kehutanan, Peternakan Sapi, Irigasi Rawa
Packaging: 12 Pairs / Master Carton (0.096 m³ • 17.5 kg)
Wholesale FOB Reference: $5.47 / pair (Rp 126,999 Factory List)

Technical Specifications:
• Upper: Reinforced PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Plain Reinforced Soft Toe)
• Midsole: None (High Flexibility Sole)
• Shaft Height: 30.0 cm | Weight: 1350 g
• Sizing Range: EU 39 - 44
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Terra Series', 'APPROVED',
  12, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC/side_AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Hijau - Sepatu Boot PVC Shoes Karet - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Hijau - Sepatu Boot PVC Shoes Karet - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Hijau - Sepatu Boot PVC Shoes Karet - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Hijau - Sepatu Boot PVC Shoes Karet - 38/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 2 HIJAU - Sepatu Boot PVC Karet Shoes - 25/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 2 HIJAU - Sepatu Boot PVC Karet Shoes - 25/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 2 HIJAU - Sepatu Boot PVC Karet Shoes - 25/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 2 HIJAU - Sepatu Boot PVC Karet Shoes - 25/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 2 HIJAU - Sepatu Boot PVC Karet Shoes - 25/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 126999, 'IDR', 1, 1, 'ap-boots-ap-boots-terra-5-hijau-mst-023',
  'Agriculture & Forestry', '["HERO #23 • AGRICULTURE & PLANTATION", "Mud-Release Cleats", "100% Waterproof"]', 0, 0, NOW(), NOW()
),
(
  2024, 'MST-024', 'AP Boots AP TERRA ECO 5 PUTIH', 'APB-080',
  'Agriculture & Forestry', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Sanitized PVC • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 43
Target Sectors: Perkebunan Kelapa Sawit, Sawah Padi, Kehutanan, Peternakan Sapi, Irigasi Rawa
Packaging: 12 Pairs / Master Carton (0.096 m³ • 17.5 kg)
Wholesale FOB Reference: $4.24 / pair (Rp 98,400 Factory List)

Technical Specifications:
• Upper: Sanitized PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Plain Reinforced Soft Toe)
• Midsole: None (High Flexibility Sole)
• Shaft Height: 30.0 cm | Weight: 1350 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Terra Series', 'APPROVED',
  12, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_5_PUTIH_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_5_PUTIH_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_5_PUTIH_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_5_PUTIH_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_5_PUTIH_Sepatu_Boot_PVC/side_AP_Boots_TERRA_ECO_5_PUTIH_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Hijau - Sepatu Boot PVC Karet Shoes - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Hijau - Sepatu Boot PVC Karet Shoes - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Hijau - Sepatu Boot PVC Karet Shoes - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Hijau - Sepatu Boot PVC Karet Shoes - 38/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Hijau - Sepatu Boot PVC Karet Shoes - 38/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 98400, 'IDR', 1, 1, 'ap-boots-ap-terra-eco-5-putih-mst-024',
  'Agriculture & Forestry', '["HERO #24 • AGRICULTURE & PLANTATION", "Mud-Release Cleats", "100% Waterproof"]', 0, 0, NOW(), NOW()
),
(
  2025, 'MST-025', 'AP Boots AP TERRA GP Hijau', 'APB-083',
  'Agriculture & Forestry', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Multi-Use PVC • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 44
Target Sectors: Perkebunan Kelapa Sawit, Sawah Padi, Kehutanan, Peternakan Sapi, Irigasi Rawa
Packaging: 12 Pairs / Master Carton (0.096 m³ • 17.5 kg)
Wholesale FOB Reference: $3.20 / pair (Rp 74,400 Factory List)

Technical Specifications:
• Upper: Multi-Use PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Plain Reinforced Soft Toe)
• Midsole: None (High Flexibility Sole)
• Shaft Height: 30.0 cm | Weight: 1350 g
• Sizing Range: EU 38 - 44
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Terra Series', 'APPROVED',
  12, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_GP_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_GP_Hijau_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_GP_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_GP_Hijau_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_GP_Hijau_Sepatu_Boot_PVC/side_AP_Boots_TERRA_GP_Hijau_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA GP Hijau - Sepatu Boot PVC Karet Shoes Kerja - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA GP Hijau - Sepatu Boot PVC Karet Shoes Kerja - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA GP Hijau - Sepatu Boot PVC Karet Shoes Kerja - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA GP Hijau - Sepatu Boot PVC Karet Shoes Kerja - 38/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA GP Hijau - Sepatu Boot PVC Karet Shoes Kerja - 38/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Hijau - Sepatu Boot PVC Shoes Karet - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Hijau - Sepatu Boot PVC Shoes Karet - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Hijau - Sepatu Boot PVC Shoes Karet - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Hijau - Sepatu Boot PVC Shoes Karet - 38/04_gallery.jpg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/4c981e6dd5c74bffaa2a1482290738b2~tplv-aphluv4xwc-white-pad-v1:1600:1600.jpeg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 74400, 'IDR', 1, 1, 'ap-boots-ap-terra-gp-hijau-mst-025',
  'Agriculture & Forestry', '["HERO #25 • AGRICULTURE & PLANTATION", "Mud-Release Cleats", "100% Waterproof"]', 0, 0, NOW(), NOW()
),
(
  2026, 'MST-026', 'AP Boots AP Terra Safety S4', 'APB-095',
  'Agriculture & Forestry', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: PVC Nitrile + Steel Toe • Self-Cleaning Mud-Release Cleated Lugs • EU 39 - 44
Target Sectors: Perkebunan Kelapa Sawit, Sawah Padi, Kehutanan, Peternakan Sapi, Irigasi Rawa
Packaging: 12 Pairs / Master Carton (0.096 m³ • 17.5 kg)
Wholesale FOB Reference: $11.78 / pair (Rp 273,566 Factory List)

Technical Specifications:
• Upper: PVC Nitrile + Steel Toe
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Plain Reinforced Soft Toe)
• Midsole: None (High Flexibility Sole)
• Shaft Height: 30.0 cm | Weight: 1350 g
• Sizing Range: EU 39 - 44
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Terra Series', 'APPROVED',
  12, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_Terra_Safety_S4_Kuning_Sepatu_Boot_Safety_PVC/hero_AP_Boots_Terra_Safety_S4_Kuning_Sepatu_Boot_Safety_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_Terra_Safety_S4_Kuning_Sepatu_Boot_Safety_PVC/hero_AP_Boots_Terra_Safety_S4_Kuning_Sepatu_Boot_Safety_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_Terra_Safety_S4_Kuning_Sepatu_Boot_Safety_PVC/side_AP_Boots_Terra_Safety_S4_Kuning_Sepatu_Boot_Safety_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S4 Black - Sepatu Boot PVC - 39/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S4 Black - Sepatu Boot PVC - 39/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S4 Black - Sepatu Boot PVC - 39/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S4 Black - Sepatu Boot PVC - 39/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S4 Black - Sepatu Boot PVC - 39/05_gallery.jpg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/VqbcmM/2023/6/26/fca9bed1-b4b3-431f-b87b-61a4fafc2d78.jpg~tplv-aphluv4xwc-white-pad-v1:1600:1600.jpeg", "https://p19-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/VqbcmM/2023/5/25/fa14fdd1-a341-499b-ac07-a48bd960fb66.jpg~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 273566, 'IDR', 1, 0, 'ap-boots-ap-terra-safety-s4-mst-026',
  'Agriculture & Forestry', '["HERO #26 • AGRICULTURE & PLANTATION", "Mud-Release Cleats", "100% Waterproof"]', 0, 0, NOW(), NOW()
),
(
  2027, 'MST-027', 'AP Boots ORCA', 'APB-024',
  'Commercial Marine & Cold Storage', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: High Shaft PVC (38 - 40 cm) • Saltwater-Resistant Anti-Hydroplaning Tread • EU 39 - 45
Target Sectors: Perikanan Laut Dalam, Industri Cold Storage, Galangan Kapal, Pengolahan Ikan
Packaging: 12 Pairs / Master Carton (0.096 m³ • 19.5 kg)
Wholesale FOB Reference: $4.44 / pair (Rp 103,125 Factory List)

Technical Specifications:
• Upper: High Shaft PVC (38 - 40 cm)
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Plain Reinforced Soft Toe)
• Midsole: None
• Shaft Height: 40.0 cm | Weight: 1750 g
• Sizing Range: EU 39 - 45
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Orca Series', 'APPROVED',
  13, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_ORCA_Sepatu_Boot_PVC/hero_AP_Boots_ORCA_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_ORCA_Sepatu_Boot_PVC/hero_AP_Boots_ORCA_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_ORCA_Sepatu_Boot_PVC/side_AP_Boots_ORCA_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/photobank/03_Orca_Series/APB-024_ap_boots_orca_realistic_photograph_01.webp", "https://catalog.hotstrading.com/assets/photobank/03_Orca_Series/APB-024_ap_boots_orca_realistic_photograph_02.webp", "https://catalog.hotstrading.com/assets/photobank/03_Orca_Series/APB-024_ap_boots_orca_rear_view_01.webp", "https://catalog.hotstrading.com/assets/photobank/03_Orca_Series/APB-024_ap_boots_orca_rear_view_02.webp", "https://catalog.hotstrading.com/assets/tokopedia/02_AP_Orca_Series/AP Boots ORCA - Sepatu Boot PVC - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/02_AP_Orca_Series/AP Boots ORCA - Sepatu Boot PVC - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/02_AP_Orca_Series/AP Boots ORCA - Sepatu Boot PVC - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/02_AP_Orca_Series/AP Boots ORCA - Sepatu Boot PVC - 38/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/02_AP_Orca_Series/AP Boots ORCA - Sepatu Boot PVC - 38/05_gallery.jpg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/b646ac1c7f844a3ea6c642adcfc30046~tplv-aphluv4xwc-white-pad-v1:1600:1600.jpeg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 103125, 'IDR', 1, 0, 'ap-boots-ap-boots-orca-mst-027',
  'Commercial Marine & Cold Storage', '["HERO #27 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2028, 'MST-028', 'AP Boots AP Chef Putih', 'APB-030',
  'Food Processing & HORECA', 'Ultra-lightweight ergonomic footwear engineered for all-day standing comfort, non-slip sanitary tile traction, and quick sanitization.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Micro-cellular PVC / Rubber Sole • Oil & Grease SRC Anti-Slip Rubber Pods • EU 36 - 44
Target Sectors: Dapur Komersial HORECA, Bakery, Restoran Cepat Saji, Pabrik Pengolahan Makanan
Packaging: 12 Pairs / Master Carton (0.096 m³ • 11.5 kg)
Wholesale FOB Reference: $8.85 / pair (Rp 205,478 Factory List)

Technical Specifications:
• Upper: Micro-cellular PVC / Rubber Sole
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Reinforced Ergonomic Toe Box
• Midsole: Ergonomic Anti-Fatigue Cushion Insole
• Shaft Height: 11.5 cm | Weight: 750 g
• Sizing Range: EU 36 - 44
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Chef Series', 'APPROVED',
  14, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_Chef_Putih_Sepatu_Slip_On_Dapur/hero_AP_Boots_AP_Chef_Putih_Sepatu_Slip_On_Dapur.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_Chef_Putih_Sepatu_Slip_On_Dapur/hero_AP_Boots_AP_Chef_Putih_Sepatu_Slip_On_Dapur.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_Chef_Putih_Sepatu_Slip_On_Dapur/side_AP_Boots_AP_Chef_Putih_Sepatu_Slip_On_Dapur.webp", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP Chef Putih - Sepatu Slip On Dapur Flat Shoes - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP Chef Putih - Sepatu Slip On Dapur Flat Shoes - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP Chef Putih - Sepatu Slip On Dapur Flat Shoes - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP Chef Putih - Sepatu Slip On Dapur Flat Shoes - 38/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP Chef Putih - Sepatu Slip On Dapur Flat Shoes - 38/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Putih - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Putih - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Putih - Sepatu Medis APD Safety Shoes - 36/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Putih - Sepatu Medis APD Safety Shoes - 36/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Putih - Sepatu Medis APD Safety Shoes - 36/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 205478, 'IDR', 1, 1, 'ap-boots-ap-chef-putih-mst-028',
  'Food Processing & HORECA', '["HERO #28 • COMMERCIAL KITCHEN PRO", "Oil & Grease Proof", "Non-Slip Siping"]', 0, 0, NOW(), NOW()
),
(
  2029, 'MST-029', 'AP Boots AP Chef Hitam', 'APB-038',
  'Food Processing & HORECA', 'Ultra-lightweight ergonomic footwear engineered for all-day standing comfort, non-slip sanitary tile traction, and quick sanitization.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Micro-cellular PVC / Rubber Sole • Oil & Grease SRC Anti-Slip Rubber Pods • EU 36 - 44
Target Sectors: Dapur Komersial HORECA, Bakery, Restoran Cepat Saji, Pabrik Pengolahan Makanan
Packaging: 12 Pairs / Master Carton (0.096 m³ • 11.5 kg)
Wholesale FOB Reference: $8.90 / pair (Rp 206,700 Factory List)

Technical Specifications:
• Upper: Micro-cellular PVC / Rubber Sole
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Reinforced Ergonomic Toe Box
• Midsole: Ergonomic Anti-Fatigue Cushion Insole
• Shaft Height: 11.5 cm | Weight: 750 g
• Sizing Range: EU 36 - 44
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Chef Series', 'APPROVED',
  14, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_Chef_Hitam_Sepatu_Slip_On_Dapur/hero_AP_Boots_AP_Chef_Hitam_Sepatu_Slip_On_Dapur.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_Chef_Hitam_Sepatu_Slip_On_Dapur/hero_AP_Boots_AP_Chef_Hitam_Sepatu_Slip_On_Dapur.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_Chef_Hitam_Sepatu_Slip_On_Dapur/side_AP_Boots_AP_Chef_Hitam_Sepatu_Slip_On_Dapur.webp", "https://catalog.hotstrading.com/assets/photobank/04_Chef_Series/SHP_003_AP_Boots_AP_Chef_Hitam_Se_slot_1_hero.webp", "https://catalog.hotstrading.com/assets/photobank/04_Chef_Series/SHP_003_AP_Boots_AP_Chef_Hitam_Se_slot_2_side.webp", "https://catalog.hotstrading.com/assets/photobank/04_Chef_Series/SHP_003_AP_Boots_AP_Chef_Hitam_Se_slot_3_tread.webp", "https://catalog.hotstrading.com/assets/photobank/04_Chef_Series/SHP_003_AP_Boots_AP_Chef_Hitam_Se_slot_4_usage.webp", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP Chef Hitam - Sepatu Slip On Dapur Shoes Karet - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP Chef Hitam - Sepatu Slip On Dapur Shoes Karet - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP Chef Hitam - Sepatu Slip On Dapur Shoes Karet - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP Chef Hitam - Sepatu Slip On Dapur Shoes Karet - 38/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP Chef Hitam - Sepatu Slip On Dapur Shoes Karet - 38/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 206700, 'IDR', 1, 1, 'ap-boots-ap-chef-hitam-mst-029',
  'Food Processing & HORECA', '["HERO #29 • COMMERCIAL KITCHEN PRO", "Oil & Grease Proof", "Non-Slip Siping"]', 0, 0, NOW(), NOW()
),
(
  2030, 'MST-030', 'AP Boots Footbed Sol AP CHEF', 'APB-051',
  'Food Processing & HORECA', 'Ultra-lightweight ergonomic footwear engineered for all-day standing comfort, non-slip sanitary tile traction, and quick sanitization.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Ortholite Memory Foam Pad • Oil & Grease SRC Anti-Slip Rubber Pods • Multi-Size
Target Sectors: Dapur Komersial HORECA, Bakery, Restoran Cepat Saji, Pabrik Pengolahan Makanan
Packaging: 12 Pairs / Master Carton (0.096 m³ • 11.5 kg)
Wholesale FOB Reference: $5.67 / pair (Rp 131,700 Factory List)

Technical Specifications:
• Upper: Ortholite Memory Foam Pad
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Reinforced Ergonomic Toe Box
• Midsole: Ergonomic Anti-Fatigue Cushion Insole
• Shaft Height: 1.5 cm | Weight: 120 g
• Sizing Range: Multi-Size
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Chef Series', 'APPROVED',
  14, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_Footbed_Sol_AP_CHEF_Ortholite/hero_AP_Boots_Footbed_Sol_AP_CHEF_Ortholite.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_Footbed_Sol_AP_CHEF_Ortholite/hero_AP_Boots_Footbed_Sol_AP_CHEF_Ortholite.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_Footbed_Sol_AP_CHEF_Ortholite/side_AP_Boots_Footbed_Sol_AP_CHEF_Ortholite.webp", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed Sol AP CHEF - Ortholite - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed Sol AP CHEF - Ortholite - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed Sol AP CHEF - Ortholite - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed Sol AP CHEF - Ortholite - 38/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed Sol AP CHEF - Ortholite - 38/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Biru - Ortholite - 37/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Biru - Ortholite - 37/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Biru - Ortholite - 37/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Biru - Ortholite - 37/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Biru - Ortholite - 37/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 131700, 'IDR', 1, 1, 'ap-boots-footbed-sol-ap-chef-mst-030',
  'Food Processing & HORECA', '["HERO #30 • COMMERCIAL KITCHEN PRO", "Oil & Grease Proof", "Non-Slip Siping"]', 0, 0, NOW(), NOW()
),
(
  2031, 'MST-031', 'AP Boots AP MEDIC Biru', 'APB-035',
  'Healthcare & Cleanroom Hygiene', 'Ultra-lightweight ergonomic footwear engineered for all-day standing comfort, non-slip sanitary tile traction, and quick sanitization.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Medical Grade PVC Antiseptik • Medical-Grade Anti-Slip Pattern • EU 36 - 43
Target Sectors: Rumah Sakit, Laboratorium Medis, Industri Farmasi, Cleanroom Semikonduktor, Sanitasi
Packaging: 12 Pairs / Master Carton (0.096 m³ • 9.5 kg)
Wholesale FOB Reference: $11.42 / pair (Rp 265,000 Factory List)

Technical Specifications:
• Upper: Medical Grade PVC Antiseptik
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Reinforced Hygiene Clog Toe
• Midsole: Orthopedic Shock-Absorbing Footbed
• Shaft Height: 9.0 cm | Weight: 580 g
• Sizing Range: EU 36 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Medic Series', 'APPROVED',
  15, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD/side_AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD.webp", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Biru - Sepatu Medis APD - 36/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Biru - Sepatu Medis APD - 36/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Biru - Sepatu Medis APD - 36/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Biru - Sepatu Medis APD - 36/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Biru - Sepatu Medis APD - 36/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Biru - Ortholite - 37/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Biru - Ortholite - 37/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Biru - Ortholite - 37/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Biru - Ortholite - 37/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Biru - Ortholite - 37/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 265000, 'IDR', 1, 1, 'ap-boots-ap-medic-biru-mst-031',
  'Healthcare & Cleanroom Hygiene', '["HERO #31 • HEALTHCARE & STERILE ROOMS", "Ortholite Footbed", "Anti-Bacterial"]', 0, 0, NOW(), NOW()
),
(
  2032, 'MST-032', 'AP Boots AP MEDIC Hijau', 'APB-036',
  'Healthcare & Cleanroom Hygiene', 'Ultra-lightweight ergonomic footwear engineered for all-day standing comfort, non-slip sanitary tile traction, and quick sanitization.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Medical Grade PVC Antiseptik • Medical-Grade Anti-Slip Pattern • EU 36 - 43
Target Sectors: Rumah Sakit, Laboratorium Medis, Industri Farmasi, Cleanroom Semikonduktor, Sanitasi
Packaging: 12 Pairs / Master Carton (0.096 m³ • 9.5 kg)
Wholesale FOB Reference: $11.67 / pair (Rp 271,000 Factory List)

Technical Specifications:
• Upper: Medical Grade PVC Antiseptik
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Reinforced Hygiene Clog Toe
• Midsole: Orthopedic Shock-Absorbing Footbed
• Shaft Height: 9.0 cm | Weight: 580 g
• Sizing Range: EU 36 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Medic Series', 'APPROVED',
  15, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Hijau_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Hijau_Sepatu_Medis_APD.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Hijau_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Hijau_Sepatu_Medis_APD.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Hijau_Sepatu_Medis_APD/side_AP_Boots_AP_MEDIC_Hijau_Sepatu_Medis_APD.webp", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hijau - Sepatu Medis APD - 36/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hijau - Sepatu Medis APD - 36/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hijau - Sepatu Medis APD - 36/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hijau - Sepatu Medis APD - 36/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hijau - Sepatu Medis APD - 36/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Biru - Sepatu Medis APD - 36/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Biru - Sepatu Medis APD - 36/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Biru - Sepatu Medis APD - 36/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Biru - Sepatu Medis APD - 36/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Biru - Sepatu Medis APD - 36/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 271000, 'IDR', 1, 1, 'ap-boots-ap-medic-hijau-mst-032',
  'Healthcare & Cleanroom Hygiene', '["HERO #32 • HEALTHCARE & STERILE ROOMS", "Ortholite Footbed", "Anti-Bacterial"]', 0, 0, NOW(), NOW()
),
(
  2033, 'MST-033', 'AP Boots AP MEDIC Putih', 'APB-037',
  'Healthcare & Cleanroom Hygiene', 'Ultra-lightweight ergonomic footwear engineered for all-day standing comfort, non-slip sanitary tile traction, and quick sanitization.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Sanitized Medical PVC • Medical-Grade Anti-Slip Pattern • EU 36 - 43
Target Sectors: Rumah Sakit, Laboratorium Medis, Industri Farmasi, Cleanroom Semikonduktor, Sanitasi
Packaging: 12 Pairs / Master Carton (0.096 m³ • 9.5 kg)
Wholesale FOB Reference: $11.18 / pair (Rp 259,540 Factory List)

Technical Specifications:
• Upper: Sanitized Medical PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Reinforced Hygiene Clog Toe
• Midsole: Orthopedic Shock-Absorbing Footbed
• Shaft Height: 9.0 cm | Weight: 580 g
• Sizing Range: EU 36 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Medic Series', 'APPROVED',
  15, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Putih_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Putih_Sepatu_Medis_APD.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Putih_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Putih_Sepatu_Medis_APD.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Putih_Sepatu_Medis_APD/side_AP_Boots_AP_MEDIC_Putih_Sepatu_Medis_APD.webp", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Putih - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Putih - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Putih - Sepatu Medis APD Safety Shoes - 36/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Putih - Sepatu Medis APD Safety Shoes - 36/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Putih - Sepatu Medis APD Safety Shoes - 36/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Biru - Sepatu Medis APD - 36/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Biru - Sepatu Medis APD - 36/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Biru - Sepatu Medis APD - 36/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Biru - Sepatu Medis APD - 36/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Biru - Sepatu Medis APD - 36/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 259540, 'IDR', 1, 1, 'ap-boots-ap-medic-putih-mst-033',
  'Healthcare & Cleanroom Hygiene', '["HERO #33 • HEALTHCARE & STERILE ROOMS", "Ortholite Footbed", "Anti-Bacterial"]', 0, 0, NOW(), NOW()
),
(
  2034, 'MST-034', 'AP Boots Footbed SOL AP Medic Biru', 'APB-060',
  'Healthcare & Cleanroom Hygiene', 'Ultra-lightweight ergonomic footwear engineered for all-day standing comfort, non-slip sanitary tile traction, and quick sanitization.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Ergonomic Insole Bed • Medical-Grade Anti-Slip Pattern • Multi-Size
Target Sectors: Rumah Sakit, Laboratorium Medis, Industri Farmasi, Cleanroom Semikonduktor, Sanitasi
Packaging: 12 Pairs / Master Carton (0.096 m³ • 9.5 kg)
Wholesale FOB Reference: $9.05 / pair (Rp 210,000 Factory List)

Technical Specifications:
• Upper: Ergonomic Insole Bed
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Reinforced Hygiene Clog Toe
• Midsole: Orthopedic Shock-Absorbing Footbed
• Shaft Height: 1.5 cm | Weight: 120 g
• Sizing Range: Multi-Size
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Medic Series', 'APPROVED',
  15, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD/side_AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD.webp", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Biru - Ortholite - 37/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Biru - Ortholite - 37/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Biru - Ortholite - 37/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Biru - Ortholite - 37/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Biru - Ortholite - 37/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Kuning - Ortholite - 36/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Kuning - Ortholite - 36/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Kuning - Ortholite - 36/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Kuning - Ortholite - 36/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Kuning - Ortholite - 36/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 210000, 'IDR', 1, 1, 'ap-boots-footbed-sol-ap-medic-biru-mst-034',
  'Healthcare & Cleanroom Hygiene', '["HERO #34 • HEALTHCARE & STERILE ROOMS", "Ortholite Footbed", "Anti-Bacterial"]', 0, 0, NOW(), NOW()
),
(
  2035, 'MST-035', 'AP Boots Footbed SOL AP Medic Kuning', 'APB-061',
  'Healthcare & Cleanroom Hygiene', 'Ultra-lightweight ergonomic footwear engineered for all-day standing comfort, non-slip sanitary tile traction, and quick sanitization.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Ergonomic Insole Bed • Medical-Grade Anti-Slip Pattern • Multi-Size
Target Sectors: Rumah Sakit, Laboratorium Medis, Industri Farmasi, Cleanroom Semikonduktor, Sanitasi
Packaging: 12 Pairs / Master Carton (0.096 m³ • 9.5 kg)
Wholesale FOB Reference: $6.76 / pair (Rp 157,000 Factory List)

Technical Specifications:
• Upper: Ergonomic Insole Bed
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Reinforced Hygiene Clog Toe
• Midsole: Orthopedic Shock-Absorbing Footbed
• Shaft Height: 1.5 cm | Weight: 120 g
• Sizing Range: Multi-Size
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Medic Series', 'APPROVED',
  15, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD/side_AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD.webp", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Kuning - Ortholite - 36/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Kuning - Ortholite - 36/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Kuning - Ortholite - 36/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Kuning - Ortholite - 36/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Kuning - Ortholite - 36/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Biru - Ortholite - 37/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Biru - Ortholite - 37/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Biru - Ortholite - 37/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Biru - Ortholite - 37/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Biru - Ortholite - 37/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 157000, 'IDR', 1, 1, 'ap-boots-footbed-sol-ap-medic-kuning-mst-035',
  'Healthcare & Cleanroom Hygiene', '["HERO #35 • HEALTHCARE & STERILE ROOMS", "Ortholite Footbed", "Anti-Bacterial"]', 0, 0, NOW(), NOW()
),
(
  2036, 'MST-036', 'AP Boots AP MEDIC Pink', 'APB-063',
  'Healthcare & Cleanroom Hygiene', 'Ultra-lightweight ergonomic footwear engineered for all-day standing comfort, non-slip sanitary tile traction, and quick sanitization.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Medical Grade PVC • Medical-Grade Anti-Slip Pattern • EU 36 - 41
Target Sectors: Rumah Sakit, Laboratorium Medis, Industri Farmasi, Cleanroom Semikonduktor, Sanitasi
Packaging: 12 Pairs / Master Carton (0.096 m³ • 9.5 kg)
Wholesale FOB Reference: $12.31 / pair (Rp 285,666 Factory List)

Technical Specifications:
• Upper: Medical Grade PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Reinforced Hygiene Clog Toe
• Midsole: Orthopedic Shock-Absorbing Footbed
• Shaft Height: 9.0 cm | Weight: 580 g
• Sizing Range: EU 36 - 41
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Medic Series', 'APPROVED',
  15, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Pink_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Pink_Sepatu_Medis_APD.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Pink_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Pink_Sepatu_Medis_APD.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Pink_Sepatu_Medis_APD/side_AP_Boots_AP_MEDIC_Pink_Sepatu_Medis_APD.webp", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Pink - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Pink - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Pink - Sepatu Medis APD Safety Shoes - 36/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Pink - Sepatu Medis APD Safety Shoes - 36/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Pink - Sepatu Medis APD Safety Shoes - 36/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Biru - Sepatu Medis APD - 36/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Biru - Sepatu Medis APD - 36/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Biru - Sepatu Medis APD - 36/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Biru - Sepatu Medis APD - 36/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Biru - Sepatu Medis APD - 36/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 285666, 'IDR', 1, 1, 'ap-boots-ap-medic-pink-mst-036',
  'Healthcare & Cleanroom Hygiene', '["HERO #36 • HEALTHCARE & STERILE ROOMS", "Ortholite Footbed", "Anti-Bacterial"]', 0, 0, NOW(), NOW()
),
(
  2037, 'MST-037', 'AP Boots AP MEDIC Hitam', 'APB-064',
  'Healthcare & Cleanroom Hygiene', 'Ultra-lightweight ergonomic footwear engineered for all-day standing comfort, non-slip sanitary tile traction, and quick sanitization.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Medical Grade PVC • Medical-Grade Anti-Slip Pattern • EU 37 - 43
Target Sectors: Rumah Sakit, Laboratorium Medis, Industri Farmasi, Cleanroom Semikonduktor, Sanitasi
Packaging: 12 Pairs / Master Carton (0.096 m³ • 9.5 kg)
Wholesale FOB Reference: $12.02 / pair (Rp 279,000 Factory List)

Technical Specifications:
• Upper: Medical Grade PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Reinforced Hygiene Clog Toe
• Midsole: Orthopedic Shock-Absorbing Footbed
• Shaft Height: 9.0 cm | Weight: 580 g
• Sizing Range: EU 37 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Medic Series', 'APPROVED',
  15, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Hitam_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Hitam_Sepatu_Medis_APD.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Hitam_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Hitam_Sepatu_Medis_APD.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Hitam_Sepatu_Medis_APD/side_AP_Boots_AP_MEDIC_Hitam_Sepatu_Medis_APD.webp", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Biru - Sepatu Medis APD - 36/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Biru - Sepatu Medis APD - 36/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Biru - Sepatu Medis APD - 36/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Biru - Sepatu Medis APD - 36/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Biru - Sepatu Medis APD - 36/05_gallery.jpg", "https://p16-images-common-sign-sg.tokopedia-static.net/tos-maliva-i-o3syd03w52-us/64dc839868b046eba37a3323a2b1d923~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 279000, 'IDR', 1, 1, 'ap-boots-ap-medic-hitam-mst-037',
  'Healthcare & Cleanroom Hygiene', '["HERO #37 • HEALTHCARE & STERILE ROOMS", "Ortholite Footbed", "Anti-Bacterial"]', 0, 0, NOW(), NOW()
),
(
  2038, 'MST-038', 'AP Boots AP ALLBIKE Orange', 'APB-001',
  'Commuter & Courier Logistics', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Breathable Vent PVC / Rubber Sole • Grooved Rain Water-Dispersion Sole • EU 38 - 43
Target Sectors: Kurir Logistik Ekspedisi, Pengendara Sepeda Motor Harian, Komuter Hujan, Touring
Packaging: 12 Pairs / Master Carton (0.096 m³ • 12.5 kg)
Wholesale FOB Reference: $2.85 / pair (Rp 66,150 Factory List)

Technical Specifications:
• Upper: Breathable Vent PVC / Rubber Sole
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Ankle Guard Protection)
• Midsole: None (Footpeg Gripping Sole)
• Shaft Height: 21.0 cm | Weight: 860 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Biker & Casual', 'APPROVED',
  16, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_ORANGE_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_ORANGE_Sepatu_Bike_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_ORANGE_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_ORANGE_Sepatu_Bike_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_ORANGE_Sepatu_Bike_PVC/side_AP_Boots_ALLBIKE_2_ORANGE_Sepatu_Bike_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ORANGE - Sepatu Bike PVC Outdoor Sepeda - 39/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ORANGE - Sepatu Bike PVC Outdoor Sepeda - 39/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ORANGE - Sepatu Bike PVC Outdoor Sepeda - 39/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ORANGE - Sepatu Bike PVC Outdoor Sepeda - 39/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ORANGE - Sepatu Bike PVC Outdoor Sepeda - 39/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Orange - Sepatu Bike PVC - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Orange - Sepatu Bike PVC - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Orange - Sepatu Bike PVC - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Orange - Sepatu Bike PVC - 38/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Orange - Sepatu Bike PVC - 38/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 66150, 'IDR', 1, 0, 'ap-boots-ap-allbike-orange-mst-038',
  'Commuter & Courier Logistics', '["HERO #38 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2039, 'MST-039', 'AP Boots AP ALLBIKE 2 ORANGE', 'APB-013',
  'Commuter & Courier Logistics', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Dual Injeksi PVC • Grooved Rain Water-Dispersion Sole • EU 38 - 44
Target Sectors: Kurir Logistik Ekspedisi, Pengendara Sepeda Motor Harian, Komuter Hujan, Touring
Packaging: 12 Pairs / Master Carton (0.096 m³ • 12.5 kg)
Wholesale FOB Reference: $2.85 / pair (Rp 66,150 Factory List)

Technical Specifications:
• Upper: Dual Injeksi PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Ankle Guard Protection)
• Midsole: None (Footpeg Gripping Sole)
• Shaft Height: 21.0 cm | Weight: 860 g
• Sizing Range: EU 38 - 44
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Biker & Casual', 'APPROVED',
  16, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_ORANGE_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_ORANGE_Sepatu_Bike_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_ORANGE_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_ORANGE_Sepatu_Bike_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_ORANGE_Sepatu_Bike_PVC/side_AP_Boots_ALLBIKE_2_ORANGE_Sepatu_Bike_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ORANGE - Sepatu Bike PVC Outdoor Sepeda - 39/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ORANGE - Sepatu Bike PVC Outdoor Sepeda - 39/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ORANGE - Sepatu Bike PVC Outdoor Sepeda - 39/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ORANGE - Sepatu Bike PVC Outdoor Sepeda - 39/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ORANGE - Sepatu Bike PVC Outdoor Sepeda - 39/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Orange - Sepatu Bike PVC - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Orange - Sepatu Bike PVC - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Orange - Sepatu Bike PVC - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Orange - Sepatu Bike PVC - 38/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Orange - Sepatu Bike PVC - 38/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 66150, 'IDR', 1, 0, 'ap-boots-ap-allbike-2-orange-mst-039',
  'Commuter & Courier Logistics', '["HERO #39 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2040, 'MST-040', 'AP Boots Hobby N Work', 'APB-027',
  'Commuter & Courier Logistics', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Soft PVC / Karet Sol • Grooved Rain Water-Dispersion Sole • EU 39 - 43
Target Sectors: Kurir Logistik Ekspedisi, Pengendara Sepeda Motor Harian, Komuter Hujan, Touring
Packaging: 12 Pairs / Master Carton (0.096 m³ • 12.5 kg)
Wholesale FOB Reference: $4.20 / pair (Rp 97,400 Factory List)

Technical Specifications:
• Upper: Soft PVC / Karet Sol
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Ankle Guard Protection)
• Midsole: None (Footpeg Gripping Sole)
• Shaft Height: 22.0 cm | Weight: 880 g
• Sizing Range: EU 39 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Biker & Casual', 'APPROVED',
  16, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_Hobby_N_Work_Sepatu_Boot_PVC/hero_AP_Boots_Hobby_N_Work_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_Hobby_N_Work_Sepatu_Boot_PVC/hero_AP_Boots_Hobby_N_Work_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_Hobby_N_Work_Sepatu_Boot_PVC/side_AP_Boots_Hobby_N_Work_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/photobank/06_Biker_Casual/APB-031_ap_boots_hobby_n_work_01.webp", "https://catalog.hotstrading.com/assets/photobank/06_Biker_Casual/APB-031_ap_boots_hobby_n_work_02.webp", "https://catalog.hotstrading.com/assets/photobank/11_General_Lifestyle_Boots/SHP_012_AP_Boots_Hobby_N_Work_Sep_slot_1_hero.webp", "https://catalog.hotstrading.com/assets/photobank/11_General_Lifestyle_Boots/SHP_012_AP_Boots_Hobby_N_Work_Sep_slot_2_side.webp", "https://catalog.hotstrading.com/assets/photobank/11_General_Lifestyle_Boots/SHP_012_AP_Boots_Hobby_N_Work_Sep_slot_3_tread.webp", "https://catalog.hotstrading.com/assets/photobank/11_General_Lifestyle_Boots/SHP_012_AP_Boots_Hobby_N_Work_Sep_slot_4_usage.webp"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 97400, 'IDR', 1, 0, 'ap-boots-ap-boots-hobby-n-work-mst-040',
  'Commuter & Courier Logistics', '["HERO #40 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2041, 'MST-041', 'AP Boots AP ALLBIKE Abu', 'APB-069',
  'Commuter & Courier Logistics', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Breathable Vent PVC • Grooved Rain Water-Dispersion Sole • EU 38 - 43
Target Sectors: Kurir Logistik Ekspedisi, Pengendara Sepeda Motor Harian, Komuter Hujan, Touring
Packaging: 12 Pairs / Master Carton (0.096 m³ • 12.5 kg)
Wholesale FOB Reference: $2.85 / pair (Rp 66,150 Factory List)

Technical Specifications:
• Upper: Breathable Vent PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Ankle Guard Protection)
• Midsole: None (Footpeg Gripping Sole)
• Shaft Height: 21.0 cm | Weight: 860 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Biker & Casual', 'APPROVED',
  16, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC/side_AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ABU - Sepatu Bike PVC - 39, Abu-abu/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ABU - Sepatu Bike PVC - 39, Abu-abu/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ABU - Sepatu Bike PVC - 39, Abu-abu/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ABU - Sepatu Bike PVC - 39, Abu-abu/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ABU - Sepatu Bike PVC - 39, Abu-abu/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Abu - Sepatu Bike PVC - 38, Abu-abu/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Abu - Sepatu Bike PVC - 38, Abu-abu/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Abu - Sepatu Bike PVC - 38, Abu-abu/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Abu - Sepatu Bike PVC - 38, Abu-abu/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Abu - Sepatu Bike PVC - 38, Abu-abu/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 66150, 'IDR', 1, 0, 'ap-boots-ap-allbike-abu-mst-041',
  'Commuter & Courier Logistics', '["HERO #41 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2042, 'MST-042', 'AP Boots AP ALLBIKE 2 HIJAU', 'APB-070',
  'Commuter & Courier Logistics', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: High Grip PVC Sole • Grooved Rain Water-Dispersion Sole • EU 38 - 43
Target Sectors: Kurir Logistik Ekspedisi, Pengendara Sepeda Motor Harian, Komuter Hujan, Touring
Packaging: 12 Pairs / Master Carton (0.096 m³ • 12.5 kg)
Wholesale FOB Reference: $2.67 / pair (Rp 61,900 Factory List)

Technical Specifications:
• Upper: High Grip PVC Sole
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Ankle Guard Protection)
• Midsole: None (Footpeg Gripping Sole)
• Shaft Height: 21.0 cm | Weight: 860 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Biker & Casual', 'APPROVED',
  16, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_HIJAU_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_HIJAU_Sepatu_Bike_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_HIJAU_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_HIJAU_Sepatu_Bike_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_HIJAU_Sepatu_Bike_PVC/side_AP_Boots_ALLBIKE_2_HIJAU_Sepatu_Bike_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 HIJAU - Sepatu Bike PVC - 39, Hijau/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 HIJAU - Sepatu Bike PVC - 39, Hijau/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 HIJAU - Sepatu Bike PVC - 39, Hijau/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 HIJAU - Sepatu Bike PVC - 39, Hijau/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 HIJAU - Sepatu Bike PVC - 39, Hijau/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Hijau - Sepatu Bike PVC/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Hijau - Sepatu Bike PVC/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Hijau - Sepatu Bike PVC/03_gallery.jpg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/VqbcmM/2022/8/18/0251b230-9eea-4381-b186-dca4478690b0.jpg~tplv-aphluv4xwc-white-pad-v1:1600:1600.jpeg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/VqbcmM/2022/8/18/2f24119b-9a1b-430c-848f-5f27e6ab0376.jpg~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 61900, 'IDR', 1, 0, 'ap-boots-ap-allbike-2-hijau-mst-042',
  'Commuter & Courier Logistics', '["HERO #42 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2043, 'MST-043', 'AP Boots AP ALLBIKE 2 ABU', 'APB-071',
  'Commuter & Courier Logistics', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Casual Motorcross Style • Grooved Rain Water-Dispersion Sole • EU 38 - 43
Target Sectors: Kurir Logistik Ekspedisi, Pengendara Sepeda Motor Harian, Komuter Hujan, Touring
Packaging: 12 Pairs / Master Carton (0.096 m³ • 12.5 kg)
Wholesale FOB Reference: $2.85 / pair (Rp 66,150 Factory List)

Technical Specifications:
• Upper: Casual Motorcross Style
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Ankle Guard Protection)
• Midsole: None (Footpeg Gripping Sole)
• Shaft Height: 21.0 cm | Weight: 860 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Biker & Casual', 'APPROVED',
  16, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC/side_AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ABU - Sepatu Bike PVC - 39, Abu-abu/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ABU - Sepatu Bike PVC - 39, Abu-abu/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ABU - Sepatu Bike PVC - 39, Abu-abu/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ABU - Sepatu Bike PVC - 39, Abu-abu/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ABU - Sepatu Bike PVC - 39, Abu-abu/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Abu - Sepatu Bike PVC - 38, Abu-abu/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Abu - Sepatu Bike PVC - 38, Abu-abu/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Abu - Sepatu Bike PVC - 38, Abu-abu/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Abu - Sepatu Bike PVC - 38, Abu-abu/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Abu - Sepatu Bike PVC - 38, Abu-abu/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 66150, 'IDR', 1, 0, 'ap-boots-ap-allbike-2-abu-mst-043',
  'Commuter & Courier Logistics', '["HERO #43 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2044, 'MST-044', 'AP Boots MOTO 1', 'APB-097',
  'Commuter & Courier Logistics', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Short Ankle PVC Boot • Grooved Rain Water-Dispersion Sole • EU 38 - 43
Target Sectors: Kurir Logistik Ekspedisi, Pengendara Sepeda Motor Harian, Komuter Hujan, Touring
Packaging: 12 Pairs / Master Carton (0.096 m³ • 12.5 kg)
Wholesale FOB Reference: $5.82 / pair (Rp 135,100 Factory List)

Technical Specifications:
• Upper: Short Ankle PVC Boot
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Ankle Guard Protection)
• Midsole: None (Footpeg Gripping Sole)
• Shaft Height: 21.0 cm | Weight: 860 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Biker & Casual', 'APPROVED',
  16, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_MOTO_1_Sepatu_Boot_PVC/hero_AP_Boots_MOTO_1_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_MOTO_1_Sepatu_Boot_PVC/hero_AP_Boots_MOTO_1_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_MOTO_1_Sepatu_Boot_PVC/side_AP_Boots_MOTO_1_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/photobank/06_Biker_Casual/SHP_016_AP_Boots_MOTO_1_Sepatu_Bo_slot_1_hero.webp", "https://catalog.hotstrading.com/assets/photobank/06_Biker_Casual/SHP_016_AP_Boots_MOTO_1_Sepatu_Bo_slot_2_side.webp", "https://catalog.hotstrading.com/assets/photobank/06_Biker_Casual/SHP_016_AP_Boots_MOTO_1_Sepatu_Bo_slot_3_tread.webp", "https://catalog.hotstrading.com/assets/photobank/06_Biker_Casual/SHP_016_AP_Boots_MOTO_1_Sepatu_Bo_slot_4_usage.webp", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots MOTO 1 -Sepatu Boot PVC/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots MOTO 1 -Sepatu Boot PVC/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots MOTO 1 -Sepatu Boot PVC/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots MOTO 2 - Sepatu Boot PVC Shoes Karet/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots MOTO 2 - Sepatu Boot PVC Shoes Karet/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots MOTO 2 - Sepatu Boot PVC Shoes Karet/03_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 135100, 'IDR', 1, 0, 'ap-boots-ap-boots-moto-1-mst-044',
  'Commuter & Courier Logistics', '["HERO #44 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2045, 'MST-045', 'AP Boots MOTO 2', 'APB-098',
  'Commuter & Courier Logistics', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Reinforced Ankle PVC • Grooved Rain Water-Dispersion Sole • EU 38 - 44
Target Sectors: Kurir Logistik Ekspedisi, Pengendara Sepeda Motor Harian, Komuter Hujan, Touring
Packaging: 12 Pairs / Master Carton (0.096 m³ • 12.5 kg)
Wholesale FOB Reference: $5.82 / pair (Rp 135,100 Factory List)

Technical Specifications:
• Upper: Reinforced Ankle PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Ankle Guard Protection)
• Midsole: None (Footpeg Gripping Sole)
• Shaft Height: 21.0 cm | Weight: 860 g
• Sizing Range: EU 38 - 44
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Biker & Casual', 'APPROVED',
  16, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_MOTO_1_Sepatu_Boot_PVC/hero_AP_Boots_MOTO_1_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_MOTO_1_Sepatu_Boot_PVC/hero_AP_Boots_MOTO_1_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_MOTO_1_Sepatu_Boot_PVC/side_AP_Boots_MOTO_1_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/photobank/06_Biker_Casual/SHP_009_AP_Boots_MOTO_2_Sepatu_Bo_slot_1_hero.webp", "https://catalog.hotstrading.com/assets/photobank/06_Biker_Casual/SHP_009_AP_Boots_MOTO_2_Sepatu_Bo_slot_2_side.webp", "https://catalog.hotstrading.com/assets/photobank/06_Biker_Casual/SHP_009_AP_Boots_MOTO_2_Sepatu_Bo_slot_3_tread.webp", "https://catalog.hotstrading.com/assets/photobank/06_Biker_Casual/SHP_009_AP_Boots_MOTO_2_Sepatu_Bo_slot_4_usage.webp", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots MOTO 1 -Sepatu Boot PVC/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots MOTO 1 -Sepatu Boot PVC/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots MOTO 1 -Sepatu Boot PVC/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots MOTO 2 - Sepatu Boot PVC Shoes Karet/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots MOTO 2 - Sepatu Boot PVC Shoes Karet/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots MOTO 2 - Sepatu Boot PVC Shoes Karet/03_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 135100, 'IDR', 1, 0, 'ap-boots-ap-boots-moto-2-mst-045',
  'Commuter & Courier Logistics', '["HERO #45 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2046, 'MST-046', 'AP Boots MOTO 3', 'APB-099',
  'Commuter & Courier Logistics', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Aerodynamic Riding PVC • Grooved Rain Water-Dispersion Sole • EU 38 - 44
Target Sectors: Kurir Logistik Ekspedisi, Pengendara Sepeda Motor Harian, Komuter Hujan, Touring
Packaging: 12 Pairs / Master Carton (0.096 m³ • 12.5 kg)
Wholesale FOB Reference: $5.82 / pair (Rp 135,100 Factory List)

Technical Specifications:
• Upper: Aerodynamic Riding PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Ankle Guard Protection)
• Midsole: None (Footpeg Gripping Sole)
• Shaft Height: 21.0 cm | Weight: 860 g
• Sizing Range: EU 38 - 44
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Biker & Casual', 'APPROVED',
  16, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_MOTO_1_Sepatu_Boot_PVC/hero_AP_Boots_MOTO_1_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_MOTO_1_Sepatu_Boot_PVC/hero_AP_Boots_MOTO_1_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_MOTO_1_Sepatu_Boot_PVC/side_AP_Boots_MOTO_1_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/photobank/06_Biker_Casual/SHP_018_AP_Boots_MOTO_3_Sepatu_Bo_slot_1_hero.webp", "https://catalog.hotstrading.com/assets/photobank/06_Biker_Casual/SHP_018_AP_Boots_MOTO_3_Sepatu_Bo_slot_2_side.webp", "https://catalog.hotstrading.com/assets/photobank/06_Biker_Casual/SHP_018_AP_Boots_MOTO_3_Sepatu_Bo_slot_3_tread.webp", "https://catalog.hotstrading.com/assets/photobank/06_Biker_Casual/SHP_018_AP_Boots_MOTO_3_Sepatu_Bo_slot_4_usage.webp", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots MOTO 1 -Sepatu Boot PVC/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots MOTO 1 -Sepatu Boot PVC/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots MOTO 1 -Sepatu Boot PVC/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots MOTO 2 - Sepatu Boot PVC Shoes Karet/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots MOTO 2 - Sepatu Boot PVC Shoes Karet/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots MOTO 2 - Sepatu Boot PVC Shoes Karet/03_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 135100, 'IDR', 1, 0, 'ap-boots-ap-boots-moto-3-mst-046',
  'Commuter & Courier Logistics', '["HERO #46 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2047, 'MST-047', 'AP Boots AP ALLBIKE 2', 'APB-104',
  'Commuter & Courier Logistics', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: All-Weather PVC • Grooved Rain Water-Dispersion Sole • EU 38 - 43
Target Sectors: Kurir Logistik Ekspedisi, Pengendara Sepeda Motor Harian, Komuter Hujan, Touring
Packaging: 12 Pairs / Master Carton (0.096 m³ • 12.5 kg)
Wholesale FOB Reference: $2.54 / pair (Rp 58,900 Factory List)

Technical Specifications:
• Upper: All-Weather PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Ankle Guard Protection)
• Midsole: None (Footpeg Gripping Sole)
• Shaft Height: 21.0 cm | Weight: 860 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Biker & Casual', 'APPROVED',
  16, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC/side_AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 - Sepatu Bike PVC/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 - Sepatu Bike PVC/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 - Sepatu Bike PVC/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ABU - Sepatu Bike PVC - 39, Abu-abu/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ABU - Sepatu Bike PVC - 39, Abu-abu/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ABU - Sepatu Bike PVC - 39, Abu-abu/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ABU - Sepatu Bike PVC - 39, Abu-abu/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ABU - Sepatu Bike PVC - 39, Abu-abu/05_gallery.jpg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/5b6fb6838ed84ce6b76ce43fb930d0b2~tplv-aphluv4xwc-white-pad-v1:1600:1600.jpeg", "https://p19-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/f2a4beb11b0241c5b6fa1bb77f218270~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 58900, 'IDR', 1, 0, 'ap-boots-ap-allbike-2-mst-047',
  'Commuter & Courier Logistics', '["HERO #47 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2048, 'MST-048', 'AP Boots AP ALLBIKE Hijau', 'APB-105',
  'Commuter & Courier Logistics', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Breathable Mesh-Pattern PVC • Grooved Rain Water-Dispersion Sole • EU 38 - 43
Target Sectors: Kurir Logistik Ekspedisi, Pengendara Sepeda Motor Harian, Komuter Hujan, Touring
Packaging: 12 Pairs / Master Carton (0.096 m³ • 12.5 kg)
Wholesale FOB Reference: $2.67 / pair (Rp 61,900 Factory List)

Technical Specifications:
• Upper: Breathable Mesh-Pattern PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Ankle Guard Protection)
• Midsole: None (Footpeg Gripping Sole)
• Shaft Height: 21.0 cm | Weight: 860 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Biker & Casual', 'APPROVED',
  16, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_HIJAU_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_HIJAU_Sepatu_Bike_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_HIJAU_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_HIJAU_Sepatu_Bike_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_HIJAU_Sepatu_Bike_PVC/side_AP_Boots_ALLBIKE_2_HIJAU_Sepatu_Bike_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 HIJAU - Sepatu Bike PVC - 39, Hijau/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 HIJAU - Sepatu Bike PVC - 39, Hijau/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 HIJAU - Sepatu Bike PVC - 39, Hijau/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 HIJAU - Sepatu Bike PVC - 39, Hijau/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 HIJAU - Sepatu Bike PVC - 39, Hijau/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Hijau - Sepatu Bike PVC/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Hijau - Sepatu Bike PVC/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Hijau - Sepatu Bike PVC/03_gallery.jpg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/VqbcmM/2022/8/18/0251b230-9eea-4381-b186-dca4478690b0.jpg~tplv-aphluv4xwc-white-pad-v1:1600:1600.jpeg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/VqbcmM/2022/8/18/2f24119b-9a1b-430c-848f-5f27e6ab0376.jpg~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 61900, 'IDR', 1, 0, 'ap-boots-ap-allbike-hijau-mst-048',
  'Commuter & Courier Logistics', '["HERO #48 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2049, 'MST-049', 'AP Boots AP ALLBIKE Merah', 'APB-106',
  'Commuter & Courier Logistics', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Dynamic Racing PVC • Grooved Rain Water-Dispersion Sole • EU 38 - 43
Target Sectors: Kurir Logistik Ekspedisi, Pengendara Sepeda Motor Harian, Komuter Hujan, Touring
Packaging: 12 Pairs / Master Carton (0.096 m³ • 12.5 kg)
Wholesale FOB Reference: $2.67 / pair (Rp 61,900 Factory List)

Technical Specifications:
• Upper: Dynamic Racing PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Ankle Guard Protection)
• Midsole: None (Footpeg Gripping Sole)
• Shaft Height: 21.0 cm | Weight: 860 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Biker & Casual', 'APPROVED',
  16, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_MERAH_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_MERAH_Sepatu_Bike_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_MERAH_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_MERAH_Sepatu_Bike_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_MERAH_Sepatu_Bike_PVC/side_AP_Boots_ALLBIKE_2_MERAH_Sepatu_Bike_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Merah - Sepatu Bike PVC Outdoor Sepeda - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Merah - Sepatu Bike PVC Outdoor Sepeda - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Merah - Sepatu Bike PVC Outdoor Sepeda - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Merah - Sepatu Bike PVC Outdoor Sepeda - 38/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Merah - Sepatu Bike PVC Outdoor Sepeda - 38/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 - Sepatu Bike PVC/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 - Sepatu Bike PVC/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 - Sepatu Bike PVC/03_gallery.jpg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/5b6fb6838ed84ce6b76ce43fb930d0b2~tplv-aphluv4xwc-white-pad-v1:1600:1600.jpeg", "https://p19-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/f2a4beb11b0241c5b6fa1bb77f218270~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 61900, 'IDR', 1, 0, 'ap-boots-ap-allbike-merah-mst-049',
  'Commuter & Courier Logistics', '["HERO #49 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2050, 'MST-050', 'AP Boots 2017 GREEN LIME', 'APB-002',
  'Sanitation & Monsoon Utilities', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Virgin PVC Transparan Mewah • Deep Cleat Tractor Tread • EU 38 - 43
Target Sectors: Penanganan Banjir Musiman, Dinas Kebersihan & Sanitasi Kota, Pekerjaan Rumah Tangga, Got & Saluran Air
Packaging: 12 Pairs / Master Carton (0.096 m³ • 18.0 kg)
Wholesale FOB Reference: $5.09 / pair (Rp 118,050 Factory List)

Technical Specifications:
• Upper: Virgin PVC Transparan Mewah
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Heavy PVC Reinforced Toe)
• Midsole: None
• Shaft Height: 36.0 cm | Weight: 1450 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Classic Boots', 'APPROVED',
  17, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2017_GREEN_LIME_Sepatu_Boot_PVC/hero_AP_Boots_2017_GREEN_LIME_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_2017_GREEN_LIME_Sepatu_Boot_PVC/hero_AP_Boots_2017_GREEN_LIME_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_2017_GREEN_LIME_Sepatu_Boot_PVC/side_AP_Boots_2017_GREEN_LIME_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 GREEN LIME - Sepatu Boot PVC Karet Shoes - 37/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 GREEN LIME - Sepatu Boot PVC Karet Shoes - 37/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 GREEN LIME - Sepatu Boot PVC Karet Shoes - 37/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 GREEN LIME - Sepatu Boot PVC Karet Shoes - 37/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 GREEN LIME - Sepatu Boot PVC Karet Shoes - 37/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 Green - Sepatu Boot PVC Karet Shoes - 37/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 Green - Sepatu Boot PVC Karet Shoes - 37/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 Green - Sepatu Boot PVC Karet Shoes - 37/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 Green - Sepatu Boot PVC Karet Shoes - 37/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 Green - Sepatu Boot PVC Karet Shoes - 37/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 118050, 'IDR', 1, 0, 'ap-boots-ap-boots-2017-green-lime-mst-050',
  'Sanitation & Monsoon Utilities', '["HERO #50 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2051, 'MST-051', 'AP Boots 2017 Green', 'APB-003',
  'Sanitation & Monsoon Utilities', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Tebal PVC Injeksi • Deep Cleat Tractor Tread • EU 38 - 43
Target Sectors: Penanganan Banjir Musiman, Dinas Kebersihan & Sanitasi Kota, Pekerjaan Rumah Tangga, Got & Saluran Air
Packaging: 12 Pairs / Master Carton (0.096 m³ • 18.0 kg)
Wholesale FOB Reference: $5.09 / pair (Rp 118,050 Factory List)

Technical Specifications:
• Upper: Tebal PVC Injeksi
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Heavy PVC Reinforced Toe)
• Midsole: None
• Shaft Height: 36.0 cm | Weight: 1450 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Classic Boots', 'APPROVED',
  17, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2017_GREEN_LIME_Sepatu_Boot_PVC/hero_AP_Boots_2017_GREEN_LIME_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_2017_GREEN_LIME_Sepatu_Boot_PVC/hero_AP_Boots_2017_GREEN_LIME_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_2017_GREEN_LIME_Sepatu_Boot_PVC/side_AP_Boots_2017_GREEN_LIME_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/photobank/07_Classic_Boots/APB-002_ap_boots_2017_green_product.webp", "https://catalog.hotstrading.com/assets/photobank/07_Classic_Boots/SHP_006_AP_Boots_2017_Green_Sepat_slot_1_hero.webp", "https://catalog.hotstrading.com/assets/photobank/07_Classic_Boots/SHP_006_AP_Boots_2017_Green_Sepat_slot_2_side.webp", "https://catalog.hotstrading.com/assets/photobank/07_Classic_Boots/SHP_006_AP_Boots_2017_Green_Sepat_slot_3_tread.webp", "https://catalog.hotstrading.com/assets/photobank/07_Classic_Boots/SHP_006_AP_Boots_2017_Green_Sepat_slot_4_usage.webp", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 Green - Sepatu Boot PVC Karet Shoes - 37/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 Green - Sepatu Boot PVC Karet Shoes - 37/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 Green - Sepatu Boot PVC Karet Shoes - 37/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 Green - Sepatu Boot PVC Karet Shoes - 37/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 Green - Sepatu Boot PVC Karet Shoes - 37/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 118050, 'IDR', 1, 0, 'ap-boots-ap-boots-2017-green-mst-051',
  'Sanitation & Monsoon Utilities', '["HERO #51 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2052, 'MST-052', 'AP Boots 2005 ROOTS N LEAVES', 'APB-004',
  'Sanitation & Monsoon Utilities', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Special Edition PVC • Deep Cleat Tractor Tread • EU 37 - 42
Target Sectors: Penanganan Banjir Musiman, Dinas Kebersihan & Sanitasi Kota, Pekerjaan Rumah Tangga, Got & Saluran Air
Packaging: 12 Pairs / Master Carton (0.096 m³ • 18.0 kg)
Wholesale FOB Reference: $3.88 / pair (Rp 90,175 Factory List)

Technical Specifications:
• Upper: Special Edition PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Heavy PVC Reinforced Toe)
• Midsole: None
• Shaft Height: 36.0 cm | Weight: 1450 g
• Sizing Range: EU 37 - 42
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Classic Boots', 'APPROVED',
  17, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2005_ROOTS_N_LEAVES_Sepatu_Boot_PVC/hero_AP_Boots_2005_ROOTS_N_LEAVES_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_2005_ROOTS_N_LEAVES_Sepatu_Boot_PVC/hero_AP_Boots_2005_ROOTS_N_LEAVES_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_2005_ROOTS_N_LEAVES_Sepatu_Boot_PVC/side_AP_Boots_2005_ROOTS_N_LEAVES_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2005 ROOTS N LEAVES - Sepatu Boot PVC Karet Wanita Wanita Sho/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2005 ROOTS N LEAVES - Sepatu Boot PVC Karet Wanita Wanita Sho/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2005 ROOTS N LEAVES - Sepatu Boot PVC Karet Wanita Wanita Sho/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2005 ROOTS N LEAVES - Sepatu Boot PVC Karet Wanita Wanita Sho/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2005 ROOTS N LEAVES - Sepatu Boot PVC Karet Wanita Wanita Sho/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2005 Hijau - Sepatu Boot PVC Karet Shoes - 23 = 3637/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2005 Hijau - Sepatu Boot PVC Karet Shoes - 23 = 3637/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2005 Hijau - Sepatu Boot PVC Karet Shoes - 23 = 3637/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2005 Hijau - Sepatu Boot PVC Karet Shoes - 23 = 3637/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2005 Hijau - Sepatu Boot PVC Karet Shoes - 23 = 3637/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 90175, 'IDR', 1, 0, 'ap-boots-ap-boots-2005-roots-n-leaves-mst-052',
  'Sanitation & Monsoon Utilities', '["HERO #52 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2053, 'MST-053', 'AP Boots 2005 Hijau', 'APB-005',
  'Sanitation & Monsoon Utilities', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Solid Waterproof PVC • Deep Cleat Tractor Tread • EU 38 - 43
Target Sectors: Penanganan Banjir Musiman, Dinas Kebersihan & Sanitasi Kota, Pekerjaan Rumah Tangga, Got & Saluran Air
Packaging: 12 Pairs / Master Carton (0.096 m³ • 18.0 kg)
Wholesale FOB Reference: $3.06 / pair (Rp 71,050 Factory List)

Technical Specifications:
• Upper: Solid Waterproof PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Heavy PVC Reinforced Toe)
• Midsole: None
• Shaft Height: 36.0 cm | Weight: 1450 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Classic Boots', 'APPROVED',
  17, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2005_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_2005_Hijau_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_2005_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_2005_Hijau_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_2005_Hijau_Sepatu_Boot_PVC/side_AP_Boots_2005_Hijau_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/photobank/07_Classic_Boots/APB-005_ap_boots_2005_hijau.webp", "https://catalog.hotstrading.com/assets/photobank/07_Classic_Boots/SHP_014_AP_Boots_2005_Hijau_Sepat_slot_1_hero.webp", "https://catalog.hotstrading.com/assets/photobank/07_Classic_Boots/SHP_014_AP_Boots_2005_Hijau_Sepat_slot_2_side.webp", "https://catalog.hotstrading.com/assets/photobank/07_Classic_Boots/SHP_014_AP_Boots_2005_Hijau_Sepat_slot_3_tread.webp", "https://catalog.hotstrading.com/assets/photobank/07_Classic_Boots/SHP_014_AP_Boots_2005_Hijau_Sepat_slot_4_usage.webp", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2005 Hijau - Sepatu Boot PVC Karet Shoes - 23 = 3637/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2005 Hijau - Sepatu Boot PVC Karet Shoes - 23 = 3637/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2005 Hijau - Sepatu Boot PVC Karet Shoes - 23 = 3637/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2005 Hijau - Sepatu Boot PVC Karet Shoes - 23 = 3637/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2005 Hijau - Sepatu Boot PVC Karet Shoes - 23 = 3637/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 71050, 'IDR', 1, 0, 'ap-boots-ap-boots-2005-hijau-mst-053',
  'Sanitation & Monsoon Utilities', '["HERO #53 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2054, 'MST-054', 'AP Boots 2003 Hijau TRICOLOUR', 'APB-006',
  'Sanitation & Monsoon Utilities', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Tricolour Injection PVC • Deep Cleat Tractor Tread • EU 38 - 43
Target Sectors: Penanganan Banjir Musiman, Dinas Kebersihan & Sanitasi Kota, Pekerjaan Rumah Tangga, Got & Saluran Air
Packaging: 12 Pairs / Master Carton (0.096 m³ • 18.0 kg)
Wholesale FOB Reference: $6.40 / pair (Rp 148,499 Factory List)

Technical Specifications:
• Upper: Tricolour Injection PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Heavy PVC Reinforced Toe)
• Midsole: None
• Shaft Height: 36.0 cm | Weight: 1450 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Classic Boots', 'APPROVED',
  17, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2003_Hijau_TRICOLOUR_Sepatu_Boot_PVC/hero_AP_Boots_2003_Hijau_TRICOLOUR_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_2003_Hijau_TRICOLOUR_Sepatu_Boot_PVC/hero_AP_Boots_2003_Hijau_TRICOLOUR_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_2003_Hijau_TRICOLOUR_Sepatu_Boot_PVC/side_AP_Boots_2003_Hijau_TRICOLOUR_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/photobank/07_Classic_Boots/APB-006_ap_boots_2003_hijau_tricolour.webp", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2003 Hijau TRICOLOUR - Sepatu Boot PVC Karet Shoes - 37/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2003 Hijau TRICOLOUR - Sepatu Boot PVC Karet Shoes - 37/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2003 Hijau TRICOLOUR - Sepatu Boot PVC Karet Shoes - 37/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2003 Hijau TRICOLOUR - Sepatu Boot PVC Karet Shoes - 37/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2003 Hijau TRICOLOUR - Sepatu Boot PVC Karet Shoes - 37/05_gallery.jpg", "https://p19-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/51d017ccabeb413ebc3709bbce25b2fc~tplv-aphluv4xwc-white-pad-v1:1600:1600.jpeg", "https://p19-images-common-sign-sg.tokopedia-static.net/tos-maliva-i-o3syd03w52-us/4d22b7f74123484a801064277dec872a~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg", "https://p16-images-common-sign-sg.tokopedia-static.net/tos-maliva-i-o3syd03w52-us/bd380c68ea64437e85e93f3fdcb5f73e~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//catalog-image/resize/ap-boots_sepatu-boots-tinggi-ap-boots-ap-2003-hijau-tua-sepatu-tricolour-kebun_full01.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 148499, 'IDR', 1, 0, 'ap-boots-ap-boots-2003-hijau-tricolour-mst-054',
  'Sanitation & Monsoon Utilities', '["HERO #54 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2055, 'MST-055', 'AP Boots 2017 Tosca', 'APB-012',
  'Sanitation & Monsoon Utilities', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Modern Soft PVC • Deep Cleat Tractor Tread • EU 38 - 43
Target Sectors: Penanganan Banjir Musiman, Dinas Kebersihan & Sanitasi Kota, Pekerjaan Rumah Tangga, Got & Saluran Air
Packaging: 12 Pairs / Master Carton (0.096 m³ • 18.0 kg)
Wholesale FOB Reference: $5.06 / pair (Rp 117,383 Factory List)

Technical Specifications:
• Upper: Modern Soft PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Heavy PVC Reinforced Toe)
• Midsole: None
• Shaft Height: 36.0 cm | Weight: 1450 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Classic Boots', 'APPROVED',
  17, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2017_Tosca_Sepatu_Boot_PVC/hero_AP_Boots_2017_Tosca_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_2017_Tosca_Sepatu_Boot_PVC/hero_AP_Boots_2017_Tosca_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_2017_Tosca_Sepatu_Boot_PVC/side_AP_Boots_2017_Tosca_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 Tosca - Sepatu Boot PVC - 37/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 Tosca - Sepatu Boot PVC - 37/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 Tosca - Sepatu Boot PVC - 37/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 Tosca - Sepatu Boot PVC - 37/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 Tosca - Sepatu Boot PVC - 37/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 Green - Sepatu Boot PVC Karet Shoes - 37/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 Green - Sepatu Boot PVC Karet Shoes - 37/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 Green - Sepatu Boot PVC Karet Shoes - 37/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 Green - Sepatu Boot PVC Karet Shoes - 37/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 Green - Sepatu Boot PVC Karet Shoes - 37/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 117383, 'IDR', 1, 0, 'ap-boots-ap-boots-2017-tosca-mst-055',
  'Sanitation & Monsoon Utilities', '["HERO #55 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2056, 'MST-056', 'AP Boots AP 969 Putih Cream', 'APB-014',
  'Fashion Waterproof Footwear', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Food Grade PVC • Herringbone Siped Rubber Sole • EU 38 - 43
Target Sectors: Pekerja Lapangan Santai, Gaya Kasual Tahan Air, Komuter Hujan Modis
Packaging: 12 Pairs / Master Carton (0.096 m³ • 11.5 kg)
Wholesale FOB Reference: $1.91 / pair (Rp 44,433 Factory List)

Technical Specifications:
• Upper: Food Grade PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Vulcanized Style Cap
• Midsole: Cushioned Insole
• Shaft Height: 9.0 cm | Weight: 680 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Kasual Sneakers', 'APPROVED',
  20, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_969_Putih_Cream_Sepatu_Bola_PVC/hero_AP_Boots_AP_969_Putih_Cream_Sepatu_Bola_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_969_Putih_Cream_Sepatu_Bola_PVC/hero_AP_Boots_AP_969_Putih_Cream_Sepatu_Bola_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_969_Putih_Cream_Sepatu_Bola_PVC/side_AP_Boots_AP_969_Putih_Cream_Sepatu_Bola_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP 969 Putih Cream - Sepatu Bola PVC - 37/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP 969 Putih Cream - Sepatu Bola PVC - 37/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP 969 Putih Cream - Sepatu Bola PVC - 37/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP 969 Putih Cream - Sepatu Bola PVC - 37/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP 969 Putih Cream - Sepatu Bola PVC - 37/05_gallery.jpg", "https://p16-images-common-sign-sg.tokopedia-static.net/tos-maliva-i-o3syd03w52-us/6faf6a5f7d984244b0f75220778e81d7~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg", "https://p16-images-common-sign-sg.tokopedia-static.net/tos-maliva-i-o3syd03w52-us/1acb59f7a5434824a662408f7e82bdef~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg", "https://p16-images-common-sign-sg.tokopedia-static.net/tos-maliva-i-o3syd03w52-us/568050a2d61c4f0690733ae563d800fe~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/medium/catalog-image/102/MTA-179240348/br-m036969-18270_sepatu-bola-ap-969-putih-multi-fungsi-sol-pul-pool-karet-lokal-lentur-ringan-sepak-bola_full02-00ad39eb.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/medium/catalog-image/102/MTA-179240348/br-m036969-18270_sepatu-bola-ap-969-putih-multi-fungsi-sol-pul-pool-karet-lokal-lentur-ringan-sepak-bola_full03-465d5735.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 44433, 'IDR', 1, 0, 'ap-boots-ap-boots-ap-969-putih-cream-mst-056',
  'Fashion Waterproof Footwear', '["HERO #56 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2057, 'MST-057', 'AP Boots XT Hijau', 'APB-020',
  'Sanitation & Monsoon Utilities', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Heavy Elastic PVC • Deep Cleat Tractor Tread • EU 38 - 43
Target Sectors: Penanganan Banjir Musiman, Dinas Kebersihan & Sanitasi Kota, Pekerjaan Rumah Tangga, Got & Saluran Air
Packaging: 12 Pairs / Master Carton (0.096 m³ • 18.0 kg)
Wholesale FOB Reference: $6.24 / pair (Rp 144,900 Factory List)

Technical Specifications:
• Upper: Heavy Elastic PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Heavy PVC Reinforced Toe)
• Midsole: None
• Shaft Height: 36.0 cm | Weight: 1450 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Classic Boots', 'APPROVED',
  17, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_XT_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_XT_Hijau_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_XT_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_XT_Hijau_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_XT_Hijau_Sepatu_Boot_PVC/side_AP_Boots_XT_Hijau_Sepatu_Boot_PVC.webp"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 144900, 'IDR', 1, 0, 'ap-boots-ap-boots-xt-hijau-mst-057',
  'Sanitation & Monsoon Utilities', '["HERO #57 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2058, 'MST-058', 'AP Boots 9506 Hijau', 'APB-028',
  'Sanitation & Monsoon Utilities', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Compact PVC • Deep Cleat Tractor Tread • EU 38 - 43
Target Sectors: Penanganan Banjir Musiman, Dinas Kebersihan & Sanitasi Kota, Pekerjaan Rumah Tangga, Got & Saluran Air
Packaging: 12 Pairs / Master Carton (0.096 m³ • 18.0 kg)
Wholesale FOB Reference: $6.37 / pair (Rp 147,845 Factory List)

Technical Specifications:
• Upper: Compact PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Heavy PVC Reinforced Toe)
• Midsole: None
• Shaft Height: 36.0 cm | Weight: 1450 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Classic Boots', 'APPROVED',
  17, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_9506_Sepatu_Boot_PVC/hero_AP_Boots_9506_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_9506_Sepatu_Boot_PVC/hero_AP_Boots_9506_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_9506_Sepatu_Boot_PVC/side_AP_Boots_9506_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 9506 Hijau - Sepatu Boot PVC Karet Shoes - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 9506 Hijau - Sepatu Boot PVC Karet Shoes - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 9506 Hijau - Sepatu Boot PVC Karet Shoes - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 9506 Hijau - Sepatu Boot PVC Karet Shoes - 38/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 9506 Hijau - Sepatu Boot PVC Karet Shoes - 38/05_gallery.jpg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/e6dfefdab5b54fdf869b744ebccfe9ba~tplv-aphluv4xwc-white-pad-v1:1600:1600.jpeg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/7a09384e9670416cab5a02632bd50bda~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/8d2f8cab146e47379a2b9289b01683ca~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//103/MTA-48025587/ap-boots_sepatu-boot-tinggi-ap-boots-ap-9506-hijau-karet-kebun-petani-proyek_full02.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//103/MTA-48025587/ap-boots_sepatu-boot-tinggi-ap-boots-ap-9506-hijau-karet-kebun-petani-proyek_full03.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 147845, 'IDR', 1, 0, 'ap-boots-ap-boots-9506-hijau-mst-058',
  'Sanitation & Monsoon Utilities', '["HERO #58 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2059, 'MST-059', 'AP Boots AP 963 Putih', 'APB-031',
  'Fashion Waterproof Footwear', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Higienis PVC • Herringbone Siped Rubber Sole • EU 38 - 43
Target Sectors: Pekerja Lapangan Santai, Gaya Kasual Tahan Air, Komuter Hujan Modis
Packaging: 12 Pairs / Master Carton (0.096 m³ • 11.5 kg)
Wholesale FOB Reference: $1.64 / pair (Rp 38,125 Factory List)

Technical Specifications:
• Upper: Higienis PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Vulcanized Style Cap
• Midsole: Cushioned Insole
• Shaft Height: 9.0 cm | Weight: 680 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Kasual Sneakers', 'APPROVED',
  20, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_963_Putih_Sepatu_Bola_PVC/hero_AP_Boots_AP_963_Putih_Sepatu_Bola_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_963_Putih_Sepatu_Bola_PVC/hero_AP_Boots_AP_963_Putih_Sepatu_Bola_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_963_Putih_Sepatu_Bola_PVC/side_AP_Boots_AP_963_Putih_Sepatu_Bola_PVC.webp", "https://catalog.hotstrading.com/assets/photobank/10_Kasual_Sneakers/SHP_011_AP_Boots_AP_963_Putih_Sep_slot_1_hero.webp", "https://catalog.hotstrading.com/assets/photobank/10_Kasual_Sneakers/SHP_011_AP_Boots_AP_963_Putih_Sep_slot_2_side.webp", "https://catalog.hotstrading.com/assets/photobank/10_Kasual_Sneakers/SHP_011_AP_Boots_AP_963_Putih_Sep_slot_3_tread.webp", "https://catalog.hotstrading.com/assets/photobank/10_Kasual_Sneakers/SHP_011_AP_Boots_AP_963_Putih_Sep_slot_4_usage.webp", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP 963 Putih - Sepatu Bola PVC - 39/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP 963 Putih - Sepatu Bola PVC - 39/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP 963 Putih - Sepatu Bola PVC - 39/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/11_AP_Specialty_Sports/AP Boots AP 963 Cream - Sepatu Bola PVC - 37/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/11_AP_Specialty_Sports/AP Boots AP 963 Cream - Sepatu Bola PVC - 37/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/11_AP_Specialty_Sports/AP Boots AP 963 Cream - Sepatu Bola PVC - 37/03_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 38125, 'IDR', 1, 0, 'ap-boots-ap-boots-ap-963-putih-mst-059',
  'Fashion Waterproof Footwear', '["HERO #59 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2060, 'MST-060', 'AP Boots AP 1 Hitam', 'APB-032',
  'Sanitation & Monsoon Utilities', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Thick Wall PVC • Deep Cleat Tractor Tread • EU 38 - 44
Target Sectors: Penanganan Banjir Musiman, Dinas Kebersihan & Sanitasi Kota, Pekerjaan Rumah Tangga, Got & Saluran Air
Packaging: 12 Pairs / Master Carton (0.096 m³ • 18.0 kg)
Wholesale FOB Reference: $3.66 / pair (Rp 85,000 Factory List)

Technical Specifications:
• Upper: Thick Wall PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Heavy PVC Reinforced Toe)
• Midsole: None
• Shaft Height: 36.0 cm | Weight: 1450 g
• Sizing Range: EU 38 - 44
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Classic Boots', 'APPROVED',
  17, 1, 'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_1001_HITAM_Sandal_Selop/hero_Ap_Boots_1001_HITAM_Sandal_Selop.webp', '["https://catalog.hotstrading.com/assets/shopee/Ap_Boots_1001_HITAM_Sandal_Selop/hero_Ap_Boots_1001_HITAM_Sandal_Selop.webp", "https://catalog.hotstrading.com/assets/shopee/Ap_Boots_1001_HITAM_Sandal_Selop/side_Ap_Boots_1001_HITAM_Sandal_Selop.webp"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 85000, 'IDR', 1, 0, 'ap-boots-ap-boots-ap-1-hitam-mst-060',
  'Sanitation & Monsoon Utilities', '["HERO #60 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2061, 'MST-061', 'AP Boots AP 1 Putih', 'APB-033',
  'Sanitation & Monsoon Utilities', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Food Safe PVC Compound • Deep Cleat Tractor Tread • EU 38 - 43
Target Sectors: Penanganan Banjir Musiman, Dinas Kebersihan & Sanitasi Kota, Pekerjaan Rumah Tangga, Got & Saluran Air
Packaging: 12 Pairs / Master Carton (0.096 m³ • 18.0 kg)
Wholesale FOB Reference: $3.66 / pair (Rp 85,000 Factory List)

Technical Specifications:
• Upper: Food Safe PVC Compound
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Heavy PVC Reinforced Toe)
• Midsole: None
• Shaft Height: 36.0 cm | Weight: 1450 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Classic Boots', 'APPROVED',
  17, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_1_Putih_Sepatu_Boots_PVC/hero_AP_Boots_AP_1_Putih_Sepatu_Boots_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_1_Putih_Sepatu_Boots_PVC/hero_AP_Boots_AP_1_Putih_Sepatu_Boots_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_1_Putih_Sepatu_Boots_PVC/side_AP_Boots_AP_1_Putih_Sepatu_Boots_PVC.webp"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 85000, 'IDR', 1, 0, 'ap-boots-ap-boots-ap-1-putih-mst-061',
  'Sanitation & Monsoon Utilities', '["HERO #61 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2062, 'MST-062', 'AP Boots 9303', 'APB-034',
  'Sanitation & Monsoon Utilities', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Lightweight PVC • Deep Cleat Tractor Tread • EU 38 - 43
Target Sectors: Penanganan Banjir Musiman, Dinas Kebersihan & Sanitasi Kota, Pekerjaan Rumah Tangga, Got & Saluran Air
Packaging: 12 Pairs / Master Carton (0.096 m³ • 18.0 kg)
Wholesale FOB Reference: $5.67 / pair (Rp 131,550 Factory List)

Technical Specifications:
• Upper: Lightweight PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Heavy PVC Reinforced Toe)
• Midsole: None
• Shaft Height: 36.0 cm | Weight: 1450 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Classic Boots', 'APPROVED',
  17, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_9303_Sepatu_Boot_PVC/hero_AP_Boots_9303_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_9303_Sepatu_Boot_PVC/hero_AP_Boots_9303_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_9303_Sepatu_Boot_PVC/side_AP_Boots_9303_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/photobank/07_Classic_Boots/APB-034_ap_boots_9303_rear_view_01.webp", "https://catalog.hotstrading.com/assets/photobank/07_Classic_Boots/APB-034_ap_boots_9303_rear_view_02.webp", "https://catalog.hotstrading.com/assets/tokopedia/12_AP_General_Boots/AP Boots 9303 - Sepatu Boot PVC - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/12_AP_General_Boots/AP Boots 9303 - Sepatu Boot PVC - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/12_AP_General_Boots/AP Boots 9303 - Sepatu Boot PVC - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/12_AP_General_Boots/AP Boots 9303 - Sepatu Boot PVC - 38/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/12_AP_General_Boots/AP Boots 9303 - Sepatu Boot PVC - 38/05_gallery.jpg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/VqbcmM/2021/7/15/5f78c21f-1f7c-4ff8-b72c-680613c392c3.png~tplv-aphluv4xwc-white-pad-v1:1600:1600.jpeg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/VqbcmM/2021/7/15/6ff69a90-85ed-4f20-960d-ce9f9a4221d6.jpg~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/VqbcmM/2021/7/15/5db86dd3-7eb7-432a-9524-5eaf6755f64b.jpg~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 131550, 'IDR', 1, 0, 'ap-boots-ap-boots-9303-mst-062',
  'Sanitation & Monsoon Utilities', '["HERO #62 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2063, 'MST-063', 'AP Boots AP 977 Hitam', 'APB-039',
  'Fashion Waterproof Footwear', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Rugged Sole PVC • Herringbone Siped Rubber Sole • EU 38 - 43
Target Sectors: Pekerja Lapangan Santai, Gaya Kasual Tahan Air, Komuter Hujan Modis
Packaging: 12 Pairs / Master Carton (0.096 m³ • 11.5 kg)
Wholesale FOB Reference: $2.43 / pair (Rp 56,525 Factory List)

Technical Specifications:
• Upper: Rugged Sole PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Vulcanized Style Cap
• Midsole: Cushioned Insole
• Shaft Height: 8.0 cm | Weight: 620 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Kasual Sneakers', 'APPROVED',
  20, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_977_Hitam_Sepatu_Pantofel_PVC/hero_AP_Boots_AP_977_Hitam_Sepatu_Pantofel_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_977_Hitam_Sepatu_Pantofel_PVC/hero_AP_Boots_AP_977_Hitam_Sepatu_Pantofel_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_977_Hitam_Sepatu_Pantofel_PVC/side_AP_Boots_AP_977_Hitam_Sepatu_Pantofel_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP 977 Hitam - Sepatu Pantofel PVC Flat Shoes - 37/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP 977 Hitam - Sepatu Pantofel PVC Flat Shoes - 37/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP 977 Hitam - Sepatu Pantofel PVC Flat Shoes - 37/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP 977 Hitam - Sepatu Pantofel PVC Flat Shoes - 37/04_gallery.jpg", "https://p16-images-common-sign-sg.tokopedia-static.net/tos-maliva-i-o3syd03w52-us/9ab94b72e5bc409a9e6dfdef6e81a659~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg", "https://p16-images-common-sign-sg.tokopedia-static.net/tos-maliva-i-o3syd03w52-us/874c8f64fc1548cfbf0641d611359710~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg", "https://p16-images-common-sign-sg.tokopedia-static.net/tos-maliva-i-o3syd03w52-us/57bd20a00f7e4237b02855f27db97a23~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//100/MTA-48025674/ap-boots_sepatu-pantofel-ap-boots-ap-977-hitam-sepatu-kantor_full02.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//100/MTA-48025674/ap_boots_sepatu_pantofel_ap_boots_ap_977_hitam_-_sepatu_kantor_full04_obzytaa4.jpg", "https://img.lazcdn.com/g/p/9cc9e13b8b9172c5e744073eb48d4a58.jpg_720x720q80.jpg_.webp"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 56525, 'IDR', 1, 0, 'ap-boots-ap-boots-ap-977-hitam-mst-063',
  'Fashion Waterproof Footwear', '["HERO #63 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2064, 'MST-064', 'AP Boots AP 2011 Hijau', 'APB-045',
  'Sanitation & Monsoon Utilities', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Durable Rubberized PVC • Deep Cleat Tractor Tread • EU 38 - 43
Target Sectors: Penanganan Banjir Musiman, Dinas Kebersihan & Sanitasi Kota, Pekerjaan Rumah Tangga, Got & Saluran Air
Packaging: 12 Pairs / Master Carton (0.096 m³ • 18.0 kg)
Wholesale FOB Reference: $3.88 / pair (Rp 90,175 Factory List)

Technical Specifications:
• Upper: Durable Rubberized PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Heavy PVC Reinforced Toe)
• Midsole: None
• Shaft Height: 36.0 cm | Weight: 1450 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Classic Boots', 'APPROVED',
  17, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_2011_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_AP_2011_Hijau_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_2011_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_AP_2011_Hijau_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_2011_Hijau_Sepatu_Boot_PVC/side_AP_Boots_AP_2011_Hijau_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/photobank/07_Classic_Boots/SHP_017_AP_Boots_AP_2011_Hijau_Se_slot_1_hero.webp", "https://catalog.hotstrading.com/assets/photobank/07_Classic_Boots/SHP_017_AP_Boots_AP_2011_Hijau_Se_slot_2_side.webp", "https://catalog.hotstrading.com/assets/photobank/07_Classic_Boots/SHP_017_AP_Boots_AP_2011_Hijau_Se_slot_3_tread.webp", "https://catalog.hotstrading.com/assets/photobank/07_Classic_Boots/SHP_017_AP_Boots_AP_2011_Hijau_Se_slot_4_usage.webp", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots AP 2011 Hijau - Sepatu Boot PVC - 36/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots AP 2011 Hijau - Sepatu Boot PVC - 36/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots AP 2011 Hijau - Sepatu Boot PVC - 36/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots AP 2011 Hijau - Sepatu Boot PVC - 36/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots AP 2011 Hijau - Sepatu Boot PVC - 36/05_gallery.jpg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/VqbcmM/2021/8/4/9667c443-43b1-49e8-81ed-c7e65e669d4c.jpg~tplv-aphluv4xwc-white-pad-v1:1600:1600.jpeg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 90175, 'IDR', 1, 0, 'ap-boots-ap-boots-ap-2011-hijau-mst-064',
  'Sanitation & Monsoon Utilities', '["HERO #64 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2065, 'MST-065', 'AP Boots 2018 Ultraflex Biru', 'APB-062',
  'Sanitation & Monsoon Utilities', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Ultraflex Polymer PVC • Deep Cleat Tractor Tread • EU 38 - 43
Target Sectors: Penanganan Banjir Musiman, Dinas Kebersihan & Sanitasi Kota, Pekerjaan Rumah Tangga, Got & Saluran Air
Packaging: 12 Pairs / Master Carton (0.096 m³ • 18.0 kg)
Wholesale FOB Reference: $8.08 / pair (Rp 187,566 Factory List)

Technical Specifications:
• Upper: Ultraflex Polymer PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Heavy PVC Reinforced Toe)
• Midsole: None
• Shaft Height: 36.0 cm | Weight: 1450 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Classic Boots', 'APPROVED',
  17, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2018_Ultraflex_Biru_Sepatu_Boot_PVC/hero_AP_Boots_2018_Ultraflex_Biru_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_2018_Ultraflex_Biru_Sepatu_Boot_PVC/hero_AP_Boots_2018_Ultraflex_Biru_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_2018_Ultraflex_Biru_Sepatu_Boot_PVC/side_AP_Boots_2018_Ultraflex_Biru_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Biru - Sepatu Boot PVC - 39/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Biru - Sepatu Boot PVC - 39/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Biru - Sepatu Boot PVC - 39/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Biru - Sepatu Boot PVC - 39/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Biru - Sepatu Boot PVC - 39/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Abu - Sepatu Boot PVC/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Abu - Sepatu Boot PVC/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Abu - Sepatu Boot PVC/03_gallery.jpg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/4e34a675029840788c890916cb622d4d~tplv-aphluv4xwc-white-pad-v1:1600:1600.jpeg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/hDjmkQ/2022/12/22/51f4ee37-ff73-4073-8338-1f5d9e849fc7.jpg~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 187566, 'IDR', 1, 0, 'ap-boots-ap-boots-2018-ultraflex-biru-mst-065',
  'Sanitation & Monsoon Utilities', '["HERO #65 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2066, 'MST-066', 'Ap Boots AP 3 BLACK', 'APB-077',
  'Sanitation & Monsoon Utilities', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Solid Work PVC • Deep Cleat Tractor Tread • EU 38 - 44
Target Sectors: Penanganan Banjir Musiman, Dinas Kebersihan & Sanitasi Kota, Pekerjaan Rumah Tangga, Got & Saluran Air
Packaging: 12 Pairs / Master Carton (0.096 m³ • 18.0 kg)
Wholesale FOB Reference: $3.66 / pair (Rp 85,000 Factory List)

Technical Specifications:
• Upper: Solid Work PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Heavy PVC Reinforced Toe)
• Midsole: None
• Shaft Height: 36.0 cm | Weight: 1450 g
• Sizing Range: EU 38 - 44
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Classic Boots', 'APPROVED',
  17, 1, 'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_AP_3_BLACK_Sepatu_Boots_PVC/hero_Ap_Boots_AP_3_BLACK_Sepatu_Boots_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/Ap_Boots_AP_3_BLACK_Sepatu_Boots_PVC/hero_Ap_Boots_AP_3_BLACK_Sepatu_Boots_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/Ap_Boots_AP_3_BLACK_Sepatu_Boots_PVC/side_Ap_Boots_AP_3_BLACK_Sepatu_Boots_PVC.webp"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 85000, 'IDR', 1, 0, 'ap-boots-ap-boots-ap-3-black-mst-066',
  'Sanitation & Monsoon Utilities', '["HERO #66 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2067, 'MST-067', 'Ap Boots 9905 HITAM', 'APB-078',
  'Sanitation & Monsoon Utilities', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Seamless Molded PVC • Deep Cleat Tractor Tread • EU 38 - 43
Target Sectors: Penanganan Banjir Musiman, Dinas Kebersihan & Sanitasi Kota, Pekerjaan Rumah Tangga, Got & Saluran Air
Packaging: 12 Pairs / Master Carton (0.096 m³ • 18.0 kg)
Wholesale FOB Reference: $5.00 / pair (Rp 116,066 Factory List)

Technical Specifications:
• Upper: Seamless Molded PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Heavy PVC Reinforced Toe)
• Midsole: None
• Shaft Height: 36.0 cm | Weight: 1450 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Classic Boots', 'APPROVED',
  17, 1, 'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_9905_HITAM_Sepatu_Boots_PVC/hero_Ap_Boots_9905_HITAM_Sepatu_Boots_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/Ap_Boots_9905_HITAM_Sepatu_Boots_PVC/hero_Ap_Boots_9905_HITAM_Sepatu_Boots_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/Ap_Boots_9905_HITAM_Sepatu_Boots_PVC/side_Ap_Boots_9905_HITAM_Sepatu_Boots_PVC.webp", "https://catalog.hotstrading.com/assets/photobank/11_General_Lifestyle_Boots/SHP_008_Ap_Boots_9905_HITAM_Sepat_slot_1_hero.webp", "https://catalog.hotstrading.com/assets/photobank/11_General_Lifestyle_Boots/SHP_008_Ap_Boots_9905_HITAM_Sepat_slot_2_side.webp", "https://catalog.hotstrading.com/assets/photobank/11_General_Lifestyle_Boots/SHP_008_Ap_Boots_9905_HITAM_Sepat_slot_3_tread.webp", "https://catalog.hotstrading.com/assets/photobank/11_General_Lifestyle_Boots/SHP_008_Ap_Boots_9905_HITAM_Sepat_slot_4_usage.webp", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 9905 HITAM - Sepatu Boots PVC - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 9905 HITAM - Sepatu Boots PVC - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 9905 HITAM - Sepatu Boots PVC - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 9905 HITAM - Sepatu Boots PVC - 38/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 9905 HITAM - Sepatu Boots PVC - 38/05_gallery.jpg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/VqbcmM/2022/11/15/ab43959e-5b1c-44ad-9871-80d60f2a556a.jpg~tplv-aphluv4xwc-white-pad-v1:1600:1600.jpeg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 116066, 'IDR', 1, 0, 'ap-boots-ap-boots-9905-hitam-mst-067',
  'Sanitation & Monsoon Utilities', '["HERO #67 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2068, 'MST-068', 'AP Boots AP 963 Cream', 'APB-082',
  'Fashion Waterproof Footwear', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Sanitized PVC • Herringbone Siped Rubber Sole • EU 38 - 43
Target Sectors: Pekerja Lapangan Santai, Gaya Kasual Tahan Air, Komuter Hujan Modis
Packaging: 12 Pairs / Master Carton (0.096 m³ • 11.5 kg)
Wholesale FOB Reference: $1.66 / pair (Rp 38,500 Factory List)

Technical Specifications:
• Upper: Sanitized PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Vulcanized Style Cap
• Midsole: Cushioned Insole
• Shaft Height: 9.0 cm | Weight: 680 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Kasual Sneakers', 'APPROVED',
  20, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_963_Cream_Sepatu_Bola_PVC/hero_AP_Boots_AP_963_Cream_Sepatu_Bola_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_963_Cream_Sepatu_Bola_PVC/hero_AP_Boots_AP_963_Cream_Sepatu_Bola_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_963_Cream_Sepatu_Bola_PVC/side_AP_Boots_AP_963_Cream_Sepatu_Bola_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/11_AP_Specialty_Sports/AP Boots AP 963 Cream - Sepatu Bola PVC - 37/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/11_AP_Specialty_Sports/AP Boots AP 963 Cream - Sepatu Bola PVC - 37/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/11_AP_Specialty_Sports/AP Boots AP 963 Cream - Sepatu Bola PVC - 37/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/11_AP_Specialty_Sports/AP Boots AP 963 Cream - Sepatu Bola PVC - 37/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/11_AP_Specialty_Sports/AP Boots AP 963 Cream - Sepatu Bola PVC - 37/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP 963 Putih - Sepatu Bola PVC - 39/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP 963 Putih - Sepatu Bola PVC - 39/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP 963 Putih - Sepatu Bola PVC - 39/03_gallery.jpg", "https://p19-images-common-sign-sg.tokopedia-static.net/tos-maliva-i-o3syd03w52-us/8ed5ea53768042b789d53f8c245a2376~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg", "https://p16-images-common-sign-sg.tokopedia-static.net/tos-maliva-i-o3syd03w52-us/49c1e7fdd11540778f370ba576e8e29b~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 38500, 'IDR', 1, 0, 'ap-boots-ap-boots-ap-963-cream-mst-068',
  'Fashion Waterproof Footwear', '["HERO #68 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2069, 'MST-069', 'AP Boots AP 967 Hitam', 'APB-086',
  'Fashion Waterproof Footwear', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Standard Utility PVC • Herringbone Siped Rubber Sole • EU 38 - 43
Target Sectors: Pekerja Lapangan Santai, Gaya Kasual Tahan Air, Komuter Hujan Modis
Packaging: 12 Pairs / Master Carton (0.096 m³ • 11.5 kg)
Wholesale FOB Reference: $1.72 / pair (Rp 39,900 Factory List)

Technical Specifications:
• Upper: Standard Utility PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Vulcanized Style Cap
• Midsole: Cushioned Insole
• Shaft Height: 9.0 cm | Weight: 680 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Kasual Sneakers', 'APPROVED',
  20, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_967_Hitam_Sepatu_Bola_PVC/hero_AP_Boots_AP_967_Hitam_Sepatu_Bola_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_967_Hitam_Sepatu_Bola_PVC/hero_AP_Boots_AP_967_Hitam_Sepatu_Bola_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_967_Hitam_Sepatu_Bola_PVC/side_AP_Boots_AP_967_Hitam_Sepatu_Bola_PVC.webp", "https://catalog.hotstrading.com/assets/photobank/10_Kasual_Sneakers/SHP_020_AP_Boots_AP_967_Hitam_Sep_slot_1_hero.webp", "https://catalog.hotstrading.com/assets/photobank/10_Kasual_Sneakers/SHP_020_AP_Boots_AP_967_Hitam_Sep_slot_2_side.webp", "https://catalog.hotstrading.com/assets/photobank/10_Kasual_Sneakers/SHP_020_AP_Boots_AP_967_Hitam_Sep_slot_3_tread.webp", "https://catalog.hotstrading.com/assets/photobank/10_Kasual_Sneakers/SHP_020_AP_Boots_AP_967_Hitam_Sep_slot_4_usage.webp", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP 967 Hitam - Sepatu Bola PVC Karet Shoes - 37/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP 967 Hitam - Sepatu Bola PVC Karet Shoes - 37/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP 967 Hitam - Sepatu Bola PVC Karet Shoes - 37/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP 967 Hitam - Sepatu Bola PVC Karet Shoes - 37/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP 967 Hitam - Sepatu Bola PVC Karet Shoes - 37/05_gallery.jpg", "https://p16-images-common-sign-sg.tokopedia-static.net/tos-maliva-i-o3syd03w52-us/ab82b1ddf77a468eb01d10441b448936~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 39900, 'IDR', 1, 0, 'ap-boots-ap-boots-ap-967-hitam-mst-069',
  'Fashion Waterproof Footwear', '["HERO #69 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2070, 'MST-070', 'AP Boots 2015 Ultimate Abu', 'APB-091',
  'Sanitation & Monsoon Utilities', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Dual Density PVC • Deep Cleat Tractor Tread • EU 38 - 43
Target Sectors: Penanganan Banjir Musiman, Dinas Kebersihan & Sanitasi Kota, Pekerjaan Rumah Tangga, Got & Saluran Air
Packaging: 12 Pairs / Master Carton (0.096 m³ • 18.0 kg)
Wholesale FOB Reference: $7.02 / pair (Rp 162,999 Factory List)

Technical Specifications:
• Upper: Dual Density PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Heavy PVC Reinforced Toe)
• Midsole: None
• Shaft Height: 36.0 cm | Weight: 1450 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Classic Boots', 'APPROVED',
  17, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2015_Ultimate_Abu_Sepatu_Boot_PVC/hero_AP_Boots_2015_Ultimate_Abu_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_2015_Ultimate_Abu_Sepatu_Boot_PVC/hero_AP_Boots_2015_Ultimate_Abu_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_2015_Ultimate_Abu_Sepatu_Boot_PVC/side_AP_Boots_2015_Ultimate_Abu_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Abu - Sepatu Boot PVC Shoes Karet/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Abu - Sepatu Boot PVC Shoes Karet/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Abu - Sepatu Boot PVC Shoes Karet/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Hijau - Sepatu Boot PVC/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Hijau - Sepatu Boot PVC/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Hijau - Sepatu Boot PVC/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Hijau - Sepatu Boot PVC/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Hijau - Sepatu Boot PVC/05_gallery.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//96/MTA-48025643/ap-boots_sepatu-boot-tinggi-ap-boots-ap-ultimate-2015-orange-tangguh-fleksibel_full02.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//96/MTA-48025643/ap-boots_sepatu-boot-tinggi-ap-boots-ap-ultimate-2015-orange-tangguh-fleksibel_full03.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 162999, 'IDR', 1, 0, 'ap-boots-ap-boots-2015-ultimate-abu-mst-070',
  'Sanitation & Monsoon Utilities', '["HERO #70 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2071, 'MST-071', 'AP Boots 2015 Ultimate Hitam', 'APB-092',
  'Sanitation & Monsoon Utilities', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Dual Density PVC • Deep Cleat Tractor Tread • EU 38 - 43
Target Sectors: Penanganan Banjir Musiman, Dinas Kebersihan & Sanitasi Kota, Pekerjaan Rumah Tangga, Got & Saluran Air
Packaging: 12 Pairs / Master Carton (0.096 m³ • 18.0 kg)
Wholesale FOB Reference: $7.29 / pair (Rp 169,133 Factory List)

Technical Specifications:
• Upper: Dual Density PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Heavy PVC Reinforced Toe)
• Midsole: None
• Shaft Height: 36.0 cm | Weight: 1450 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Classic Boots', 'APPROVED',
  17, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2015_Ultimate_Hitam_Sepatu_PVC/hero_AP_Boots_2015_Ultimate_Hitam_Sepatu_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_2015_Ultimate_Hitam_Sepatu_PVC/hero_AP_Boots_2015_Ultimate_Hitam_Sepatu_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_2015_Ultimate_Hitam_Sepatu_PVC/side_AP_Boots_2015_Ultimate_Hitam_Sepatu_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Hitam - Sepatu PVC Shoes Karet/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Hitam - Sepatu PVC Shoes Karet/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Hitam - Sepatu PVC Shoes Karet/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Abu - Sepatu Boot PVC Shoes Karet/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Abu - Sepatu Boot PVC Shoes Karet/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Abu - Sepatu Boot PVC Shoes Karet/03_gallery.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//96/MTA-48025643/ap-boots_sepatu-boot-tinggi-ap-boots-ap-ultimate-2015-orange-tangguh-fleksibel_full02.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//96/MTA-48025643/ap-boots_sepatu-boot-tinggi-ap-boots-ap-ultimate-2015-orange-tangguh-fleksibel_full03.jpg", "https://img.lazcdn.com/g/p/675e1cd6bb95d66d5dd091728f6dd79b.jpg_720x720q80.jpg_.webp", "https://img.lazcdn.com/g/p/f03b5676935e83fbb6c95e2f49b0688d.jpg_720x720q80.jpg_.webp"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 169133, 'IDR', 1, 0, 'ap-boots-ap-boots-2015-ultimate-hitam-mst-071',
  'Sanitation & Monsoon Utilities', '["HERO #71 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2072, 'MST-072', 'AP Boots 2015 Ultimate Hijau', 'APB-093',
  'Sanitation & Monsoon Utilities', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Dual Density PVC • Deep Cleat Tractor Tread • EU 38 - 43
Target Sectors: Penanganan Banjir Musiman, Dinas Kebersihan & Sanitasi Kota, Pekerjaan Rumah Tangga, Got & Saluran Air
Packaging: 12 Pairs / Master Carton (0.096 m³ • 18.0 kg)
Wholesale FOB Reference: $7.29 / pair (Rp 169,133 Factory List)

Technical Specifications:
• Upper: Dual Density PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Heavy PVC Reinforced Toe)
• Midsole: None
• Shaft Height: 36.0 cm | Weight: 1450 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Classic Boots', 'APPROVED',
  17, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2015_Ultimate_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_2015_Ultimate_Hijau_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_2015_Ultimate_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_2015_Ultimate_Hijau_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_2015_Ultimate_Hijau_Sepatu_Boot_PVC/side_AP_Boots_2015_Ultimate_Hijau_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Hijau - Sepatu Boot PVC/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Hijau - Sepatu Boot PVC/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Hijau - Sepatu Boot PVC/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Hijau - Sepatu Boot PVC/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Hijau - Sepatu Boot PVC/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Abu - Sepatu Boot PVC Shoes Karet/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Abu - Sepatu Boot PVC Shoes Karet/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Abu - Sepatu Boot PVC Shoes Karet/03_gallery.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//96/MTA-48025643/ap-boots_sepatu-boot-tinggi-ap-boots-ap-ultimate-2015-orange-tangguh-fleksibel_full02.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//96/MTA-48025643/ap-boots_sepatu-boot-tinggi-ap-boots-ap-ultimate-2015-orange-tangguh-fleksibel_full03.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 169133, 'IDR', 1, 0, 'ap-boots-ap-boots-2015-ultimate-hijau-mst-072',
  'Sanitation & Monsoon Utilities', '["HERO #72 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2073, 'MST-073', 'AP Boots 2015 Ultimate Orange', 'APB-094',
  'Sanitation & Monsoon Utilities', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Dual Density PVC • Deep Cleat Tractor Tread • EU 38 - 43
Target Sectors: Penanganan Banjir Musiman, Dinas Kebersihan & Sanitasi Kota, Pekerjaan Rumah Tangga, Got & Saluran Air
Packaging: 12 Pairs / Master Carton (0.096 m³ • 18.0 kg)
Wholesale FOB Reference: $7.29 / pair (Rp 169,133 Factory List)

Technical Specifications:
• Upper: Dual Density PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Heavy PVC Reinforced Toe)
• Midsole: None
• Shaft Height: 36.0 cm | Weight: 1450 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Classic Boots', 'APPROVED',
  17, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2015_Ultimate_Orange_Sepatu_Boot_PVC/hero_AP_Boots_2015_Ultimate_Orange_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_2015_Ultimate_Orange_Sepatu_Boot_PVC/hero_AP_Boots_2015_Ultimate_Orange_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_2015_Ultimate_Orange_Sepatu_Boot_PVC/side_AP_Boots_2015_Ultimate_Orange_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Orange - Sepatu Boot PVC Shoes Karet/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Orange - Sepatu Boot PVC Shoes Karet/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Orange - Sepatu Boot PVC Shoes Karet/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Abu - Sepatu Boot PVC Shoes Karet/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Abu - Sepatu Boot PVC Shoes Karet/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Abu - Sepatu Boot PVC Shoes Karet/03_gallery.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//96/MTA-48025643/ap-boots_sepatu-boot-tinggi-ap-boots-ap-ultimate-2015-orange-tangguh-fleksibel_full02.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//96/MTA-48025643/ap-boots_sepatu-boot-tinggi-ap-boots-ap-ultimate-2015-orange-tangguh-fleksibel_full03.jpg", "https://img.lazcdn.com/g/p/675e1cd6bb95d66d5dd091728f6dd79b.jpg_720x720q80.jpg_.webp", "https://img.lazcdn.com/g/p/f03b5676935e83fbb6c95e2f49b0688d.jpg_720x720q80.jpg_.webp"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 169133, 'IDR', 1, 0, 'ap-boots-ap-boots-2015-ultimate-orange-mst-073',
  'Sanitation & Monsoon Utilities', '["HERO #73 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2074, 'MST-074', 'AP Boots 2018 Ultraflex Abu', 'APB-100',
  'Sanitation & Monsoon Utilities', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Ultraflex Rubber-PVC • Deep Cleat Tractor Tread • EU 38 - 43
Target Sectors: Penanganan Banjir Musiman, Dinas Kebersihan & Sanitasi Kota, Pekerjaan Rumah Tangga, Got & Saluran Air
Packaging: 12 Pairs / Master Carton (0.096 m³ • 18.0 kg)
Wholesale FOB Reference: $8.08 / pair (Rp 187,566 Factory List)

Technical Specifications:
• Upper: Ultraflex Rubber-PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Heavy PVC Reinforced Toe)
• Midsole: None
• Shaft Height: 36.0 cm | Weight: 1450 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Classic Boots', 'APPROVED',
  17, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2018_Ultraflex_Abu_Sepatu_Boot_PVC/hero_AP_Boots_2018_Ultraflex_Abu_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_2018_Ultraflex_Abu_Sepatu_Boot_PVC/hero_AP_Boots_2018_Ultraflex_Abu_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_2018_Ultraflex_Abu_Sepatu_Boot_PVC/side_AP_Boots_2018_Ultraflex_Abu_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Abu - Sepatu Boot PVC/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Abu - Sepatu Boot PVC/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Abu - Sepatu Boot PVC/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Biru - Sepatu Boot PVC - 39/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Biru - Sepatu Boot PVC - 39/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Biru - Sepatu Boot PVC - 39/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Biru - Sepatu Boot PVC - 39/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Biru - Sepatu Boot PVC - 39/05_gallery.jpg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/afacc102d0cd4784b7b6fc6929b02eb2~tplv-aphluv4xwc-white-pad-v1:1600:1600.jpeg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/hDjmkQ/2022/12/22/19813733-f4ec-4dc2-b909-c28827961496.jpg~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 187566, 'IDR', 1, 0, 'ap-boots-ap-boots-2018-ultraflex-abu-mst-074',
  'Sanitation & Monsoon Utilities', '["HERO #74 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2075, 'MST-075', 'AP Boots 2018 Ultraflex Hijau', 'APB-101',
  'Sanitation & Monsoon Utilities', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Ultraflex Rubber-PVC • Deep Cleat Tractor Tread • EU 38 - 43
Target Sectors: Penanganan Banjir Musiman, Dinas Kebersihan & Sanitasi Kota, Pekerjaan Rumah Tangga, Got & Saluran Air
Packaging: 12 Pairs / Master Carton (0.096 m³ • 18.0 kg)
Wholesale FOB Reference: $8.08 / pair (Rp 187,566 Factory List)

Technical Specifications:
• Upper: Ultraflex Rubber-PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Heavy PVC Reinforced Toe)
• Midsole: None
• Shaft Height: 36.0 cm | Weight: 1450 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Classic Boots', 'APPROVED',
  17, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2018_Ultraflex_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_2018_Ultraflex_Hijau_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_2018_Ultraflex_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_2018_Ultraflex_Hijau_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_2018_Ultraflex_Hijau_Sepatu_Boot_PVC/side_AP_Boots_2018_Ultraflex_Hijau_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Hijau - Sepatu Boot PVC - 39/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Hijau - Sepatu Boot PVC - 39/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Hijau - Sepatu Boot PVC - 39/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Hijau - Sepatu Boot PVC - 39/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Hijau - Sepatu Boot PVC - 39/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Abu - Sepatu Boot PVC/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Abu - Sepatu Boot PVC/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Abu - Sepatu Boot PVC/03_gallery.jpg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/afacc102d0cd4784b7b6fc6929b02eb2~tplv-aphluv4xwc-white-pad-v1:1600:1600.jpeg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/hDjmkQ/2022/12/22/19813733-f4ec-4dc2-b909-c28827961496.jpg~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 187566, 'IDR', 1, 0, 'ap-boots-ap-boots-2018-ultraflex-hijau-mst-075',
  'Sanitation & Monsoon Utilities', '["HERO #75 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2076, 'MST-076', 'AP Boots 2007', 'APB-102',
  'Sanitation & Monsoon Utilities', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Traditional Heavy PVC • Deep Cleat Tractor Tread • EU 38 - 43
Target Sectors: Penanganan Banjir Musiman, Dinas Kebersihan & Sanitasi Kota, Pekerjaan Rumah Tangga, Got & Saluran Air
Packaging: 12 Pairs / Master Carton (0.096 m³ • 18.0 kg)
Wholesale FOB Reference: $4.25 / pair (Rp 98,766 Factory List)

Technical Specifications:
• Upper: Traditional Heavy PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Heavy PVC Reinforced Toe)
• Midsole: None
• Shaft Height: 36.0 cm | Weight: 1450 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Classic Boots', 'APPROVED',
  17, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2007_Sepatu_Boot_PVC/hero_AP_Boots_2007_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_2007_Sepatu_Boot_PVC/hero_AP_Boots_2007_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_2007_Sepatu_Boot_PVC/side_AP_Boots_2007_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2007 - Sepatu Boot Hijau PVC Karet Shoes/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2007 - Sepatu Boot Hijau PVC Karet Shoes/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2007 - Sepatu Boot Hijau PVC Karet Shoes/03_gallery.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//96/MTA-48025571/ap_boots_sepatu_boot_pendek_ap_boots_ap_2007_sepatu_kebun_pabrik_peternakan_full07_nge12k1l.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//96/MTA-48025571/ap_boots_sepatu_boot_pendek_ap_boots_ap_2007_sepatu_kebun_pabrik_peternakan_full08_jj13oodv.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 98766, 'IDR', 1, 0, 'ap-boots-ap-boots-2007-mst-076',
  'Sanitation & Monsoon Utilities', '["HERO #76 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2077, 'MST-077', 'AP Boots 2006', 'APB-103',
  'Sanitation & Monsoon Utilities', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Traditional Heavy PVC • Deep Cleat Tractor Tread • EU 38 - 43
Target Sectors: Penanganan Banjir Musiman, Dinas Kebersihan & Sanitasi Kota, Pekerjaan Rumah Tangga, Got & Saluran Air
Packaging: 12 Pairs / Master Carton (0.096 m³ • 18.0 kg)
Wholesale FOB Reference: $7.09 / pair (Rp 164,666 Factory List)

Technical Specifications:
• Upper: Traditional Heavy PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None (Heavy PVC Reinforced Toe)
• Midsole: None
• Shaft Height: 36.0 cm | Weight: 1450 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Classic Boots', 'APPROVED',
  17, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2006_Sepatu_Boot_PVC/hero_AP_Boots_2006_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_2006_Sepatu_Boot_PVC/hero_AP_Boots_2006_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_2006_Sepatu_Boot_PVC/side_AP_Boots_2006_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/12_AP_General_Boots/AP Boots 2006 - Sepatu Boot PVC/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/12_AP_General_Boots/AP Boots 2006 - Sepatu Boot PVC/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/12_AP_General_Boots/AP Boots 2006 - Sepatu Boot PVC/03_gallery.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//100/MTA-48025728/ap-boots_sepatu-boot-tinggi-ap-boots-ap-2006-hijau-triwarna-centimeter-perairan_full02.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//100/MTA-48025728/ap-boots_sepatu-boot-tinggi-ap-boots-ap-2006-hijau-triwarna-centimeter-perairan_full03.jpg", "https://img.lazcdn.com/g/p/54f3c811264034271f5869ee94306b0d.jpg_720x720q80.jpg_.webp", "https://img.lazcdn.com/g/p/170f16447cc1d07c582843f83c2418c6.jpg_720x720q80.jpg_.webp"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 164666, 'IDR', 1, 0, 'ap-boots-ap-boots-2006-mst-077',
  'Sanitation & Monsoon Utilities', '["HERO #77 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2078, 'MST-078', 'AP Boots AP KIDS 2012 MERAH STABILO', 'APB-017',
  'Children Outdoor & Monsoon', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Non-Toxic Flexible PVC • Wave Texture Non-Marking Sole • EU 28 - 35
Target Sectors: Anak Sekolah Musim Hujan, Aktivitas Luar Ruangan Taman, Bermain Genangan Air Bersih
Packaging: 12 Pairs / Master Carton (0.096 m³ • 8.5 kg)
Wholesale FOB Reference: $2.95 / pair (Rp 68,566 Factory List)

Technical Specifications:
• Upper: Non-Toxic Flexible PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Soft Flexible Rounded Toe (Phthalate Free)
• Midsole: None
• Shaft Height: 20.0 cm | Weight: 520 g
• Sizing Range: EU 28 - 35
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Kids Boots', 'APPROVED',
  18, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_MERAH_STABILO_MULTI_SIZE_BESAR_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_MERAH_STABILO_MULTI_SIZE_BESAR_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_MERAH_STABILO_MULTI_SIZE_BESAR_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_MERAH_STABILO_MULTI_SIZE_BESAR_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_MERAH_STABILO_MULTI_SIZE_BESAR_Sepatu_Boot_PVC/side_AP_Boots_AP_KIDS_2012_MERAH_STABILO_MULTI_SIZE_BESAR_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 MERAH STABILO MULTI SIZE BESAR - Sepatu Boot PVC/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 MERAH STABILO MULTI SIZE BESAR - Sepatu Boot PVC/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 MERAH STABILO MULTI SIZE BESAR - Sepatu Boot PVC/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 MERAH STABILO MULTI SIZE BESAR - Sepatu Boot PVC/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 MERAH STABILO MULTI SIZE BESAR - Sepatu Boot PVC/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 HIJAU STABILO MULTI SIZE BESAR - Sepatu Boot PVC/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 HIJAU STABILO MULTI SIZE BESAR - Sepatu Boot PVC/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 HIJAU STABILO MULTI SIZE BESAR - Sepatu Boot PVC/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 HIJAU STABILO MULTI SIZE BESAR - Sepatu Boot PVC/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 HIJAU STABILO MULTI SIZE BESAR - Sepatu Boot PVC/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 68566, 'IDR', 1, 0, 'ap-boots-ap-kids-2012-merah-stabilo-mst-078',
  'Children Outdoor & Monsoon', '["HERO #78 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2079, 'MST-079', 'AP Boots AP KIDS 2012 HIJAU STABILO', 'APB-018',
  'Children Outdoor & Monsoon', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Non-Toxic Flexible PVC • Wave Texture Non-Marking Sole • EU 28 - 35
Target Sectors: Anak Sekolah Musim Hujan, Aktivitas Luar Ruangan Taman, Bermain Genangan Air Bersih
Packaging: 12 Pairs / Master Carton (0.096 m³ • 8.5 kg)
Wholesale FOB Reference: $2.95 / pair (Rp 68,566 Factory List)

Technical Specifications:
• Upper: Non-Toxic Flexible PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Soft Flexible Rounded Toe (Phthalate Free)
• Midsole: None
• Shaft Height: 20.0 cm | Weight: 520 g
• Sizing Range: EU 28 - 35
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Kids Boots', 'APPROVED',
  18, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_MERAH_STABILO_MULTI_SIZE_BESAR_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_MERAH_STABILO_MULTI_SIZE_BESAR_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_MERAH_STABILO_MULTI_SIZE_BESAR_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_MERAH_STABILO_MULTI_SIZE_BESAR_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_MERAH_STABILO_MULTI_SIZE_BESAR_Sepatu_Boot_PVC/side_AP_Boots_AP_KIDS_2012_MERAH_STABILO_MULTI_SIZE_BESAR_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 HIJAU STABILO MULTI SIZE BESAR - Sepatu Boot PVC/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 HIJAU STABILO MULTI SIZE BESAR - Sepatu Boot PVC/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 HIJAU STABILO MULTI SIZE BESAR - Sepatu Boot PVC/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 HIJAU STABILO MULTI SIZE BESAR - Sepatu Boot PVC/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 HIJAU STABILO MULTI SIZE BESAR - Sepatu Boot PVC/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 MERAH STABILO MULTI SIZE BESAR - Sepatu Boot PVC/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 MERAH STABILO MULTI SIZE BESAR - Sepatu Boot PVC/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 MERAH STABILO MULTI SIZE BESAR - Sepatu Boot PVC/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 MERAH STABILO MULTI SIZE BESAR - Sepatu Boot PVC/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 MERAH STABILO MULTI SIZE BESAR - Sepatu Boot PVC/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 68566, 'IDR', 1, 0, 'ap-boots-ap-kids-2012-hijau-stabilo-mst-079',
  'Children Outdoor & Monsoon', '["HERO #79 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2080, 'MST-080', 'AP Boots AP KIDS 2012 UNGU STABILO', 'APB-019',
  'Children Outdoor & Monsoon', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Non-Toxic Flexible PVC • Wave Texture Non-Marking Sole • EU 28 - 35
Target Sectors: Anak Sekolah Musim Hujan, Aktivitas Luar Ruangan Taman, Bermain Genangan Air Bersih
Packaging: 12 Pairs / Master Carton (0.096 m³ • 8.5 kg)
Wholesale FOB Reference: $2.95 / pair (Rp 68,566 Factory List)

Technical Specifications:
• Upper: Non-Toxic Flexible PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Soft Flexible Rounded Toe (Phthalate Free)
• Midsole: None
• Shaft Height: 20.0 cm | Weight: 520 g
• Sizing Range: EU 28 - 35
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Kids Boots', 'APPROVED',
  18, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_UNGU_STABILO_MULTI_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_UNGU_STABILO_MULTI_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_UNGU_STABILO_MULTI_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_UNGU_STABILO_MULTI_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_UNGU_STABILO_MULTI_Sepatu_Boot_PVC/side_AP_Boots_AP_KIDS_2012_UNGU_STABILO_MULTI_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 UNGU STABILO MULTI - Sepatu Boot PVC Anak Kaki F/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 UNGU STABILO MULTI - Sepatu Boot PVC Anak Kaki F/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 UNGU STABILO MULTI - Sepatu Boot PVC Anak Kaki F/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 UNGU STABILO MULTI - Sepatu Boot PVC Anak Kaki F/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 UNGU STABILO MULTI - Sepatu Boot PVC Anak Kaki F/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 HIJAU STABILO MULTI SIZE BESAR - Sepatu Boot PVC/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 HIJAU STABILO MULTI SIZE BESAR - Sepatu Boot PVC/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 HIJAU STABILO MULTI SIZE BESAR - Sepatu Boot PVC/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 HIJAU STABILO MULTI SIZE BESAR - Sepatu Boot PVC/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 HIJAU STABILO MULTI SIZE BESAR - Sepatu Boot PVC/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 68566, 'IDR', 1, 0, 'ap-boots-ap-kids-2012-ungu-stabilo-mst-080',
  'Children Outdoor & Monsoon', '["HERO #80 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2081, 'MST-081', 'AP Boots AP KIDS SAFARI ELEPHANT', 'APB-042',
  'Children Outdoor & Monsoon', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Printed Safe PVC • Wave Texture Non-Marking Sole • EU 26 - 32
Target Sectors: Anak Sekolah Musim Hujan, Aktivitas Luar Ruangan Taman, Bermain Genangan Air Bersih
Packaging: 12 Pairs / Master Carton (0.096 m³ • 8.5 kg)
Wholesale FOB Reference: $2.57 / pair (Rp 59,566 Factory List)

Technical Specifications:
• Upper: Printed Safe PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Soft Flexible Rounded Toe (Phthalate Free)
• Midsole: None
• Shaft Height: 20.0 cm | Weight: 520 g
• Sizing Range: EU 26 - 32
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Kids Boots', 'APPROVED',
  18, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_SAFARI_ELEPHANT_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_SAFARI_ELEPHANT_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_SAFARI_ELEPHANT_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_SAFARI_ELEPHANT_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_SAFARI_ELEPHANT_Sepatu_Boot_PVC/side_AP_Boots_AP_KIDS_SAFARI_ELEPHANT_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI ELEPHANT - Sepatu Boot PVC Anak Motif - 24/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI ELEPHANT - Sepatu Boot PVC Anak Motif - 24/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI ELEPHANT - Sepatu Boot PVC Anak Motif - 24/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI ELEPHANT - Sepatu Boot PVC Anak Motif - 24/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI ELEPHANT - Sepatu Boot PVC Anak Motif - 24/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI CROCODILE - Sepatu Boot PVC Anak - 2223/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI CROCODILE - Sepatu Boot PVC Anak - 2223/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI CROCODILE - Sepatu Boot PVC Anak - 2223/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI CROCODILE - Sepatu Boot PVC Anak - 2223/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI CROCODILE - Sepatu Boot PVC Anak - 2223/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 59566, 'IDR', 1, 0, 'ap-boots-ap-kids-safari-elephant-mst-081',
  'Children Outdoor & Monsoon', '["HERO #81 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2082, 'MST-082', 'AP Boots AP KIDS SAFARI ZEBRA', 'APB-043',
  'Children Outdoor & Monsoon', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Printed Safe PVC • Wave Texture Non-Marking Sole • EU 26 - 32
Target Sectors: Anak Sekolah Musim Hujan, Aktivitas Luar Ruangan Taman, Bermain Genangan Air Bersih
Packaging: 12 Pairs / Master Carton (0.096 m³ • 8.5 kg)
Wholesale FOB Reference: $2.57 / pair (Rp 59,566 Factory List)

Technical Specifications:
• Upper: Printed Safe PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Soft Flexible Rounded Toe (Phthalate Free)
• Midsole: None
• Shaft Height: 20.0 cm | Weight: 520 g
• Sizing Range: EU 26 - 32
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Kids Boots', 'APPROVED',
  18, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_SAFARI_ZEBRA_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_SAFARI_ZEBRA_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_SAFARI_ZEBRA_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_SAFARI_ZEBRA_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_SAFARI_ZEBRA_Sepatu_Boot_PVC/side_AP_Boots_AP_KIDS_SAFARI_ZEBRA_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI ZEBRA - Sepatu Boot PVC - 2223/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI ZEBRA - Sepatu Boot PVC - 2223/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI ZEBRA - Sepatu Boot PVC - 2223/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI ZEBRA - Sepatu Boot PVC - 2223/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI ZEBRA - Sepatu Boot PVC - 2223/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI CROCODILE - Sepatu Boot PVC Anak - 2223/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI CROCODILE - Sepatu Boot PVC Anak - 2223/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI CROCODILE - Sepatu Boot PVC Anak - 2223/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI CROCODILE - Sepatu Boot PVC Anak - 2223/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI CROCODILE - Sepatu Boot PVC Anak - 2223/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 59566, 'IDR', 1, 0, 'ap-boots-ap-kids-safari-zebra-mst-082',
  'Children Outdoor & Monsoon', '["HERO #82 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2083, 'MST-083', 'AP Boots AP KIDS SAFARI CROCODILE', 'APB-044',
  'Children Outdoor & Monsoon', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Printed Safe PVC • Wave Texture Non-Marking Sole • EU 26 - 32
Target Sectors: Anak Sekolah Musim Hujan, Aktivitas Luar Ruangan Taman, Bermain Genangan Air Bersih
Packaging: 12 Pairs / Master Carton (0.096 m³ • 8.5 kg)
Wholesale FOB Reference: $2.57 / pair (Rp 59,566 Factory List)

Technical Specifications:
• Upper: Printed Safe PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Soft Flexible Rounded Toe (Phthalate Free)
• Midsole: None
• Shaft Height: 20.0 cm | Weight: 520 g
• Sizing Range: EU 26 - 32
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Kids Boots', 'APPROVED',
  18, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_SAFARI_CROCODILE_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_SAFARI_CROCODILE_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_SAFARI_CROCODILE_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_SAFARI_CROCODILE_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_SAFARI_CROCODILE_Sepatu_Boot_PVC/side_AP_Boots_AP_KIDS_SAFARI_CROCODILE_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI CROCODILE - Sepatu Boot PVC Anak - 2223/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI CROCODILE - Sepatu Boot PVC Anak - 2223/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI CROCODILE - Sepatu Boot PVC Anak - 2223/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI CROCODILE - Sepatu Boot PVC Anak - 2223/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI CROCODILE - Sepatu Boot PVC Anak - 2223/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI ELEPHANT - Sepatu Boot PVC Anak Motif - 24/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI ELEPHANT - Sepatu Boot PVC Anak Motif - 24/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI ELEPHANT - Sepatu Boot PVC Anak Motif - 24/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI ELEPHANT - Sepatu Boot PVC Anak Motif - 24/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI ELEPHANT - Sepatu Boot PVC Anak Motif - 24/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 59566, 'IDR', 1, 0, 'ap-boots-ap-kids-safari-crocodile-mst-083',
  'Children Outdoor & Monsoon', '["HERO #83 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2084, 'MST-084', 'AP Boots AP KIDS 2012 LEMON POLKADOT', 'APB-049',
  'Children Outdoor & Monsoon', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Printed PVC Bebas Timbal • Wave Texture Non-Marking Sole • EU 27 - 34
Target Sectors: Anak Sekolah Musim Hujan, Aktivitas Luar Ruangan Taman, Bermain Genangan Air Bersih
Packaging: 12 Pairs / Master Carton (0.096 m³ • 8.5 kg)
Wholesale FOB Reference: $2.82 / pair (Rp 65,425 Factory List)

Technical Specifications:
• Upper: Printed PVC Bebas Timbal
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Soft Flexible Rounded Toe (Phthalate Free)
• Midsole: None
• Shaft Height: 20.0 cm | Weight: 520 g
• Sizing Range: EU 27 - 34
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Kids Boots', 'APPROVED',
  18, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_LEMON_POLKADOT_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_LEMON_POLKADOT_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_LEMON_POLKADOT_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_LEMON_POLKADOT_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_LEMON_POLKADOT_Sepatu_Boot_PVC/side_AP_Boots_AP_KIDS_2012_LEMON_POLKADOT_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 LEMON POLKADOT - Sepatu Boot PVC - 15/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 LEMON POLKADOT - Sepatu Boot PVC - 15/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 LEMON POLKADOT - Sepatu Boot PVC - 15/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 LEMON POLKADOT - Sepatu Boot PVC - 15/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 LEMON POLKADOT - Sepatu Boot PVC - 15/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP KIDS 2012 MIXED BLACK FUXIA - Sepatu Boot PVC - 15/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP KIDS 2012 MIXED BLACK FUXIA - Sepatu Boot PVC - 15/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP KIDS 2012 MIXED BLACK FUXIA - Sepatu Boot PVC - 15/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP KIDS 2012 MIXED BLACK FUXIA - Sepatu Boot PVC - 15/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP KIDS 2012 MIXED BLACK FUXIA - Sepatu Boot PVC - 15/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 65425, 'IDR', 1, 0, 'ap-boots-ap-kids-2012-lemon-polkadot-mst-084',
  'Children Outdoor & Monsoon', '["HERO #84 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2085, 'MST-085', 'AP Boots AP KIDS 2012 MIXED BLACK FUXIA', 'APB-050',
  'Children Outdoor & Monsoon', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Dual Tone PVC • Wave Texture Non-Marking Sole • EU 28 - 35
Target Sectors: Anak Sekolah Musim Hujan, Aktivitas Luar Ruangan Taman, Bermain Genangan Air Bersih
Packaging: 12 Pairs / Master Carton (0.096 m³ • 8.5 kg)
Wholesale FOB Reference: $2.95 / pair (Rp 68,566 Factory List)

Technical Specifications:
• Upper: Dual Tone PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Soft Flexible Rounded Toe (Phthalate Free)
• Midsole: None
• Shaft Height: 20.0 cm | Weight: 520 g
• Sizing Range: EU 28 - 35
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Kids Boots', 'APPROVED',
  18, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_MIXED_BLACK_FUXIA_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_MIXED_BLACK_FUXIA_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_MIXED_BLACK_FUXIA_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_MIXED_BLACK_FUXIA_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_MIXED_BLACK_FUXIA_Sepatu_Boot_PVC/side_AP_Boots_AP_KIDS_2012_MIXED_BLACK_FUXIA_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP KIDS 2012 MIXED BLACK FUXIA - Sepatu Boot PVC - 15/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP KIDS 2012 MIXED BLACK FUXIA - Sepatu Boot PVC - 15/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP KIDS 2012 MIXED BLACK FUXIA - Sepatu Boot PVC - 15/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP KIDS 2012 MIXED BLACK FUXIA - Sepatu Boot PVC - 15/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP KIDS 2012 MIXED BLACK FUXIA - Sepatu Boot PVC - 15/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 FUXIA STRIPE - Sepatu Boot PVC Anak Kaki Motif F/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 FUXIA STRIPE - Sepatu Boot PVC Anak Kaki Motif F/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 FUXIA STRIPE - Sepatu Boot PVC Anak Kaki Motif F/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 FUXIA STRIPE - Sepatu Boot PVC Anak Kaki Motif F/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 FUXIA STRIPE - Sepatu Boot PVC Anak Kaki Motif F/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 68566, 'IDR', 1, 0, 'ap-boots-ap-kids-2012-mixed-black-fuxia-mst-085',
  'Children Outdoor & Monsoon', '["HERO #85 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2086, 'MST-086', 'AP Boots AP KIDS 2012 BLUE JEANS', 'APB-065',
  'Children Outdoor & Monsoon', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Texture Look PVC • Wave Texture Non-Marking Sole • EU 28 - 35
Target Sectors: Anak Sekolah Musim Hujan, Aktivitas Luar Ruangan Taman, Bermain Genangan Air Bersih
Packaging: 12 Pairs / Master Carton (0.096 m³ • 8.5 kg)
Wholesale FOB Reference: $2.95 / pair (Rp 68,566 Factory List)

Technical Specifications:
• Upper: Texture Look PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Soft Flexible Rounded Toe (Phthalate Free)
• Midsole: None
• Shaft Height: 20.0 cm | Weight: 520 g
• Sizing Range: EU 28 - 35
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Kids Boots', 'APPROVED',
  18, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_BLUE_JEANS_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_BLUE_JEANS_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_BLUE_JEANS_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_BLUE_JEANS_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_BLUE_JEANS_Sepatu_Boot_PVC/side_AP_Boots_AP_KIDS_2012_BLUE_JEANS_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 BLUE JEANS - Sepatu Boot PVC Anak Motif - 15/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 BLUE JEANS - Sepatu Boot PVC Anak Motif - 15/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 BLUE JEANS - Sepatu Boot PVC Anak Motif - 15/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 BLUE JEANS - Sepatu Boot PVC Anak Motif - 15/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 BLUE JEANS - Sepatu Boot PVC Anak Motif - 15/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP KIDS 2012 MIXED BLACK FUXIA - Sepatu Boot PVC - 15/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP KIDS 2012 MIXED BLACK FUXIA - Sepatu Boot PVC - 15/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP KIDS 2012 MIXED BLACK FUXIA - Sepatu Boot PVC - 15/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP KIDS 2012 MIXED BLACK FUXIA - Sepatu Boot PVC - 15/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP KIDS 2012 MIXED BLACK FUXIA - Sepatu Boot PVC - 15/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 68566, 'IDR', 1, 0, 'ap-boots-ap-kids-2012-blue-jeans-mst-086',
  'Children Outdoor & Monsoon', '["HERO #86 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2087, 'MST-087', 'AP Boots AP KIDS 2012 VIOLET CIRCLE', 'APB-066',
  'Children Outdoor & Monsoon', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Printed Fun PVC • Wave Texture Non-Marking Sole • EU 28 - 35
Target Sectors: Anak Sekolah Musim Hujan, Aktivitas Luar Ruangan Taman, Bermain Genangan Air Bersih
Packaging: 12 Pairs / Master Carton (0.096 m³ • 8.5 kg)
Wholesale FOB Reference: $2.67 / pair (Rp 61,900 Factory List)

Technical Specifications:
• Upper: Printed Fun PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Soft Flexible Rounded Toe (Phthalate Free)
• Midsole: None
• Shaft Height: 20.0 cm | Weight: 520 g
• Sizing Range: EU 28 - 35
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Kids Boots', 'APPROVED',
  18, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_BLUE_JEANS_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_BLUE_JEANS_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_BLUE_JEANS_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_BLUE_JEANS_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_BLUE_JEANS_Sepatu_Boot_PVC/side_AP_Boots_AP_KIDS_2012_BLUE_JEANS_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 VIOLET CIRCLE- Sepatu Boot PVC Anak Motif - 15/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 VIOLET CIRCLE- Sepatu Boot PVC Anak Motif - 15/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 VIOLET CIRCLE- Sepatu Boot PVC Anak Motif - 15/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 VIOLET CIRCLE- Sepatu Boot PVC Anak Motif - 15/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 VIOLET CIRCLE- Sepatu Boot PVC Anak Motif - 15/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP KIDS 2012 MIXED BLACK FUXIA - Sepatu Boot PVC - 15/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP KIDS 2012 MIXED BLACK FUXIA - Sepatu Boot PVC - 15/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP KIDS 2012 MIXED BLACK FUXIA - Sepatu Boot PVC - 15/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP KIDS 2012 MIXED BLACK FUXIA - Sepatu Boot PVC - 15/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP KIDS 2012 MIXED BLACK FUXIA - Sepatu Boot PVC - 15/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 61900, 'IDR', 1, 0, 'ap-boots-ap-kids-2012-violet-circle-mst-087',
  'Children Outdoor & Monsoon', '["HERO #87 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2088, 'MST-088', 'AP Boots AP KIDS 2012 FUXIA STRIPE', 'APB-067',
  'Children Outdoor & Monsoon', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Printed Striped PVC • Wave Texture Non-Marking Sole • EU 28 - 35
Target Sectors: Anak Sekolah Musim Hujan, Aktivitas Luar Ruangan Taman, Bermain Genangan Air Bersih
Packaging: 12 Pairs / Master Carton (0.096 m³ • 8.5 kg)
Wholesale FOB Reference: $2.95 / pair (Rp 68,566 Factory List)

Technical Specifications:
• Upper: Printed Striped PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Soft Flexible Rounded Toe (Phthalate Free)
• Midsole: None
• Shaft Height: 20.0 cm | Weight: 520 g
• Sizing Range: EU 28 - 35
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Kids Boots', 'APPROVED',
  18, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_MIXED_BLACK_FUXIA_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_MIXED_BLACK_FUXIA_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_MIXED_BLACK_FUXIA_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_MIXED_BLACK_FUXIA_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_MIXED_BLACK_FUXIA_Sepatu_Boot_PVC/side_AP_Boots_AP_KIDS_2012_MIXED_BLACK_FUXIA_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 FUXIA STRIPE - Sepatu Boot PVC Anak Kaki Motif F/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 FUXIA STRIPE - Sepatu Boot PVC Anak Kaki Motif F/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 FUXIA STRIPE - Sepatu Boot PVC Anak Kaki Motif F/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 FUXIA STRIPE - Sepatu Boot PVC Anak Kaki Motif F/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 FUXIA STRIPE - Sepatu Boot PVC Anak Kaki Motif F/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP KIDS 2012 MIXED BLACK FUXIA - Sepatu Boot PVC - 15/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP KIDS 2012 MIXED BLACK FUXIA - Sepatu Boot PVC - 15/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP KIDS 2012 MIXED BLACK FUXIA - Sepatu Boot PVC - 15/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP KIDS 2012 MIXED BLACK FUXIA - Sepatu Boot PVC - 15/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP KIDS 2012 MIXED BLACK FUXIA - Sepatu Boot PVC - 15/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 68566, 'IDR', 1, 0, 'ap-boots-ap-kids-2012-fuxia-stripe-mst-088',
  'Children Outdoor & Monsoon', '["HERO #88 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2089, 'MST-089', 'AP Boots AP KIDS 2012 UNGU STABILO MULTI', 'APB-068',
  'Children Outdoor & Monsoon', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Multi Tone PVC • Wave Texture Non-Marking Sole • EU 28 - 35
Target Sectors: Anak Sekolah Musim Hujan, Aktivitas Luar Ruangan Taman, Bermain Genangan Air Bersih
Packaging: 12 Pairs / Master Carton (0.096 m³ • 8.5 kg)
Wholesale FOB Reference: $2.95 / pair (Rp 68,566 Factory List)

Technical Specifications:
• Upper: Multi Tone PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Soft Flexible Rounded Toe (Phthalate Free)
• Midsole: None
• Shaft Height: 20.0 cm | Weight: 520 g
• Sizing Range: EU 28 - 35
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Kids Boots', 'APPROVED',
  18, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_UNGU_STABILO_MULTI_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_UNGU_STABILO_MULTI_Sepatu_Boot_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_UNGU_STABILO_MULTI_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_UNGU_STABILO_MULTI_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_UNGU_STABILO_MULTI_Sepatu_Boot_PVC/side_AP_Boots_AP_KIDS_2012_UNGU_STABILO_MULTI_Sepatu_Boot_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 UNGU STABILO MULTI - Sepatu Boot PVC Anak Kaki F/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 UNGU STABILO MULTI - Sepatu Boot PVC Anak Kaki F/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 UNGU STABILO MULTI - Sepatu Boot PVC Anak Kaki F/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 UNGU STABILO MULTI - Sepatu Boot PVC Anak Kaki F/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 UNGU STABILO MULTI - Sepatu Boot PVC Anak Kaki F/05_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 HIJAU STABILO MULTI SIZE BESAR - Sepatu Boot PVC/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 HIJAU STABILO MULTI SIZE BESAR - Sepatu Boot PVC/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 HIJAU STABILO MULTI SIZE BESAR - Sepatu Boot PVC/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 HIJAU STABILO MULTI SIZE BESAR - Sepatu Boot PVC/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 HIJAU STABILO MULTI SIZE BESAR - Sepatu Boot PVC/05_gallery.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 68566, 'IDR', 1, 0, 'ap-boots-ap-kids-2012-ungu-stabilo-multi-mst-089',
  'Children Outdoor & Monsoon', '["HERO #89 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2090, 'MST-090', 'AP BOOTS 2001 HIJAU', 'APB-079',
  'Children Outdoor & Monsoon', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Classic Kids PVC • Wave Texture Non-Marking Sole • EU 26 - 33
Target Sectors: Anak Sekolah Musim Hujan, Aktivitas Luar Ruangan Taman, Bermain Genangan Air Bersih
Packaging: 12 Pairs / Master Carton (0.096 m³ • 8.5 kg)
Wholesale FOB Reference: $3.14 / pair (Rp 72,825 Factory List)

Technical Specifications:
• Upper: Classic Kids PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Soft Flexible Rounded Toe (Phthalate Free)
• Midsole: None
• Shaft Height: 20.0 cm | Weight: 620 g
• Sizing Range: EU 26 - 33
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Kids Boots', 'APPROVED',
  18, 1, 'https://catalog.hotstrading.com/assets/shopee/Sepatu_Boot_Anak_AP_BOOTS_2001_HIJAU_Sepatu_Boot_Karet/hero_Sepatu_Boot_Anak_AP_BOOTS_2001_HIJAU_Sepatu_Boot_Karet.webp', '["https://catalog.hotstrading.com/assets/shopee/Sepatu_Boot_Anak_AP_BOOTS_2001_HIJAU_Sepatu_Boot_Karet/hero_Sepatu_Boot_Anak_AP_BOOTS_2001_HIJAU_Sepatu_Boot_Karet.webp", "https://catalog.hotstrading.com/assets/shopee/Sepatu_Boot_Anak_AP_BOOTS_2001_HIJAU_Sepatu_Boot_Karet/side_Sepatu_Boot_Anak_AP_BOOTS_2001_HIJAU_Sepatu_Boot_Karet.webp", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/Sepatu Boot Anak AP BOOTS 2001 HIJAU - Sepatu Boot Karet Kids Kaki Fas/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/Sepatu Boot Anak AP BOOTS 2001 HIJAU - Sepatu Boot Karet Kids Kaki Fas/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/Sepatu Boot Anak AP BOOTS 2001 HIJAU - Sepatu Boot Karet Kids Kaki Fas/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/Sepatu Boot Anak AP BOOTS 2001 HIJAU - Sepatu Boot Karet Kids Kaki Fas/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/Sepatu Boot Anak AP BOOTS 2001 HIJAU - Sepatu Boot Karet Kids Kaki Fas/05_gallery.jpg", "https://p16-images-common-sign-sg.tokopedia-static.net/tos-maliva-i-o3syd03w52-us/3fc76194fa5749089269555109388e49~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg", "https://p16-images-common-sign-sg.tokopedia-static.net/tos-maliva-i-o3syd03w52-us/ae389c9c030847b8979a0de109e48167~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg", "https://p16-images-common-sign-sg.tokopedia-static.net/tos-maliva-i-o3syd03w52-us/01466f13c49949bb950ee2b2cb4513cf~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//92/MTA-91410750/ap_boots_sepatu_boot_anak_ap_boots_2001_hijau_-_sepatu_boot_karet_full02_l2j1z8si.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//92/MTA-91410750/ap_boots_sepatu_boot_anak_ap_boots_2001_hijau_-_sepatu_boot_karet_full03_jtvcqa7p.jpg"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 72825, 'IDR', 1, 0, 'ap-boots-ap-boots-2001-hijau-mst-090',
  'Children Outdoor & Monsoon', '["HERO #90 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2091, 'MST-091', 'AP Boots AP CLOGS Ladies Pink Cream', 'APB-011',
  'Casual, Leisure & Wet Areas', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Soft Foam Injected PVC • Flat Anti-Slip Suction Sipes • EU 36 - 40
Target Sectors: Area Basah Kolam Renang, Kasir Supermarket, Santai Harian, Pekerja Pasar Tradisional
Packaging: 24 Pairs / Master Carton (0.110 m³ • 10.5 kg)
Wholesale FOB Reference: $2.33 / pair (Rp 54,066 Factory List)

Technical Specifications:
• Upper: Soft Foam Injected PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None
• Midsole: Ergonomic Textured Footbed
• Shaft Height: 6.5 cm | Weight: 360 g
• Sizing Range: EU 36 - 40
• Minimum Order Quantity (MOQ): 24 Pairs
• Container Loadability: ~7,200 pairs (20ft FCL) / ~17,000 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Sandals & Clogs', 'APPROVED',
  19, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Ladies_Pink_Cream_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Ladies_Pink_Cream_Sepatu_Slip_On_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Ladies_Pink_Cream_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Ladies_Pink_Cream_Sepatu_Slip_On_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Ladies_Pink_Cream_Sepatu_Slip_On_PVC/side_AP_Boots_AP_CLOGS_Ladies_Pink_Cream_Sepatu_Slip_On_PVC.webp", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/05fa8e07f4eb4a65afc0f3812c560d7c~tplv-aphluv4xwc-white-pad-v1:1600:1600.jpeg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/2d14b687e8df45879ff970299d47dda6~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/a83cd106a74a47ca949eeaaa3a76375e~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg", "https://img.lazcdn.com/g/p/390f608ec8ef5ced8b67092811078d9c.jpg_720x720q80.jpg_.webp", "https://img.lazcdn.com/g/p/5f716eb5dd8edc4c01d17fb1c3df550c.jpg_720x720q80.jpg_.webp"]', '24 Pairs', 24,
  '50,000 Pairs / Month', 54066, 'IDR', 1, 0, 'ap-boots-ap-clogs-ladies-pink-cream-mst-091',
  'Casual, Leisure & Wet Areas', '["HERO #91 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2092, 'MST-092', 'AP Boots AP CLOGS Hitam', 'APB-046',
  'Casual, Leisure & Wet Areas', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: All-Weather PVC / EVA Blend • Flat Anti-Slip Suction Sipes • EU 39 - 43
Target Sectors: Area Basah Kolam Renang, Kasir Supermarket, Santai Harian, Pekerja Pasar Tradisional
Packaging: 24 Pairs / Master Carton (0.110 m³ • 10.5 kg)
Wholesale FOB Reference: $2.90 / pair (Rp 67,400 Factory List)

Technical Specifications:
• Upper: All-Weather PVC / EVA Blend
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None
• Midsole: Ergonomic Textured Footbed
• Shaft Height: 6.5 cm | Weight: 360 g
• Sizing Range: EU 39 - 43
• Minimum Order Quantity (MOQ): 24 Pairs
• Container Loadability: ~7,200 pairs (20ft FCL) / ~17,000 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Sandals & Clogs', 'APPROVED',
  19, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Hitam_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Hitam_Sepatu_Slip_On_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Hitam_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Hitam_Sepatu_Slip_On_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Hitam_Sepatu_Slip_On_PVC/side_AP_Boots_AP_CLOGS_Hitam_Sepatu_Slip_On_PVC.webp"]', '24 Pairs', 24,
  '50,000 Pairs / Month', 67400, 'IDR', 1, 0, 'ap-boots-ap-clogs-hitam-mst-092',
  'Casual, Leisure & Wet Areas', '["HERO #92 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2093, 'MST-093', 'AP Boots AP CLOGS COKLAT', 'APB-047',
  'Casual, Leisure & Wet Areas', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Durable PVC • Flat Anti-Slip Suction Sipes • EU 39 - 43
Target Sectors: Area Basah Kolam Renang, Kasir Supermarket, Santai Harian, Pekerja Pasar Tradisional
Packaging: 24 Pairs / Master Carton (0.110 m³ • 10.5 kg)
Wholesale FOB Reference: $2.90 / pair (Rp 67,400 Factory List)

Technical Specifications:
• Upper: Durable PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None
• Midsole: Ergonomic Textured Footbed
• Shaft Height: 6.5 cm | Weight: 360 g
• Sizing Range: EU 39 - 43
• Minimum Order Quantity (MOQ): 24 Pairs
• Container Loadability: ~7,200 pairs (20ft FCL) / ~17,000 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Sandals & Clogs', 'APPROVED',
  19, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_COKLAT_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_COKLAT_Sepatu_Slip_On_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_COKLAT_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_COKLAT_Sepatu_Slip_On_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_COKLAT_Sepatu_Slip_On_PVC/side_AP_Boots_AP_CLOGS_COKLAT_Sepatu_Slip_On_PVC.webp"]', '24 Pairs', 24,
  '50,000 Pairs / Month', 67400, 'IDR', 1, 0, 'ap-boots-ap-clogs-coklat-mst-093',
  'Casual, Leisure & Wet Areas', '["HERO #93 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2094, 'MST-094', 'AP Boots AP CLOGS Navy', 'APB-048',
  'Casual, Leisure & Wet Areas', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Ergonomic Casual PVC • Flat Anti-Slip Suction Sipes • EU 39 - 43
Target Sectors: Area Basah Kolam Renang, Kasir Supermarket, Santai Harian, Pekerja Pasar Tradisional
Packaging: 24 Pairs / Master Carton (0.110 m³ • 10.5 kg)
Wholesale FOB Reference: $2.90 / pair (Rp 67,400 Factory List)

Technical Specifications:
• Upper: Ergonomic Casual PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None
• Midsole: Ergonomic Textured Footbed
• Shaft Height: 6.5 cm | Weight: 360 g
• Sizing Range: EU 39 - 43
• Minimum Order Quantity (MOQ): 24 Pairs
• Container Loadability: ~7,200 pairs (20ft FCL) / ~17,000 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Sandals & Clogs', 'APPROVED',
  19, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC/side_AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC.webp"]', '24 Pairs', 24,
  '50,000 Pairs / Month', 67400, 'IDR', 1, 0, 'ap-boots-ap-clogs-navy-mst-094',
  'Casual, Leisure & Wet Areas', '["HERO #94 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2095, 'MST-095', 'AP Boots AP CLOGS Putih Krem', 'APB-056',
  'Casual, Leisure & Wet Areas', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Hygienic Soft PVC • Flat Anti-Slip Suction Sipes • EU 36 - 41
Target Sectors: Area Basah Kolam Renang, Kasir Supermarket, Santai Harian, Pekerja Pasar Tradisional
Packaging: 24 Pairs / Master Carton (0.110 m³ • 10.5 kg)
Wholesale FOB Reference: $2.04 / pair (Rp 47,400 Factory List)

Technical Specifications:
• Upper: Hygienic Soft PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None
• Midsole: Ergonomic Textured Footbed
• Shaft Height: 6.5 cm | Weight: 360 g
• Sizing Range: EU 36 - 41
• Minimum Order Quantity (MOQ): 24 Pairs
• Container Loadability: ~7,200 pairs (20ft FCL) / ~17,000 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Sandals & Clogs', 'APPROVED',
  19, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Putih_Krem_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Putih_Krem_Sepatu_Slip_On_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Putih_Krem_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Putih_Krem_Sepatu_Slip_On_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Putih_Krem_Sepatu_Slip_On_PVC/side_AP_Boots_AP_CLOGS_Putih_Krem_Sepatu_Slip_On_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Krem - Sepatu Slip On PVC - 37/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Krem - Sepatu Slip On PVC - 37/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Krem - Sepatu Slip On PVC - 37/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Krem - Sepatu Slip On PVC - 37/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Krem - Sepatu Slip On PVC - 37/05_gallery.jpg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/VqbcmM/2022/2/17/30af7605-a589-4244-ba74-ad4dd8e2be70.jpg~tplv-aphluv4xwc-white-pad-v1:1600:1600.jpeg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/VqbcmM/2022/2/17/91b55c9b-b3a0-4aa8-8238-3f4e406a6c6c.jpg~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/VqbcmM/2022/2/17/2c107292-66d3-4be1-ae4b-482befe06a64.jpg~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg"]', '24 Pairs', 24,
  '50,000 Pairs / Month', 47400, 'IDR', 1, 0, 'ap-boots-ap-clogs-putih-krem-mst-095',
  'Casual, Leisure & Wet Areas', '["HERO #95 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2096, 'MST-096', 'AP Boots AP CLOGS Putih Abu', 'APB-057',
  'Casual, Leisure & Wet Areas', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Hygienic Soft PVC • Flat Anti-Slip Suction Sipes • EU 36 - 42
Target Sectors: Area Basah Kolam Renang, Kasir Supermarket, Santai Harian, Pekerja Pasar Tradisional
Packaging: 24 Pairs / Master Carton (0.110 m³ • 10.5 kg)
Wholesale FOB Reference: $2.33 / pair (Rp 54,066 Factory List)

Technical Specifications:
• Upper: Hygienic Soft PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None
• Midsole: Ergonomic Textured Footbed
• Shaft Height: 6.5 cm | Weight: 360 g
• Sizing Range: EU 36 - 42
• Minimum Order Quantity (MOQ): 24 Pairs
• Container Loadability: ~7,200 pairs (20ft FCL) / ~17,000 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Sandals & Clogs', 'APPROVED',
  19, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Putih_Abu_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Putih_Abu_Sepatu_Slip_On_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Putih_Abu_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Putih_Abu_Sepatu_Slip_On_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Putih_Abu_Sepatu_Slip_On_PVC/side_AP_Boots_AP_CLOGS_Putih_Abu_Sepatu_Slip_On_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Abu - Sepatu Slip On PVC - 37/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Abu - Sepatu Slip On PVC - 37/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Abu - Sepatu Slip On PVC - 37/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Abu - Sepatu Slip On PVC - 37/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Abu - Sepatu Slip On PVC - 37/05_gallery.jpg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/VqbcmM/2022/2/17/a885bc13-2cf1-466a-bb1d-8815f84b5be5.jpg~tplv-aphluv4xwc-white-pad-v1:1600:1600.jpeg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/VqbcmM/2022/2/17/ce500325-ae8f-4121-989d-024e6dc6391a.jpg~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg", "https://p19-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/VqbcmM/2022/2/17/06f69fc3-0991-408f-a3f8-6413b44a1a19.jpg~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg"]', '24 Pairs', 24,
  '50,000 Pairs / Month', 54066, 'IDR', 1, 0, 'ap-boots-ap-clogs-putih-abu-mst-096',
  'Casual, Leisure & Wet Areas', '["HERO #96 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2097, 'MST-097', 'AP Boots AP CLOGS Putih Merah', 'APB-058',
  'Casual, Leisure & Wet Areas', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Sporty Accented PVC • Flat Anti-Slip Suction Sipes • EU 36 - 42
Target Sectors: Area Basah Kolam Renang, Kasir Supermarket, Santai Harian, Pekerja Pasar Tradisional
Packaging: 24 Pairs / Master Carton (0.110 m³ • 10.5 kg)
Wholesale FOB Reference: $2.04 / pair (Rp 47,400 Factory List)

Technical Specifications:
• Upper: Sporty Accented PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None
• Midsole: Ergonomic Textured Footbed
• Shaft Height: 6.5 cm | Weight: 360 g
• Sizing Range: EU 36 - 42
• Minimum Order Quantity (MOQ): 24 Pairs
• Container Loadability: ~7,200 pairs (20ft FCL) / ~17,000 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Sandals & Clogs', 'APPROVED',
  19, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Putih_Merah_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Putih_Merah_Sepatu_Slip_On_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Putih_Merah_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Putih_Merah_Sepatu_Slip_On_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Putih_Merah_Sepatu_Slip_On_PVC/side_AP_Boots_AP_CLOGS_Putih_Merah_Sepatu_Slip_On_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Merah - Sepatu Slip On PVC - 37/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Merah - Sepatu Slip On PVC - 37/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Merah - Sepatu Slip On PVC - 37/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Merah - Sepatu Slip On PVC - 37/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Merah - Sepatu Slip On PVC - 37/05_gallery.jpg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/VqbcmM/2022/2/17/e7a325c4-52d1-44c0-8319-43e71d466ba1.jpg~tplv-aphluv4xwc-white-pad-v1:1600:1600.jpeg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/VqbcmM/2022/2/17/30eab9bd-98b9-4659-9c1f-54c96184a5d4.jpg~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/VqbcmM/2022/2/17/e739f310-c3a8-41b3-87ce-c762ad09c00f.jpg~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg"]', '24 Pairs', 24,
  '50,000 Pairs / Month', 47400, 'IDR', 1, 0, 'ap-boots-ap-clogs-putih-merah-mst-097',
  'Casual, Leisure & Wet Areas', '["HERO #97 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2098, 'MST-098', 'AP Boots AP CLOGS Putih Navy', 'APB-059',
  'Casual, Leisure & Wet Areas', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Contrast Sole PVC • Flat Anti-Slip Suction Sipes • EU 36 - 42
Target Sectors: Area Basah Kolam Renang, Kasir Supermarket, Santai Harian, Pekerja Pasar Tradisional
Packaging: 24 Pairs / Master Carton (0.110 m³ • 10.5 kg)
Wholesale FOB Reference: $2.04 / pair (Rp 47,400 Factory List)

Technical Specifications:
• Upper: Contrast Sole PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None
• Midsole: Ergonomic Textured Footbed
• Shaft Height: 6.5 cm | Weight: 360 g
• Sizing Range: EU 36 - 42
• Minimum Order Quantity (MOQ): 24 Pairs
• Container Loadability: ~7,200 pairs (20ft FCL) / ~17,000 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Sandals & Clogs', 'APPROVED',
  19, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC/side_AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Navy - Sepatu Slip On PVC - 37/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Navy - Sepatu Slip On PVC - 37/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Navy - Sepatu Slip On PVC - 37/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Navy - Sepatu Slip On PVC - 37/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Navy - Sepatu Slip On PVC - 37/05_gallery.jpg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/VqbcmM/2022/2/17/c30b2264-73df-4628-9c88-7c1d60866146.jpg~tplv-aphluv4xwc-white-pad-v1:1600:1600.jpeg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/VqbcmM/2022/2/17/8395f6f7-71e3-4226-ad08-2a1f04252270.jpg~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg", "https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/img/VqbcmM/2022/2/17/1135dd65-7f4b-46a7-98fa-041a16fe5854.jpg~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg"]', '24 Pairs', 24,
  '50,000 Pairs / Month', 47400, 'IDR', 1, 0, 'ap-boots-ap-clogs-putih-navy-mst-098',
  'Casual, Leisure & Wet Areas', '["HERO #98 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2099, 'MST-099', 'Ap Boots 1001 HITAM', 'APB-084',
  'Casual, Leisure & Wet Areas', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Solid Rubberized Slide • Flat Anti-Slip Suction Sipes • EU 38 - 43
Target Sectors: Area Basah Kolam Renang, Kasir Supermarket, Santai Harian, Pekerja Pasar Tradisional
Packaging: 24 Pairs / Master Carton (0.110 m³ • 10.5 kg)
Wholesale FOB Reference: $1.62 / pair (Rp 37,674 Factory List)

Technical Specifications:
• Upper: Solid Rubberized Slide
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None
• Midsole: Ergonomic Textured Footbed
• Shaft Height: 6.5 cm | Weight: 360 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 24 Pairs
• Container Loadability: ~7,200 pairs (20ft FCL) / ~17,000 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Sandals & Clogs', 'APPROVED',
  19, 1, 'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_1001_HITAM_Sandal_Selop/hero_Ap_Boots_1001_HITAM_Sandal_Selop.webp', '["https://catalog.hotstrading.com/assets/shopee/Ap_Boots_1001_HITAM_Sandal_Selop/hero_Ap_Boots_1001_HITAM_Sandal_Selop.webp", "https://catalog.hotstrading.com/assets/shopee/Ap_Boots_1001_HITAM_Sandal_Selop/side_Ap_Boots_1001_HITAM_Sandal_Selop.webp", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 1001 HITAM - Sandal Selop Karet Sendal Pria Pria - 38/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 1001 HITAM - Sandal Selop Karet Sendal Pria Pria - 38/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 1001 HITAM - Sandal Selop Karet Sendal Pria Pria - 38/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 1001 HITAM - Sandal Selop Karet Sendal Pria Pria - 38/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 1001 HITAM - Sandal Selop Karet Sendal Pria Pria - 38/05_gallery.jpg", "https://p16-images-common-sign-sg.tokopedia-static.net/tos-maliva-i-o3syd03w52-us/2805c25d92814f55a1b6425fcf9223c9~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg", "https://p16-images-common-sign-sg.tokopedia-static.net/tos-maliva-i-o3syd03w52-us/81714827627b4312880420ef14d21864~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg", "https://p16-images-common-sign-sg.tokopedia-static.net/tos-maliva-i-o3syd03w52-us/0ec7a03209a84133aad5bf07676c9e00~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//111/MTA-71877369/br-m036969-18270_sandal-slop-pria-ap-1001-hitam-sandal-slide_full02.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//111/MTA-71877369/br-m036969-18270_sandal-slop-pria-ap-1001-hitam-sandal-slide_full03.jpg"]', '24 Pairs', 24,
  '50,000 Pairs / Month', 37674, 'IDR', 1, 0, 'ap-boots-ap-boots-1001-hitam-mst-099',
  'Casual, Leisure & Wet Areas', '["HERO #99 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2100, 'MST-100', 'Ap Boots 991 Hitam', 'APB-085',
  'Casual, Leisure & Wet Areas', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Lightweight Slide PVC • Flat Anti-Slip Suction Sipes • EU 38 - 43
Target Sectors: Area Basah Kolam Renang, Kasir Supermarket, Santai Harian, Pekerja Pasar Tradisional
Packaging: 24 Pairs / Master Carton (0.110 m³ • 10.5 kg)
Wholesale FOB Reference: $1.59 / pair (Rp 36,933 Factory List)

Technical Specifications:
• Upper: Lightweight Slide PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None
• Midsole: Ergonomic Textured Footbed
• Shaft Height: 6.5 cm | Weight: 360 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 24 Pairs
• Container Loadability: ~7,200 pairs (20ft FCL) / ~17,000 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Sandals & Clogs', 'APPROVED',
  19, 1, 'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_991_Hitam_Sandal_Selop/hero_Ap_Boots_991_Hitam_Sandal_Selop.webp', '["https://catalog.hotstrading.com/assets/shopee/Ap_Boots_991_Hitam_Sandal_Selop/hero_Ap_Boots_991_Hitam_Sandal_Selop.webp", "https://catalog.hotstrading.com/assets/shopee/Ap_Boots_991_Hitam_Sandal_Selop/side_Ap_Boots_991_Hitam_Sandal_Selop.webp", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 991 Hitam - Sandal Selop Karet Sendal Pria/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 991 Hitam - Sandal Selop Karet Sendal Pria/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 991 Hitam - Sandal Selop Karet Sendal Pria/03_gallery.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//108/MTA-71894268/br-m036969-18270_sendal-slop-pria-ap-991-hitam-sandal-slide_full02.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//108/MTA-71894268/br-m036969-18270_sendal-slop-pria-ap-991-hitam-sandal-slide_full03.jpg"]', '24 Pairs', 24,
  '50,000 Pairs / Month', 36933, 'IDR', 1, 0, 'ap-boots-ap-boots-991-hitam-mst-100',
  'Casual, Leisure & Wet Areas', '["HERO #100 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2101, 'MST-101', 'Ap Boots 989 Hitam', 'APB-087',
  'Casual, Leisure & Wet Areas', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Heavy Duty Slide • Flat Anti-Slip Suction Sipes • EU 38 - 43
Target Sectors: Area Basah Kolam Renang, Kasir Supermarket, Santai Harian, Pekerja Pasar Tradisional
Packaging: 24 Pairs / Master Carton (0.110 m³ • 10.5 kg)
Wholesale FOB Reference: $1.59 / pair (Rp 36,933 Factory List)

Technical Specifications:
• Upper: Heavy Duty Slide
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None
• Midsole: Ergonomic Textured Footbed
• Shaft Height: 6.5 cm | Weight: 360 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 24 Pairs
• Container Loadability: ~7,200 pairs (20ft FCL) / ~17,000 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Sandals & Clogs', 'APPROVED',
  19, 1, 'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_989_Hitam_Sandal_Selop/hero_Ap_Boots_989_Hitam_Sandal_Selop.webp', '["https://catalog.hotstrading.com/assets/shopee/Ap_Boots_989_Hitam_Sandal_Selop/hero_Ap_Boots_989_Hitam_Sandal_Selop.webp", "https://catalog.hotstrading.com/assets/shopee/Ap_Boots_989_Hitam_Sandal_Selop/side_Ap_Boots_989_Hitam_Sandal_Selop.webp", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 989 Hitam - Sandal Selop Karet Sendal Pria/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 989 Hitam - Sandal Selop Karet Sendal Pria/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 989 Hitam - Sandal Selop Karet Sendal Pria/03_gallery.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//102/MTA-71894271/br-m036969-18270_sandal-slop-pria-ap-989-hitam-sandal-slide_full02.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//102/MTA-71894271/br-m036969-18270_sandal-slop-pria-ap-989-hitam-sandal-slide_full03.jpg", "https://img.lazcdn.com/g/p/48aeed80be7c062ac84a20d70ecc91d1.jpg_720x720q80.jpg_.webp", "https://img.lazcdn.com/g/p/43545c71f59f75f69b093bcab96dc010.jpg_720x720q80.jpg_.webp"]', '24 Pairs', 24,
  '50,000 Pairs / Month', 36933, 'IDR', 1, 0, 'ap-boots-ap-boots-989-hitam-mst-101',
  'Casual, Leisure & Wet Areas', '["HERO #101 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2102, 'MST-102', 'Ap Boots 995 Hitam (V1)', 'APB-088',
  'Casual, Leisure & Wet Areas', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Ergonomic Outsole • Flat Anti-Slip Suction Sipes • EU 38 - 43
Target Sectors: Area Basah Kolam Renang, Kasir Supermarket, Santai Harian, Pekerja Pasar Tradisional
Packaging: 24 Pairs / Master Carton (0.110 m³ • 10.5 kg)
Wholesale FOB Reference: $1.59 / pair (Rp 36,933 Factory List)

Technical Specifications:
• Upper: Ergonomic Outsole
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None
• Midsole: Ergonomic Textured Footbed
• Shaft Height: 6.5 cm | Weight: 360 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 24 Pairs
• Container Loadability: ~7,200 pairs (20ft FCL) / ~17,000 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Sandals & Clogs', 'APPROVED',
  19, 1, 'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_995_Hitam_Sandal_Selop/hero_Ap_Boots_995_Hitam_Sandal_Selop.webp', '["https://catalog.hotstrading.com/assets/shopee/Ap_Boots_995_Hitam_Sandal_Selop/hero_Ap_Boots_995_Hitam_Sandal_Selop.webp", "https://catalog.hotstrading.com/assets/shopee/Ap_Boots_995_Hitam_Sandal_Selop/side_Ap_Boots_995_Hitam_Sandal_Selop.webp", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 995 Hitam - Sandal Selop Karet/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 995 Hitam - Sandal Selop Karet/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 995 Hitam - Sandal Selop Karet/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 995 Hitam - Sandal Selop Karet Sendal Pria Pria/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 995 Hitam - Sandal Selop Karet Sendal Pria Pria/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 995 Hitam - Sandal Selop Karet Sendal Pria Pria/03_gallery.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//102/MTA-71894262/br-m036969-18270_sandal-slop-pria-ap-995-hitam-sandal-slide_full02.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//102/MTA-71894262/br-m036969-18270_sandal-slop-pria-ap-995-hitam-sandal-slide_full03.jpg", "https://img.lazcdn.com/g/p/19604f37d16e54dd2da21b666fb95909.jpg_720x720q80.jpg_.webp", "https://img.lazcdn.com/g/p/ad37b5dc1397091b8920d57d19c3da2b.jpg_720x720q80.jpg_.webp"]', '24 Pairs', 24,
  '50,000 Pairs / Month', 36933, 'IDR', 1, 0, 'ap-boots-ap-boots-995-hitam-v1-mst-102',
  'Casual, Leisure & Wet Areas', '["HERO #102 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2103, 'MST-103', 'Ap Boots 999 Hitam', 'APB-089',
  'Casual, Leisure & Wet Areas', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: High Traction Sandal • Flat Anti-Slip Suction Sipes • EU 38 - 43
Target Sectors: Area Basah Kolam Renang, Kasir Supermarket, Santai Harian, Pekerja Pasar Tradisional
Packaging: 24 Pairs / Master Carton (0.110 m³ • 10.5 kg)
Wholesale FOB Reference: $1.90 / pair (Rp 44,100 Factory List)

Technical Specifications:
• Upper: High Traction Sandal
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None
• Midsole: Ergonomic Textured Footbed
• Shaft Height: 6.5 cm | Weight: 360 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 24 Pairs
• Container Loadability: ~7,200 pairs (20ft FCL) / ~17,000 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Sandals & Clogs', 'APPROVED',
  19, 1, 'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_999_Hitam_Sandal_Selop/hero_Ap_Boots_999_Hitam_Sandal_Selop.webp', '["https://catalog.hotstrading.com/assets/shopee/Ap_Boots_999_Hitam_Sandal_Selop/hero_Ap_Boots_999_Hitam_Sandal_Selop.webp", "https://catalog.hotstrading.com/assets/shopee/Ap_Boots_999_Hitam_Sandal_Selop/side_Ap_Boots_999_Hitam_Sandal_Selop.webp", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 999 Hitam - Sandal Selop Sendal/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 999 Hitam - Sandal Selop Sendal/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 999 Hitam - Sandal Selop Sendal/03_gallery.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//96/MTA-65030782/shogun_sepatu_boot_tinggi_shogun_999_hitam_-_sepatu_perkebunan_kebersihan_full02_l65uzrzj.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//96/MTA-65030782/shogun_sepatu_boot_tinggi_shogun_999_hitam_-_sepatu_perkebunan_kebersihan_full03_db4z6l2r.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//107/MTA-71894258/br-m036969-18270_sandal-slop-pria-ap-999-hitam-sandal-slide_full02.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//107/MTA-71894258/br-m036969-18270_sandal-slop-pria-ap-999-hitam-sandal-slide_full03.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//103/MTA-65029467/shogun_sepatu_boot_tinggi_shogun_999_hijau_-_sepatu_perkebunan_kebersihan_full02_ej59dea1.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//103/MTA-65029467/shogun_sepatu_boot_tinggi_shogun_999_hijau_-_sepatu_perkebunan_kebersihan_full03_ujlt63vv.jpg"]', '24 Pairs', 24,
  '50,000 Pairs / Month', 44100, 'IDR', 1, 0, 'ap-boots-ap-boots-999-hitam-mst-103',
  'Casual, Leisure & Wet Areas', '["HERO #103 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2104, 'MST-104', 'Ap Boots 995 Hitam (V2)', 'APB-090',
  'Casual, Leisure & Wet Areas', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Comfort Wave Sole • Flat Anti-Slip Suction Sipes • EU 38 - 43
Target Sectors: Area Basah Kolam Renang, Kasir Supermarket, Santai Harian, Pekerja Pasar Tradisional
Packaging: 24 Pairs / Master Carton (0.110 m³ • 10.5 kg)
Wholesale FOB Reference: $1.59 / pair (Rp 36,933 Factory List)

Technical Specifications:
• Upper: Comfort Wave Sole
• Outsole: Molded PVC Cleated Sole
• Toe Protection: None
• Midsole: Ergonomic Textured Footbed
• Shaft Height: 6.5 cm | Weight: 360 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 24 Pairs
• Container Loadability: ~7,200 pairs (20ft FCL) / ~17,000 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Sandals & Clogs', 'APPROVED',
  19, 1, 'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_995_Hitam_Sandal_Selop/hero_Ap_Boots_995_Hitam_Sandal_Selop.webp', '["https://catalog.hotstrading.com/assets/shopee/Ap_Boots_995_Hitam_Sandal_Selop/hero_Ap_Boots_995_Hitam_Sandal_Selop.webp", "https://catalog.hotstrading.com/assets/shopee/Ap_Boots_995_Hitam_Sandal_Selop/side_Ap_Boots_995_Hitam_Sandal_Selop.webp", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 995 Hitam - Sandal Selop Karet/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 995 Hitam - Sandal Selop Karet/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 995 Hitam - Sandal Selop Karet/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 995 Hitam - Sandal Selop Karet Sendal Pria Pria/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 995 Hitam - Sandal Selop Karet Sendal Pria Pria/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 995 Hitam - Sandal Selop Karet Sendal Pria Pria/03_gallery.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//102/MTA-71894262/br-m036969-18270_sandal-slop-pria-ap-995-hitam-sandal-slide_full02.jpg", "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//102/MTA-71894262/br-m036969-18270_sandal-slop-pria-ap-995-hitam-sandal-slide_full03.jpg", "https://img.lazcdn.com/g/p/19604f37d16e54dd2da21b666fb95909.jpg_720x720q80.jpg_.webp", "https://img.lazcdn.com/g/p/ad37b5dc1397091b8920d57d19c3da2b.jpg_720x720q80.jpg_.webp"]', '24 Pairs', 24,
  '50,000 Pairs / Month', 36933, 'IDR', 1, 0, 'ap-boots-ap-boots-995-hitam-v2-mst-104',
  'Casual, Leisure & Wet Areas', '["HERO #104 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2105, 'MST-105', 'AP Boots AP STAR Hitam Putih', 'APB-054',
  'Fashion Waterproof Footwear', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Vulcanized Style Waterproof PVC • Herringbone Siped Rubber Sole • EU 38 - 43
Target Sectors: Pekerja Lapangan Santai, Gaya Kasual Tahan Air, Komuter Hujan Modis
Packaging: 12 Pairs / Master Carton (0.096 m³ • 11.5 kg)
Wholesale FOB Reference: $2.18 / pair (Rp 50,566 Factory List)

Technical Specifications:
• Upper: Vulcanized Style Waterproof PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Vulcanized Style Cap
• Midsole: Cushioned Insole
• Shaft Height: 9.5 cm | Weight: 650 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Kasual Sneakers', 'APPROVED',
  20, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_STAR_Hitam_Putih_Sepatu_Kets_PVC/hero_AP_Boots_AP_STAR_Hitam_Putih_Sepatu_Kets_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_STAR_Hitam_Putih_Sepatu_Kets_PVC/hero_AP_Boots_AP_STAR_Hitam_Putih_Sepatu_Kets_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_STAR_Hitam_Putih_Sepatu_Kets_PVC/side_AP_Boots_AP_STAR_Hitam_Putih_Sepatu_Kets_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/07_AP_Kasual_Sneakers/AP Boots AP STAR Hitam Putih - Sepatu Kets PVC Casual Shoes Sneakers -/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/07_AP_Kasual_Sneakers/AP Boots AP STAR Hitam Putih - Sepatu Kets PVC Casual Shoes Sneakers -/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/07_AP_Kasual_Sneakers/AP Boots AP STAR Hitam Putih - Sepatu Kets PVC Casual Shoes Sneakers -/03_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/07_AP_Kasual_Sneakers/AP Boots AP STAR Hitam Putih - Sepatu Kets PVC Casual Shoes Sneakers -/04_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/07_AP_Kasual_Sneakers/AP Boots AP STAR Hitam Putih - Sepatu Kets PVC Casual Shoes Sneakers -/05_gallery.jpg", "https://p16-images-common-sign-sg.tokopedia-static.net/tos-maliva-i-o3syd03w52-us/f6e5aafef8534828adcded5b093d322b~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg", "https://p16-images-common-sign-sg.tokopedia-static.net/tos-maliva-i-o3syd03w52-us/0fb0d0e33384449da3c3de124a159fb3~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg", "https://p19-images-common-sign-sg.tokopedia-static.net/tos-maliva-i-o3syd03w52-us/7217ff3108494527add7f94158a0a8b8~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg", "https://img.lazcdn.com/g/p/0a42deac1525136e3ea11e0a20883c71.jpg_720x720q80.jpg_.webp", "https://img.lazcdn.com/g/p/e4a35a8ce0725bc04861647d6799aff3.jpg_720x720q80.jpg_.webp"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 50566, 'IDR', 1, 0, 'ap-boots-ap-star-hitam-putih-mst-105',
  'Fashion Waterproof Footwear', '["HERO #105 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2106, 'MST-106', 'AP Boots AP STAR Hitam Hitam', 'APB-055',
  'Fashion Waterproof Footwear', 'Heavy-duty waterproof work footwear withstanding demanding commercial conditions, self-cleaning cleated soles, and seamless direct injection molding.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Triple Black All-Weather PVC • Herringbone Siped Rubber Sole • EU 38 - 43
Target Sectors: Pekerja Lapangan Santai, Gaya Kasual Tahan Air, Komuter Hujan Modis
Packaging: 12 Pairs / Master Carton (0.096 m³ • 11.5 kg)
Wholesale FOB Reference: $3.05 / pair (Rp 70,900 Factory List)

Technical Specifications:
• Upper: Triple Black All-Weather PVC
• Outsole: Molded PVC Cleated Sole
• Toe Protection: Vulcanized Style Cap
• Midsole: Cushioned Insole
• Shaft Height: 9.5 cm | Weight: 650 g
• Sizing Range: EU 38 - 43
• Minimum Order Quantity (MOQ): 12 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'AP Kasual Sneakers', 'APPROVED',
  20, 1, 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_STAR_Hitam_Hitam_Sepatu_Kets_PVC/hero_AP_Boots_AP_STAR_Hitam_Hitam_Sepatu_Kets_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_STAR_Hitam_Hitam_Sepatu_Kets_PVC/hero_AP_Boots_AP_STAR_Hitam_Hitam_Sepatu_Kets_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_STAR_Hitam_Hitam_Sepatu_Kets_PVC/side_AP_Boots_AP_STAR_Hitam_Hitam_Sepatu_Kets_PVC.webp"]', '12 Pairs', 12,
  '50,000 Pairs / Month', 70900, 'IDR', 1, 0, 'ap-boots-ap-star-hitam-hitam-mst-106',
  'Fashion Waterproof Footwear', '["HERO #106 • B2B EXPORT GRADE", "SNI Certified", "Direct Factory Price"]', 0, 0, NOW(), NOW()
),
(
  2107, 'MST-107', 'Petrova Sepatu Boots Nelayan Yellow PVC Steel Toe Cap Anti Static', 'PTR-001',
  'Heavy Industry & Mining Safety', 'Comprehensive industrial safety footwear engineered with Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5) and puncture-resistant construction with anti-static and oil-resistant outsole.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45
Target Sectors: Pertambangan Tambang Terbuka, Galangan Kapal, Kilang Minyak, Pengecoran Logam, Konstruksi Jalan Tol
Packaging: 10 Pairs / Master Carton (0.096 m³ • 23.5 kg)
Wholesale FOB Reference: $10.30 / pair (Rp 239,000 Factory List)

Technical Specifications:
• Upper: Reinforced PVC Compound
• Outsole: Nitrile Rubber Heavy Lug Anti-Puncture Sole
• Toe Protection: Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)
• Midsole: Steel Midsole Plate 1100N (Puncture Proof)
• Shaft Height: 38.0 cm | Weight: 2250 g
• Sizing Range: EU 38 - 45
• Minimum Order Quantity (MOQ): 10 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'Petrova Heavy Duty Safety', 'APPROVED',
  21, 1, 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Nelayan_Yellow_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Nelayan_Yellow_PVC_Steel_Toe_Cap_Anti_Static.webp', '["https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Nelayan_Yellow_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Nelayan_Yellow_PVC_Steel_Toe_Cap_Anti_Static.webp", "https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Nelayan_Yellow_PVC_Steel_Toe_Cap_Anti_Static/side_Petrova_Sepatu_Boots_Nelayan_Yellow_PVC_Steel_Toe_Cap_Anti_Static.webp", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/03_gallery.jpg"]', '10 Pairs', 10,
  '50,000 Pairs / Month', 239000, 'IDR', 1, 1, 'petrova-petrova-sepatu-boots-nelayan-yellow-pvc-steel-toe-cap-anti-static-mst-107',
  'Heavy Industry & Mining Safety', '["HERO #107 • HEAVY INDUSTRY & MINING", "Steel Toe 200J", "EN ISO 20345 S5"]', 0, 0, NOW(), NOW()
),
(
  2108, 'MST-108', 'Petrova Sepatu Boots Phenom Yellow PVC Steel Toe Cap Anti Static', 'PTR-002',
  'Heavy Industry & Mining Safety', 'Comprehensive industrial safety footwear engineered with Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5) and puncture-resistant construction with anti-static and oil-resistant outsole.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45
Target Sectors: Pertambangan Tambang Terbuka, Galangan Kapal, Kilang Minyak, Pengecoran Logam, Konstruksi Jalan Tol
Packaging: 10 Pairs / Master Carton (0.096 m³ • 23.5 kg)
Wholesale FOB Reference: $7.62 / pair (Rp 177,000 Factory List)

Technical Specifications:
• Upper: Reinforced PVC Compound
• Outsole: Nitrile Rubber Heavy Lug Anti-Puncture Sole
• Toe Protection: Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)
• Midsole: Steel Midsole Plate 1100N (Puncture Proof)
• Shaft Height: 38.0 cm | Weight: 2250 g
• Sizing Range: EU 38 - 45
• Minimum Order Quantity (MOQ): 10 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'Petrova Heavy Duty Safety', 'APPROVED',
  21, 1, 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Phenom_Yellow_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Phenom_Yellow_PVC_Steel_Toe_Cap_Anti_Static.webp', '["https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Phenom_Yellow_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Phenom_Yellow_PVC_Steel_Toe_Cap_Anti_Static.webp", "https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Phenom_Yellow_PVC_Steel_Toe_Cap_Anti_Static/side_Petrova_Sepatu_Boots_Phenom_Yellow_PVC_Steel_Toe_Cap_Anti_Static.webp", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/03_gallery.jpg"]', '10 Pairs', 10,
  '50,000 Pairs / Month', 177000, 'IDR', 1, 1, 'petrova-petrova-sepatu-boots-phenom-yellow-pvc-steel-toe-cap-anti-static-mst-108',
  'Heavy Industry & Mining Safety', '["HERO #108 • HEAVY INDUSTRY & MINING", "Steel Toe 200J", "EN ISO 20345 S5"]', 0, 0, NOW(), NOW()
),
(
  2109, 'MST-109', 'Petrova Sepatu Boots Phenom Yellow Size 39 PVC Steel Toe Cap Anti Static', 'PTR-003',
  'Heavy Industry & Mining Safety', 'Comprehensive industrial safety footwear engineered with Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5) and puncture-resistant construction with anti-static and oil-resistant outsole.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45
Target Sectors: Pertambangan Tambang Terbuka, Galangan Kapal, Kilang Minyak, Pengecoran Logam, Konstruksi Jalan Tol
Packaging: 10 Pairs / Master Carton (0.096 m³ • 23.5 kg)
Wholesale FOB Reference: $7.62 / pair (Rp 177,000 Factory List)

Technical Specifications:
• Upper: Reinforced PVC Compound
• Outsole: Nitrile Rubber Heavy Lug Anti-Puncture Sole
• Toe Protection: Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)
• Midsole: Steel Midsole Plate 1100N (Puncture Proof)
• Shaft Height: 38.0 cm | Weight: 2250 g
• Sizing Range: EU 38 - 45
• Minimum Order Quantity (MOQ): 10 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'Petrova Heavy Duty Safety', 'APPROVED',
  21, 1, 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Phenom_Yellow_Size_39_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Phenom_Yellow_Size_39_PVC_Steel_Toe_Cap_Anti_Static.webp', '["https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Phenom_Yellow_Size_39_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Phenom_Yellow_Size_39_PVC_Steel_Toe_Cap_Anti_Static.webp", "https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Phenom_Yellow_Size_39_PVC_Steel_Toe_Cap_Anti_Static/side_Petrova_Sepatu_Boots_Phenom_Yellow_Size_39_PVC_Steel_Toe_Cap_Anti_Static.webp", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP MAX Coklat Hitam - Sepatu Safety PVC - 39/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP MAX Coklat Hitam - Sepatu Safety PVC - 39/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP MAX Coklat Hitam - Sepatu Safety PVC - 39/03_gallery.jpg"]', '10 Pairs', 10,
  '50,000 Pairs / Month', 177000, 'IDR', 1, 1, 'petrova-petrova-sepatu-boots-phenom-yellow-size-39-pvc-steel-toe-cap-anti-static-mst-109',
  'Heavy Industry & Mining Safety', '["HERO #109 • HEAVY INDUSTRY & MINING", "Steel Toe 200J", "EN ISO 20345 S5"]', 0, 0, NOW(), NOW()
),
(
  2110, 'MST-110', 'Petrova Sepatu Boots Strength WB Biru Boots Air PVC', 'PTR-004',
  'Heavy Industry & Mining Safety', 'Comprehensive industrial safety footwear engineered with Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5) and puncture-resistant construction with anti-static and oil-resistant outsole.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45
Target Sectors: Pertambangan Tambang Terbuka, Galangan Kapal, Kilang Minyak, Pengecoran Logam, Konstruksi Jalan Tol
Packaging: 10 Pairs / Master Carton (0.096 m³ • 23.5 kg)
Wholesale FOB Reference: $4.74 / pair (Rp 110,000 Factory List)

Technical Specifications:
• Upper: Reinforced PVC Compound
• Outsole: Nitrile Rubber Heavy Lug Anti-Puncture Sole
• Toe Protection: Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)
• Midsole: Steel Midsole Plate 1100N (Puncture Proof)
• Shaft Height: 38.0 cm | Weight: 2250 g
• Sizing Range: EU 38 - 45
• Minimum Order Quantity (MOQ): 10 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'Petrova Heavy Duty Safety', 'APPROVED',
  21, 1, 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_Biru_Boots_Air_PVC/hero_Petrova_Sepatu_Boots_Strength_WB_Biru_Boots_Air_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_Biru_Boots_Air_PVC/hero_Petrova_Sepatu_Boots_Strength_WB_Biru_Boots_Air_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_Biru_Boots_Air_PVC/side_Petrova_Sepatu_Boots_Strength_WB_Biru_Boots_Air_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/03_gallery.jpg"]', '10 Pairs', 10,
  '50,000 Pairs / Month', 110000, 'IDR', 1, 1, 'petrova-petrova-sepatu-boots-strength-wb-biru-boots-air-pvc-mst-110',
  'Heavy Industry & Mining Safety', '["HERO #110 • HEAVY INDUSTRY & MINING", "Steel Toe 200J", "EN ISO 20345 S5"]', 0, 0, NOW(), NOW()
),
(
  2111, 'MST-111', 'Petrova Sepatu Boots Strength WB Hijau Boots Air PVC', 'PTR-005',
  'Heavy Industry & Mining Safety', 'Comprehensive industrial safety footwear engineered with Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5) and puncture-resistant construction with anti-static and oil-resistant outsole.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45
Target Sectors: Pertambangan Tambang Terbuka, Galangan Kapal, Kilang Minyak, Pengecoran Logam, Konstruksi Jalan Tol
Packaging: 10 Pairs / Master Carton (0.096 m³ • 23.5 kg)
Wholesale FOB Reference: $4.74 / pair (Rp 110,000 Factory List)

Technical Specifications:
• Upper: Reinforced PVC Compound
• Outsole: Nitrile Rubber Heavy Lug Anti-Puncture Sole
• Toe Protection: Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)
• Midsole: Steel Midsole Plate 1100N (Puncture Proof)
• Shaft Height: 38.0 cm | Weight: 2250 g
• Sizing Range: EU 38 - 45
• Minimum Order Quantity (MOQ): 10 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'Petrova Heavy Duty Safety', 'APPROVED',
  21, 1, 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_Hijau_Boots_Air_PVC/hero_Petrova_Sepatu_Boots_Strength_WB_Hijau_Boots_Air_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_Hijau_Boots_Air_PVC/hero_Petrova_Sepatu_Boots_Strength_WB_Hijau_Boots_Air_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_Hijau_Boots_Air_PVC/side_Petrova_Sepatu_Boots_Strength_WB_Hijau_Boots_Air_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/03_gallery.jpg"]', '10 Pairs', 10,
  '50,000 Pairs / Month', 110000, 'IDR', 1, 1, 'petrova-petrova-sepatu-boots-strength-wb-hijau-boots-air-pvc-mst-111',
  'Heavy Industry & Mining Safety', '["HERO #111 • HEAVY INDUSTRY & MINING", "Steel Toe 200J", "EN ISO 20345 S5"]', 0, 0, NOW(), NOW()
),
(
  2112, 'MST-112', 'Petrova Sepatu Boots Strength WB Hitam Boots Air PVC', 'PTR-006',
  'Heavy Industry & Mining Safety', 'Comprehensive industrial safety footwear engineered with Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5) and puncture-resistant construction with anti-static and oil-resistant outsole.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45
Target Sectors: Pertambangan Tambang Terbuka, Galangan Kapal, Kilang Minyak, Pengecoran Logam, Konstruksi Jalan Tol
Packaging: 10 Pairs / Master Carton (0.096 m³ • 23.5 kg)
Wholesale FOB Reference: $3.34 / pair (Rp 77,500 Factory List)

Technical Specifications:
• Upper: Reinforced PVC Compound
• Outsole: Nitrile Rubber Heavy Lug Anti-Puncture Sole
• Toe Protection: Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)
• Midsole: Steel Midsole Plate 1100N (Puncture Proof)
• Shaft Height: 38.0 cm | Weight: 2250 g
• Sizing Range: EU 38 - 45
• Minimum Order Quantity (MOQ): 10 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'Petrova Heavy Duty Safety', 'APPROVED',
  21, 1, 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_Hitam_Boots_Air_PVC/hero_Petrova_Sepatu_Boots_Strength_WB_Hitam_Boots_Air_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_Hitam_Boots_Air_PVC/hero_Petrova_Sepatu_Boots_Strength_WB_Hitam_Boots_Air_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_Hitam_Boots_Air_PVC/side_Petrova_Sepatu_Boots_Strength_WB_Hitam_Boots_Air_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/03_gallery.jpg"]', '10 Pairs', 10,
  '50,000 Pairs / Month', 77500, 'IDR', 1, 1, 'petrova-petrova-sepatu-boots-strength-wb-hitam-boots-air-pvc-mst-112',
  'Heavy Industry & Mining Safety', '["HERO #112 • HEAVY INDUSTRY & MINING", "Steel Toe 200J", "EN ISO 20345 S5"]', 0, 0, NOW(), NOW()
),
(
  2113, 'MST-113', 'Petrova Sepatu Boots Strength WB Kuning Boots Air PVC', 'PTR-007',
  'Heavy Industry & Mining Safety', 'Comprehensive industrial safety footwear engineered with Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5) and puncture-resistant construction with anti-static and oil-resistant outsole.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45
Target Sectors: Pertambangan Tambang Terbuka, Galangan Kapal, Kilang Minyak, Pengecoran Logam, Konstruksi Jalan Tol
Packaging: 10 Pairs / Master Carton (0.096 m³ • 23.5 kg)
Wholesale FOB Reference: $4.09 / pair (Rp 95,000 Factory List)

Technical Specifications:
• Upper: Reinforced PVC Compound
• Outsole: Nitrile Rubber Heavy Lug Anti-Puncture Sole
• Toe Protection: Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)
• Midsole: Steel Midsole Plate 1100N (Puncture Proof)
• Shaft Height: 38.0 cm | Weight: 2250 g
• Sizing Range: EU 38 - 45
• Minimum Order Quantity (MOQ): 10 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'Petrova Heavy Duty Safety', 'APPROVED',
  21, 1, 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_Kuning_Boots_Air_PVC/hero_Petrova_Sepatu_Boots_Strength_WB_Kuning_Boots_Air_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_Kuning_Boots_Air_PVC/hero_Petrova_Sepatu_Boots_Strength_WB_Kuning_Boots_Air_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_Kuning_Boots_Air_PVC/side_Petrova_Sepatu_Boots_Strength_WB_Kuning_Boots_Air_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/03_gallery.jpg"]', '10 Pairs', 10,
  '50,000 Pairs / Month', 95000, 'IDR', 1, 1, 'petrova-petrova-sepatu-boots-strength-wb-kuning-boots-air-pvc-mst-113',
  'Heavy Industry & Mining Safety', '["HERO #113 • HEAVY INDUSTRY & MINING", "Steel Toe 200J", "EN ISO 20345 S5"]', 0, 0, NOW(), NOW()
),
(
  2114, 'MST-114', 'Petrova Sepatu Boots Strength WB orange Boots Air PVC', 'PTR-008',
  'Heavy Industry & Mining Safety', 'Comprehensive industrial safety footwear engineered with Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5) and puncture-resistant construction with anti-static and oil-resistant outsole.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45
Target Sectors: Pertambangan Tambang Terbuka, Galangan Kapal, Kilang Minyak, Pengecoran Logam, Konstruksi Jalan Tol
Packaging: 10 Pairs / Master Carton (0.096 m³ • 23.5 kg)
Wholesale FOB Reference: $4.74 / pair (Rp 110,000 Factory List)

Technical Specifications:
• Upper: Reinforced PVC Compound
• Outsole: Nitrile Rubber Heavy Lug Anti-Puncture Sole
• Toe Protection: Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)
• Midsole: Steel Midsole Plate 1100N (Puncture Proof)
• Shaft Height: 38.0 cm | Weight: 2250 g
• Sizing Range: EU 38 - 45
• Minimum Order Quantity (MOQ): 10 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'Petrova Heavy Duty Safety', 'APPROVED',
  21, 1, 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_orange_Boots_Air_PVC/hero_Petrova_Sepatu_Boots_Strength_WB_orange_Boots_Air_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_orange_Boots_Air_PVC/hero_Petrova_Sepatu_Boots_Strength_WB_orange_Boots_Air_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_orange_Boots_Air_PVC/side_Petrova_Sepatu_Boots_Strength_WB_orange_Boots_Air_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/03_gallery.jpg"]', '10 Pairs', 10,
  '50,000 Pairs / Month', 110000, 'IDR', 1, 1, 'petrova-petrova-sepatu-boots-strength-wb-orange-boots-air-pvc-mst-114',
  'Heavy Industry & Mining Safety', '["HERO #114 • HEAVY INDUSTRY & MINING", "Steel Toe 200J", "EN ISO 20345 S5"]', 0, 0, NOW(), NOW()
),
(
  2115, 'MST-115', 'Petrova Sepatu Boots Tinggi Safety ERGOS kuning Steel Toe PVC', 'PTR-009',
  'Heavy Industry & Mining Safety', 'Comprehensive industrial safety footwear engineered with Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5) and puncture-resistant construction with anti-static and oil-resistant outsole.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45
Target Sectors: Pertambangan Tambang Terbuka, Galangan Kapal, Kilang Minyak, Pengecoran Logam, Konstruksi Jalan Tol
Packaging: 10 Pairs / Master Carton (0.096 m³ • 23.5 kg)
Wholesale FOB Reference: $7.19 / pair (Rp 167,000 Factory List)

Technical Specifications:
• Upper: Reinforced PVC Compound
• Outsole: Nitrile Rubber Heavy Lug Anti-Puncture Sole
• Toe Protection: Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)
• Midsole: Steel Midsole Plate 1100N (Puncture Proof)
• Shaft Height: 38.0 cm | Weight: 2250 g
• Sizing Range: EU 38 - 45
• Minimum Order Quantity (MOQ): 10 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'Petrova Heavy Duty Safety', 'APPROVED',
  21, 1, 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Tinggi_Safety_ERGOS_kuning_Steel_Toe_PVC/hero_Petrova_Sepatu_Boots_Tinggi_Safety_ERGOS_kuning_Steel_Toe_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Tinggi_Safety_ERGOS_kuning_Steel_Toe_PVC/hero_Petrova_Sepatu_Boots_Tinggi_Safety_ERGOS_kuning_Steel_Toe_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Tinggi_Safety_ERGOS_kuning_Steel_Toe_PVC/side_Petrova_Sepatu_Boots_Tinggi_Safety_ERGOS_kuning_Steel_Toe_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/03_gallery.jpg"]', '10 Pairs', 10,
  '50,000 Pairs / Month', 167000, 'IDR', 1, 1, 'petrova-petrova-sepatu-boots-tinggi-safety-ergos-kuning-steel-toe-pvc-mst-115',
  'Heavy Industry & Mining Safety', '["HERO #115 • HEAVY INDUSTRY & MINING", "Steel Toe 200J", "EN ISO 20345 S5"]', 0, 0, NOW(), NOW()
),
(
  2116, 'MST-116', 'Petrova Sepatu Boots Ultimate Yellow PVC Steel Toe Cap Anti Static', 'PTR-010',
  'Heavy Industry & Mining Safety', 'Comprehensive industrial safety footwear engineered with Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5) and puncture-resistant construction with anti-static and oil-resistant outsole.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45
Target Sectors: Pertambangan Tambang Terbuka, Galangan Kapal, Kilang Minyak, Pengecoran Logam, Konstruksi Jalan Tol
Packaging: 10 Pairs / Master Carton (0.096 m³ • 23.5 kg)
Wholesale FOB Reference: $9.33 / pair (Rp 216,500 Factory List)

Technical Specifications:
• Upper: Reinforced PVC Compound
• Outsole: Nitrile Rubber Heavy Lug Anti-Puncture Sole
• Toe Protection: Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)
• Midsole: Steel Midsole Plate 1100N (Puncture Proof)
• Shaft Height: 38.0 cm | Weight: 2250 g
• Sizing Range: EU 38 - 45
• Minimum Order Quantity (MOQ): 10 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'Petrova Heavy Duty Safety', 'APPROVED',
  21, 1, 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_PVC_Steel_Toe_Cap_Anti_Static.webp', '["https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_PVC_Steel_Toe_Cap_Anti_Static.webp", "https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_PVC_Steel_Toe_Cap_Anti_Static/side_Petrova_Sepatu_Boots_Ultimate_Yellow_PVC_Steel_Toe_Cap_Anti_Static.webp", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/03_gallery.jpg"]', '10 Pairs', 10,
  '50,000 Pairs / Month', 216500, 'IDR', 1, 1, 'petrova-petrova-sepatu-boots-ultimate-yellow-pvc-steel-toe-cap-anti-static-mst-116',
  'Heavy Industry & Mining Safety', '["HERO #116 • HEAVY INDUSTRY & MINING", "Steel Toe 200J", "EN ISO 20345 S5"]', 0, 0, NOW(), NOW()
),
(
  2117, 'MST-117', 'Petrova Sepatu Boots Ultimate Yellow Size 38 PVC Steel Toe Cap Anti Static', 'PTR-011',
  'Heavy Industry & Mining Safety', 'Comprehensive industrial safety footwear engineered with Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5) and puncture-resistant construction with anti-static and oil-resistant outsole.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45
Target Sectors: Pertambangan Tambang Terbuka, Galangan Kapal, Kilang Minyak, Pengecoran Logam, Konstruksi Jalan Tol
Packaging: 10 Pairs / Master Carton (0.096 m³ • 23.5 kg)
Wholesale FOB Reference: $9.33 / pair (Rp 216,500 Factory List)

Technical Specifications:
• Upper: Reinforced PVC Compound
• Outsole: Nitrile Rubber Heavy Lug Anti-Puncture Sole
• Toe Protection: Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)
• Midsole: Steel Midsole Plate 1100N (Puncture Proof)
• Shaft Height: 38.0 cm | Weight: 2250 g
• Sizing Range: EU 38 - 45
• Minimum Order Quantity (MOQ): 10 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'Petrova Heavy Duty Safety', 'APPROVED',
  21, 1, 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_38_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_38_PVC_Steel_Toe_Cap_Anti_Static.webp', '["https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_38_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_38_PVC_Steel_Toe_Cap_Anti_Static.webp", "https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_38_PVC_Steel_Toe_Cap_Anti_Static/side_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_38_PVC_Steel_Toe_Cap_Anti_Static.webp", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/03_gallery.jpg"]', '10 Pairs', 10,
  '50,000 Pairs / Month', 216500, 'IDR', 1, 1, 'petrova-petrova-sepatu-boots-ultimate-yellow-size-38-pvc-steel-toe-cap-anti-static-mst-117',
  'Heavy Industry & Mining Safety', '["HERO #117 • HEAVY INDUSTRY & MINING", "Steel Toe 200J", "EN ISO 20345 S5"]', 0, 0, NOW(), NOW()
),
(
  2118, 'MST-118', 'Petrova Sepatu Boots Ultimate Yellow Size 39 PVC Steel Toe Cap Anti Static', 'PTR-012',
  'Heavy Industry & Mining Safety', 'Comprehensive industrial safety footwear engineered with Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5) and puncture-resistant construction with anti-static and oil-resistant outsole.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45
Target Sectors: Pertambangan Tambang Terbuka, Galangan Kapal, Kilang Minyak, Pengecoran Logam, Konstruksi Jalan Tol
Packaging: 10 Pairs / Master Carton (0.096 m³ • 23.5 kg)
Wholesale FOB Reference: $9.33 / pair (Rp 216,500 Factory List)

Technical Specifications:
• Upper: Reinforced PVC Compound
• Outsole: Nitrile Rubber Heavy Lug Anti-Puncture Sole
• Toe Protection: Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)
• Midsole: Steel Midsole Plate 1100N (Puncture Proof)
• Shaft Height: 38.0 cm | Weight: 2250 g
• Sizing Range: EU 38 - 45
• Minimum Order Quantity (MOQ): 10 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'Petrova Heavy Duty Safety', 'APPROVED',
  21, 1, 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_39_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_39_PVC_Steel_Toe_Cap_Anti_Static.webp', '["https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_39_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_39_PVC_Steel_Toe_Cap_Anti_Static.webp", "https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_39_PVC_Steel_Toe_Cap_Anti_Static/side_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_39_PVC_Steel_Toe_Cap_Anti_Static.webp", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP MAX Coklat Hitam - Sepatu Safety PVC - 39/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP MAX Coklat Hitam - Sepatu Safety PVC - 39/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP MAX Coklat Hitam - Sepatu Safety PVC - 39/03_gallery.jpg"]', '10 Pairs', 10,
  '50,000 Pairs / Month', 216500, 'IDR', 1, 1, 'petrova-petrova-sepatu-boots-ultimate-yellow-size-39-pvc-steel-toe-cap-anti-static-mst-118',
  'Heavy Industry & Mining Safety', '["HERO #118 • HEAVY INDUSTRY & MINING", "Steel Toe 200J", "EN ISO 20345 S5"]', 0, 0, NOW(), NOW()
),
(
  2119, 'MST-119', 'Petrova Sepatu Boots Ultimate Yellow Size 40 PVC Steel Toe Cap Anti Static', 'PTR-013',
  'Heavy Industry & Mining Safety', 'Comprehensive industrial safety footwear engineered with Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5) and puncture-resistant construction with anti-static and oil-resistant outsole.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45
Target Sectors: Pertambangan Tambang Terbuka, Galangan Kapal, Kilang Minyak, Pengecoran Logam, Konstruksi Jalan Tol
Packaging: 10 Pairs / Master Carton (0.096 m³ • 23.5 kg)
Wholesale FOB Reference: $9.33 / pair (Rp 216,500 Factory List)

Technical Specifications:
• Upper: Reinforced PVC Compound
• Outsole: Nitrile Rubber Heavy Lug Anti-Puncture Sole
• Toe Protection: Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)
• Midsole: Steel Midsole Plate 1100N (Puncture Proof)
• Shaft Height: 38.0 cm | Weight: 2250 g
• Sizing Range: EU 38 - 45
• Minimum Order Quantity (MOQ): 10 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'Petrova Heavy Duty Safety', 'APPROVED',
  21, 1, 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_40_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_40_PVC_Steel_Toe_Cap_Anti_Static.webp', '["https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_40_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_40_PVC_Steel_Toe_Cap_Anti_Static.webp", "https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_40_PVC_Steel_Toe_Cap_Anti_Static/side_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_40_PVC_Steel_Toe_Cap_Anti_Static.webp", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/03_gallery.jpg"]', '10 Pairs', 10,
  '50,000 Pairs / Month', 216500, 'IDR', 1, 1, 'petrova-petrova-sepatu-boots-ultimate-yellow-size-40-pvc-steel-toe-cap-anti-static-mst-119',
  'Heavy Industry & Mining Safety', '["HERO #119 • HEAVY INDUSTRY & MINING", "Steel Toe 200J", "EN ISO 20345 S5"]', 0, 0, NOW(), NOW()
),
(
  2120, 'MST-120', 'Petrova Sepatu Boots Ultimate Yellow Size 41 PVC Steel Toe Cap Anti Static', 'PTR-014',
  'Heavy Industry & Mining Safety', 'Comprehensive industrial safety footwear engineered with Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5) and puncture-resistant construction with anti-static and oil-resistant outsole.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45
Target Sectors: Pertambangan Tambang Terbuka, Galangan Kapal, Kilang Minyak, Pengecoran Logam, Konstruksi Jalan Tol
Packaging: 10 Pairs / Master Carton (0.096 m³ • 23.5 kg)
Wholesale FOB Reference: $9.33 / pair (Rp 216,500 Factory List)

Technical Specifications:
• Upper: Reinforced PVC Compound
• Outsole: Nitrile Rubber Heavy Lug Anti-Puncture Sole
• Toe Protection: Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)
• Midsole: Steel Midsole Plate 1100N (Puncture Proof)
• Shaft Height: 38.0 cm | Weight: 2250 g
• Sizing Range: EU 38 - 45
• Minimum Order Quantity (MOQ): 10 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'Petrova Heavy Duty Safety', 'APPROVED',
  21, 1, 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_41_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_41_PVC_Steel_Toe_Cap_Anti_Static.webp', '["https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_41_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_41_PVC_Steel_Toe_Cap_Anti_Static.webp", "https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_41_PVC_Steel_Toe_Cap_Anti_Static/side_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_41_PVC_Steel_Toe_Cap_Anti_Static.webp", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/03_gallery.jpg"]', '10 Pairs', 10,
  '50,000 Pairs / Month', 216500, 'IDR', 1, 1, 'petrova-petrova-sepatu-boots-ultimate-yellow-size-41-pvc-steel-toe-cap-anti-static-mst-120',
  'Heavy Industry & Mining Safety', '["HERO #120 • HEAVY INDUSTRY & MINING", "Steel Toe 200J", "EN ISO 20345 S5"]', 0, 0, NOW(), NOW()
),
(
  2121, 'MST-121', 'Petrova Sepatu Boots Ultimate Yellow Size 43 PVC Steel Toe Cap Anti Static', 'PTR-015',
  'Heavy Industry & Mining Safety', 'Comprehensive industrial safety footwear engineered with Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5) and puncture-resistant construction with anti-static and oil-resistant outsole.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45
Target Sectors: Pertambangan Tambang Terbuka, Galangan Kapal, Kilang Minyak, Pengecoran Logam, Konstruksi Jalan Tol
Packaging: 10 Pairs / Master Carton (0.096 m³ • 23.5 kg)
Wholesale FOB Reference: $9.33 / pair (Rp 216,500 Factory List)

Technical Specifications:
• Upper: Reinforced PVC Compound
• Outsole: Nitrile Rubber Heavy Lug Anti-Puncture Sole
• Toe Protection: Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)
• Midsole: Steel Midsole Plate 1100N (Puncture Proof)
• Shaft Height: 38.0 cm | Weight: 2250 g
• Sizing Range: EU 38 - 45
• Minimum Order Quantity (MOQ): 10 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'Petrova Heavy Duty Safety', 'APPROVED',
  21, 1, 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_43_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_43_PVC_Steel_Toe_Cap_Anti_Static.webp', '["https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_43_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_43_PVC_Steel_Toe_Cap_Anti_Static.webp", "https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_43_PVC_Steel_Toe_Cap_Anti_Static/side_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_43_PVC_Steel_Toe_Cap_Anti_Static.webp", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/03_gallery.jpg"]', '10 Pairs', 10,
  '50,000 Pairs / Month', 216500, 'IDR', 1, 1, 'petrova-petrova-sepatu-boots-ultimate-yellow-size-43-pvc-steel-toe-cap-anti-static-mst-121',
  'Heavy Industry & Mining Safety', '["HERO #121 • HEAVY INDUSTRY & MINING", "Steel Toe 200J", "EN ISO 20345 S5"]', 0, 0, NOW(), NOW()
),
(
  2122, 'MST-122', 'Petrova Sepatu Boots Ultimate Yellow Size 44 PVC Steel Toe Cap Anti Static', 'PTR-016',
  'Heavy Industry & Mining Safety', 'Comprehensive industrial safety footwear engineered with Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5) and puncture-resistant construction with anti-static and oil-resistant outsole.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45
Target Sectors: Pertambangan Tambang Terbuka, Galangan Kapal, Kilang Minyak, Pengecoran Logam, Konstruksi Jalan Tol
Packaging: 10 Pairs / Master Carton (0.096 m³ • 23.5 kg)
Wholesale FOB Reference: $9.33 / pair (Rp 216,500 Factory List)

Technical Specifications:
• Upper: Reinforced PVC Compound
• Outsole: Nitrile Rubber Heavy Lug Anti-Puncture Sole
• Toe Protection: Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)
• Midsole: Steel Midsole Plate 1100N (Puncture Proof)
• Shaft Height: 38.0 cm | Weight: 2250 g
• Sizing Range: EU 38 - 45
• Minimum Order Quantity (MOQ): 10 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'Petrova Heavy Duty Safety', 'APPROVED',
  21, 1, 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_44_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_44_PVC_Steel_Toe_Cap_Anti_Static.webp', '["https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_44_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_44_PVC_Steel_Toe_Cap_Anti_Static.webp", "https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_44_PVC_Steel_Toe_Cap_Anti_Static/side_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_44_PVC_Steel_Toe_Cap_Anti_Static.webp", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/03_gallery.jpg"]', '10 Pairs', 10,
  '50,000 Pairs / Month', 216500, 'IDR', 1, 1, 'petrova-petrova-sepatu-boots-ultimate-yellow-size-44-pvc-steel-toe-cap-anti-static-mst-122',
  'Heavy Industry & Mining Safety', '["HERO #122 • HEAVY INDUSTRY & MINING", "Steel Toe 200J", "EN ISO 20345 S5"]', 0, 0, NOW(), NOW()
),
(
  2123, 'MST-123', 'Petrova Sepatu Boots Tinggi PETROVA Classic Hitam Boots PVC Lentur Lokal', 'PTR-017',
  'Heavy Industry & Mining Safety', 'Comprehensive industrial safety footwear engineered with Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5) and puncture-resistant construction with anti-static and oil-resistant outsole.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45
Target Sectors: Pertambangan Tambang Terbuka, Galangan Kapal, Kilang Minyak, Pengecoran Logam, Konstruksi Jalan Tol
Packaging: 10 Pairs / Master Carton (0.096 m³ • 23.5 kg)
Wholesale FOB Reference: $6.03 / pair (Rp 140,000 Factory List)

Technical Specifications:
• Upper: Reinforced PVC Compound
• Outsole: Nitrile Rubber Heavy Lug Anti-Puncture Sole
• Toe Protection: Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)
• Midsole: Steel Midsole Plate 1100N (Puncture Proof)
• Shaft Height: 38.0 cm | Weight: 2250 g
• Sizing Range: EU 38 - 45
• Minimum Order Quantity (MOQ): 10 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'Petrova Heavy Duty Safety', 'APPROVED',
  21, 1, 'https://catalog.hotstrading.com/assets/shopee/Sepatu_Boots_Tinggi_PETROVA_Classic_Hitam_Boots_PVC_Lentur_Lokal/hero_Sepatu_Boots_Tinggi_PETROVA_Classic_Hitam_Boots_PVC_Lentur_Lokal.webp', '["https://catalog.hotstrading.com/assets/shopee/Sepatu_Boots_Tinggi_PETROVA_Classic_Hitam_Boots_PVC_Lentur_Lokal/hero_Sepatu_Boots_Tinggi_PETROVA_Classic_Hitam_Boots_PVC_Lentur_Lokal.webp", "https://catalog.hotstrading.com/assets/shopee/Sepatu_Boots_Tinggi_PETROVA_Classic_Hitam_Boots_PVC_Lentur_Lokal/side_Sepatu_Boots_Tinggi_PETROVA_Classic_Hitam_Boots_PVC_Lentur_Lokal.webp", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/03_gallery.jpg"]', '10 Pairs', 10,
  '50,000 Pairs / Month', 140000, 'IDR', 1, 1, 'petrova-petrova-sepatu-boots-tinggi-petrova-classic-hitam-boots-pvc-lentur-lokal-mst-123',
  'Heavy Industry & Mining Safety', '["HERO #123 • HEAVY INDUSTRY & MINING", "Steel Toe 200J", "EN ISO 20345 S5"]', 0, 0, NOW(), NOW()
),
(
  2124, 'MST-124', 'Petrova Sepatu Boots Tinggi PETROVA Pro Green Boots Karet Lentur Lokal Anti Slip & Air Ringan perkebunan', 'PTR-018',
  'Heavy Industry & Mining Safety', 'Comprehensive industrial safety footwear engineered with Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5) and puncture-resistant construction with anti-static and oil-resistant outsole.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45
Target Sectors: Pertambangan Tambang Terbuka, Galangan Kapal, Kilang Minyak, Pengecoran Logam, Konstruksi Jalan Tol
Packaging: 10 Pairs / Master Carton (0.096 m³ • 23.5 kg)
Wholesale FOB Reference: $3.88 / pair (Rp 90,000 Factory List)

Technical Specifications:
• Upper: Reinforced PVC Compound
• Outsole: Nitrile Rubber Heavy Lug Anti-Puncture Sole
• Toe Protection: Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)
• Midsole: Steel Midsole Plate 1100N (Puncture Proof)
• Shaft Height: 38.0 cm | Weight: 2250 g
• Sizing Range: EU 38 - 45
• Minimum Order Quantity (MOQ): 10 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'Petrova Heavy Duty Safety', 'APPROVED',
  21, 1, 'https://catalog.hotstrading.com/assets/shopee/Sepatu_Boots_Tinggi_PETROVA_Pro_Green_Boots_Karet_Lentur_Lokal_Anti_Slip_&_Air_Ringan_perkebunan/hero_Sepatu_Boots_Tinggi_PETROVA_Pro_Green_Boots_Karet_Lentur_Lokal_Anti_Slip_&_Air_Ringan_perkebunan.webp', '["https://catalog.hotstrading.com/assets/shopee/Sepatu_Boots_Tinggi_PETROVA_Pro_Green_Boots_Karet_Lentur_Lokal_Anti_Slip_&_Air_Ringan_perkebunan/hero_Sepatu_Boots_Tinggi_PETROVA_Pro_Green_Boots_Karet_Lentur_Lokal_Anti_Slip_&_Air_Ringan_perkebunan.webp", "https://catalog.hotstrading.com/assets/shopee/Sepatu_Boots_Tinggi_PETROVA_Pro_Green_Boots_Karet_Lentur_Lokal_Anti_Slip_&_Air_Ringan_perkebunan/side_Sepatu_Boots_Tinggi_PETROVA_Pro_Green_Boots_Karet_Lentur_Lokal_Anti_Slip_&_Air_Ringan_perkebunan.webp", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/03_gallery.jpg"]', '10 Pairs', 10,
  '50,000 Pairs / Month', 90000, 'IDR', 1, 1, 'petrova-petrova-sepatu-boots-tinggi-petrova-pro-green-boots-karet-lentur-lokal-anti-slip-air-ringan-perkebunan-mst-124',
  'Heavy Industry & Mining Safety', '["HERO #124 • HEAVY INDUSTRY & MINING", "Steel Toe 200J", "EN ISO 20345 S5"]', 0, 0, NOW(), NOW()
),
(
  2125, 'MST-125', 'Petrova Sepatu Boots Tinggi Safety  STRENGTH kuning Steel Toe PVC', 'PTR-019',
  'Heavy Industry & Mining Safety', 'Comprehensive industrial safety footwear engineered with Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5) and puncture-resistant construction with anti-static and oil-resistant outsole.

Compliance: SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988
Key Spec: Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45
Target Sectors: Pertambangan Tambang Terbuka, Galangan Kapal, Kilang Minyak, Pengecoran Logam, Konstruksi Jalan Tol
Packaging: 10 Pairs / Master Carton (0.096 m³ • 23.5 kg)
Wholesale FOB Reference: $6.94 / pair (Rp 161,000 Factory List)

Technical Specifications:
• Upper: Reinforced PVC Compound
• Outsole: Nitrile Rubber Heavy Lug Anti-Puncture Sole
• Toe Protection: Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)
• Midsole: Steel Midsole Plate 1100N (Puncture Proof)
• Shaft Height: 38.0 cm | Weight: 2250 g
• Sizing Range: EU 38 - 45
• Minimum Order Quantity (MOQ): 10 Pairs
• Container Loadability: ~3,600 pairs (20ft FCL) / ~8,500 pairs (40ft HQ FCL)
• Loading Seaport: Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 'Petrova Heavy Duty Safety', 'APPROVED',
  21, 1, 'https://catalog.hotstrading.com/assets/shopee/Sepatu_Boots_Tinggi_Safety_Petrova_STRENGTH_kuning_Steel_Toe_PVC/hero_Sepatu_Boots_Tinggi_Safety_Petrova_STRENGTH_kuning_Steel_Toe_PVC.webp', '["https://catalog.hotstrading.com/assets/shopee/Sepatu_Boots_Tinggi_Safety_Petrova_STRENGTH_kuning_Steel_Toe_PVC/hero_Sepatu_Boots_Tinggi_Safety_Petrova_STRENGTH_kuning_Steel_Toe_PVC.webp", "https://catalog.hotstrading.com/assets/shopee/Sepatu_Boots_Tinggi_Safety_Petrova_STRENGTH_kuning_Steel_Toe_PVC/side_Sepatu_Boots_Tinggi_Safety_Petrova_STRENGTH_kuning_Steel_Toe_PVC.webp", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg", "https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/03_gallery.jpg"]', '10 Pairs', 10,
  '50,000 Pairs / Month', 161000, 'IDR', 1, 1, 'petrova-petrova-sepatu-boots-tinggi-safety-strength-kuning-steel-toe-pvc-mst-125',
  'Heavy Industry & Mining Safety', '["HERO #125 • HEAVY INDUSTRY & MINING", "Steel Toe 200J", "EN ISO 20345 S5"]', 0, 0, NOW(), NOW()
);

-- -------------------------------------------------------------
-- 5. PRODUCT SPECIFICATIONS (1875 rows)
-- -------------------------------------------------------------
INSERT INTO `product_specifications` (`id`, `product_id`, `spec_label`, `spec_value`, `display_order`) VALUES
(10001, 2001, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10002, 2001, 'Key Spec', 'Heavy-Duty PVC / Nitrile Rubber • SRC Certified (SRA + SRB Heavy Lug Outsole) • EU 39 - 44', 2),
(10003, 2001, 'Upper Material', 'Heavy-Duty PVC / Nitrile Rubber', 3),
(10004, 2001, 'Outsole', 'Nitrile Blend Anti-Slip Rubber', 4),
(10005, 2001, 'Toe Protection', 'Steel Toe Cap 200 Joule (EN ISO 20345 / ASTM F2413)', 5),
(10006, 2001, 'Underfoot Midsole', 'Steel Midsole Anti-Paku 1100N (Optional on S5)', 6),
(10007, 2001, 'Slip Resistance', 'SRC Certified (SRA + SRB Heavy Lug Outsole)', 7),
(10008, 2001, 'Shaft Height', '38.0 cm', 8),
(10009, 2001, 'Unit Weight', '2150 g / pair', 9),
(10010, 2001, 'Available Sizing', 'EU 39 - 44', 10),
(10011, 2001, 'Packaging', '10 Pairs / Master Carton (0.096 m³ • 22.5 kg)', 11),
(10012, 2001, 'Wholesale FOB Reference', '$13.54 / pair (Rp 314,425 Factory List)', 12),
(10013, 2001, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10014, 2001, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10015, 2001, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10016, 2002, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10017, 2002, 'Key Spec', 'Injeksi PVC Khusus • SRC Certified (SRA + SRB Heavy Lug Outsole) • EU 39 - 44', 2),
(10018, 2002, 'Upper Material', 'Injeksi PVC Khusus', 3),
(10019, 2002, 'Outsole', 'Nitrile Blend Anti-Slip Rubber', 4),
(10020, 2002, 'Toe Protection', 'Steel Toe Cap 200 Joule (EN ISO 20345 / ASTM F2413)', 5),
(10021, 2002, 'Underfoot Midsole', 'Steel Midsole Anti-Paku 1100N (Optional on S5)', 6),
(10022, 2002, 'Slip Resistance', 'SRC Certified (SRA + SRB Heavy Lug Outsole)', 7),
(10023, 2002, 'Shaft Height', '38.0 cm', 8),
(10024, 2002, 'Unit Weight', '2150 g / pair', 9),
(10025, 2002, 'Available Sizing', 'EU 39 - 44', 10),
(10026, 2002, 'Packaging', '10 Pairs / Master Carton (0.096 m³ • 22.5 kg)', 11),
(10027, 2002, 'Wholesale FOB Reference', '$12.94 / pair (Rp 300,400 Factory List)', 12),
(10028, 2002, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10029, 2002, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10030, 2002, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10031, 2003, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10032, 2003, 'Key Spec', 'High Density PVC / Nitrile • SRC Certified (SRA + SRB Heavy Lug Outsole) • EU 38 - 45', 2),
(10033, 2003, 'Upper Material', 'High Density PVC / Nitrile', 3),
(10034, 2003, 'Outsole', 'Nitrile Blend Anti-Slip Rubber', 4),
(10035, 2003, 'Toe Protection', 'Steel Toe Cap 200 Joule (EN ISO 20345 / ASTM F2413)', 5),
(10036, 2003, 'Underfoot Midsole', 'Steel Midsole Anti-Paku 1100N (Optional on S5)', 6),
(10037, 2003, 'Slip Resistance', 'SRC Certified (SRA + SRB Heavy Lug Outsole)', 7),
(10038, 2003, 'Shaft Height', '38.0 cm', 8),
(10039, 2003, 'Unit Weight', '2150 g / pair', 9),
(10040, 2003, 'Available Sizing', 'EU 38 - 45', 10),
(10041, 2003, 'Packaging', '10 Pairs / Master Carton (0.096 m³ • 22.5 kg)', 11),
(10042, 2003, 'Wholesale FOB Reference', '$12.86 / pair (Rp 298,533 Factory List)', 12),
(10043, 2003, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10044, 2003, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10045, 2003, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10046, 2004, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10047, 2004, 'Key Spec', 'Virgin PVC / Nitrile Blend • SRC Certified (SRA + SRB Heavy Lug Outsole) • EU 39 - 44', 2),
(10048, 2004, 'Upper Material', 'Virgin PVC / Nitrile Blend', 3),
(10049, 2004, 'Outsole', 'Nitrile Blend Anti-Slip Rubber', 4),
(10050, 2004, 'Toe Protection', 'Steel Toe Cap 200 Joule (EN ISO 20345 / ASTM F2413)', 5),
(10051, 2004, 'Underfoot Midsole', 'Steel Midsole Anti-Paku 1100N (Optional on S5)', 6),
(10052, 2004, 'Slip Resistance', 'SRC Certified (SRA + SRB Heavy Lug Outsole)', 7),
(10053, 2004, 'Shaft Height', '38.0 cm', 8),
(10054, 2004, 'Unit Weight', '2150 g / pair', 9),
(10055, 2004, 'Available Sizing', 'EU 39 - 44', 10),
(10056, 2004, 'Packaging', '10 Pairs / Master Carton (0.096 m³ • 22.5 kg)', 11),
(10057, 2004, 'Wholesale FOB Reference', '$12.86 / pair (Rp 298,500 Factory List)', 12),
(10058, 2004, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10059, 2004, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10060, 2004, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10061, 2005, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10062, 2005, 'Key Spec', 'Heavy PVC Armor • SRC Certified (SRA + SRB Heavy Lug Outsole) • EU 39 - 45', 2),
(10063, 2005, 'Upper Material', 'Heavy PVC Armor', 3),
(10064, 2005, 'Outsole', 'Nitrile Blend Anti-Slip Rubber', 4),
(10065, 2005, 'Toe Protection', 'Steel Toe Cap 200 Joule (EN ISO 20345 / ASTM F2413)', 5),
(10066, 2005, 'Underfoot Midsole', 'Steel Midsole Anti-Paku 1100N (Optional on S5)', 6),
(10067, 2005, 'Slip Resistance', 'SRC Certified (SRA + SRB Heavy Lug Outsole)', 7),
(10068, 2005, 'Shaft Height', '38.0 cm', 8),
(10069, 2005, 'Unit Weight', '2150 g / pair', 9),
(10070, 2005, 'Available Sizing', 'EU 39 - 45', 10),
(10071, 2005, 'Packaging', '10 Pairs / Master Carton (0.096 m³ • 22.5 kg)', 11),
(10072, 2005, 'Wholesale FOB Reference', '$12.94 / pair (Rp 300,400 Factory List)', 12),
(10073, 2005, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10074, 2005, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10075, 2005, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10076, 2006, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10077, 2006, 'Key Spec', 'High Grade PVC / PVC Sole • SRC Certified (SRA + SRB Heavy Lug Outsole) • EU 39 - 44', 2),
(10078, 2006, 'Upper Material', 'High Grade PVC / PVC Sole', 3),
(10079, 2006, 'Outsole', 'Nitrile Blend Anti-Slip Rubber', 4),
(10080, 2006, 'Toe Protection', 'Steel Toe Cap 200 Joule (EN ISO 20345 / ASTM F2413)', 5),
(10081, 2006, 'Underfoot Midsole', 'Steel Midsole Anti-Paku 1100N (Optional on S5)', 6),
(10082, 2006, 'Slip Resistance', 'SRC Certified (SRA + SRB Heavy Lug Outsole)', 7),
(10083, 2006, 'Shaft Height', '38.0 cm', 8),
(10084, 2006, 'Unit Weight', '2150 g / pair', 9),
(10085, 2006, 'Available Sizing', 'EU 39 - 44', 10),
(10086, 2006, 'Packaging', '10 Pairs / Master Carton (0.096 m³ • 22.5 kg)', 11),
(10087, 2006, 'Wholesale FOB Reference', '$11.78 / pair (Rp 273,566 Factory List)', 12),
(10088, 2006, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10089, 2006, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10090, 2006, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10091, 2007, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10092, 2007, 'Key Spec', 'Nitrile Compound PVC • SRC Certified (SRA + SRB Heavy Lug Outsole) • EU 38 - 45', 2),
(10093, 2007, 'Upper Material', 'Nitrile Compound PVC', 3),
(10094, 2007, 'Outsole', 'Nitrile Blend Anti-Slip Rubber', 4),
(10095, 2007, 'Toe Protection', 'Steel Toe Cap 200 Joule (EN ISO 20345 / ASTM F2413)', 5),
(10096, 2007, 'Underfoot Midsole', 'Steel Midsole Anti-Paku 1100N (Optional on S5)', 6),
(10097, 2007, 'Slip Resistance', 'SRC Certified (SRA + SRB Heavy Lug Outsole)', 7),
(10098, 2007, 'Shaft Height', '38.0 cm', 8),
(10099, 2007, 'Unit Weight', '2150 g / pair', 9),
(10100, 2007, 'Available Sizing', 'EU 38 - 45', 10),
(10101, 2007, 'Packaging', '10 Pairs / Master Carton (0.096 m³ • 22.5 kg)', 11),
(10102, 2007, 'Wholesale FOB Reference', '$12.86 / pair (Rp 298,500 Factory List)', 12),
(10103, 2007, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10104, 2007, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10105, 2007, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10106, 2008, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10107, 2008, 'Key Spec', 'Fleksibel PVC / Sol Karet • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 44', 2),
(10108, 2008, 'Upper Material', 'Fleksibel PVC / Sol Karet', 3),
(10109, 2008, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10110, 2008, 'Toe Protection', 'None (Plain Reinforced Soft Toe)', 5),
(10111, 2008, 'Underfoot Midsole', 'None (High Flexibility Sole)', 6),
(10112, 2008, 'Slip Resistance', 'Self-Cleaning Mud-Release Cleated Lugs', 7),
(10113, 2008, 'Shaft Height', '30.0 cm', 8),
(10114, 2008, 'Unit Weight', '1350 g / pair', 9),
(10115, 2008, 'Available Sizing', 'EU 38 - 44', 10),
(10116, 2008, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 17.5 kg)', 11),
(10117, 2008, 'Wholesale FOB Reference', '$4.23 / pair (Rp 98,100 Factory List)', 12),
(10118, 2008, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10119, 2008, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10120, 2008, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10121, 2009, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10122, 2009, 'Key Spec', 'Fleksibel PVC / Sol Hitam • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 44', 2),
(10123, 2009, 'Upper Material', 'Fleksibel PVC / Sol Hitam', 3),
(10124, 2009, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10125, 2009, 'Toe Protection', 'None (Plain Reinforced Soft Toe)', 5),
(10126, 2009, 'Underfoot Midsole', 'None (High Flexibility Sole)', 6),
(10127, 2009, 'Slip Resistance', 'Self-Cleaning Mud-Release Cleated Lugs', 7),
(10128, 2009, 'Shaft Height', '30.0 cm', 8),
(10129, 2009, 'Unit Weight', '1350 g / pair', 9),
(10130, 2009, 'Available Sizing', 'EU 38 - 44', 10),
(10131, 2009, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 17.5 kg)', 11),
(10132, 2009, 'Wholesale FOB Reference', '$3.47 / pair (Rp 80,625 Factory List)', 12),
(10133, 2009, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10134, 2009, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10135, 2009, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10136, 2010, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10137, 2010, 'Key Spec', 'High-Visibility PVC • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 44', 2),
(10138, 2010, 'Upper Material', 'High-Visibility PVC', 3),
(10139, 2010, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10140, 2010, 'Toe Protection', 'None (Plain Reinforced Soft Toe)', 5),
(10141, 2010, 'Underfoot Midsole', 'None (High Flexibility Sole)', 6),
(10142, 2010, 'Slip Resistance', 'Self-Cleaning Mud-Release Cleated Lugs', 7),
(10143, 2010, 'Shaft Height', '30.0 cm', 8),
(10144, 2010, 'Unit Weight', '1350 g / pair', 9),
(10145, 2010, 'Available Sizing', 'EU 38 - 44', 10),
(10146, 2010, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 17.5 kg)', 11),
(10147, 2010, 'Wholesale FOB Reference', '$4.63 / pair (Rp 107,400 Factory List)', 12),
(10148, 2010, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10149, 2010, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10150, 2010, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10151, 2011, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10152, 2011, 'Key Spec', 'High-Visibility PVC • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 44', 2),
(10153, 2011, 'Upper Material', 'High-Visibility PVC', 3),
(10154, 2011, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10155, 2011, 'Toe Protection', 'None (Plain Reinforced Soft Toe)', 5),
(10156, 2011, 'Underfoot Midsole', 'None (High Flexibility Sole)', 6),
(10157, 2011, 'Slip Resistance', 'Self-Cleaning Mud-Release Cleated Lugs', 7),
(10158, 2011, 'Shaft Height', '30.0 cm', 8),
(10159, 2011, 'Unit Weight', '1350 g / pair', 9),
(10160, 2011, 'Available Sizing', 'EU 38 - 44', 10),
(10161, 2011, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 17.5 kg)', 11),
(10162, 2011, 'Wholesale FOB Reference', '$4.91 / pair (Rp 114,066 Factory List)', 12),
(10163, 2011, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10164, 2011, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10165, 2011, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10166, 2012, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10167, 2012, 'Key Spec', 'Virgin Rubber Blend PVC • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 45', 2),
(10168, 2012, 'Upper Material', 'Virgin Rubber Blend PVC', 3),
(10169, 2012, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10170, 2012, 'Toe Protection', 'None (Plain Reinforced Soft Toe)', 5),
(10171, 2012, 'Underfoot Midsole', 'None (High Flexibility Sole)', 6),
(10172, 2012, 'Slip Resistance', 'Self-Cleaning Mud-Release Cleated Lugs', 7),
(10173, 2012, 'Shaft Height', '30.0 cm', 8),
(10174, 2012, 'Unit Weight', '1350 g / pair', 9),
(10175, 2012, 'Available Sizing', 'EU 38 - 45', 10),
(10176, 2012, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 17.5 kg)', 11),
(10177, 2012, 'Wholesale FOB Reference', '$2.71 / pair (Rp 62,900 Factory List)', 12),
(10178, 2012, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10179, 2012, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10180, 2012, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10181, 2013, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10182, 2013, 'Key Spec', 'Tebal PVC Injeksi • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 43', 2),
(10183, 2013, 'Upper Material', 'Tebal PVC Injeksi', 3),
(10184, 2013, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10185, 2013, 'Toe Protection', 'None (Plain Reinforced Soft Toe)', 5),
(10186, 2013, 'Underfoot Midsole', 'None (High Flexibility Sole)', 6),
(10187, 2013, 'Slip Resistance', 'Self-Cleaning Mud-Release Cleated Lugs', 7),
(10188, 2013, 'Shaft Height', '30.0 cm', 8),
(10189, 2013, 'Unit Weight', '1350 g / pair', 9),
(10190, 2013, 'Available Sizing', 'EU 38 - 43', 10),
(10191, 2013, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 17.5 kg)', 11),
(10192, 2013, 'Wholesale FOB Reference', '$5.92 / pair (Rp 137,400 Factory List)', 12),
(10193, 2013, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10194, 2013, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10195, 2013, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10196, 2014, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10197, 2014, 'Key Spec', 'Tebal PVC Injeksi • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 43', 2),
(10198, 2014, 'Upper Material', 'Tebal PVC Injeksi', 3),
(10199, 2014, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10200, 2014, 'Toe Protection', 'None (Plain Reinforced Soft Toe)', 5),
(10201, 2014, 'Underfoot Midsole', 'None (High Flexibility Sole)', 6),
(10202, 2014, 'Slip Resistance', 'Self-Cleaning Mud-Release Cleated Lugs', 7),
(10203, 2014, 'Shaft Height', '30.0 cm', 8),
(10204, 2014, 'Unit Weight', '1350 g / pair', 9),
(10205, 2014, 'Available Sizing', 'EU 38 - 43', 10),
(10206, 2014, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 17.5 kg)', 11),
(10207, 2014, 'Wholesale FOB Reference', '$5.47 / pair (Rp 126,999 Factory List)', 12),
(10208, 2014, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10209, 2014, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10210, 2014, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10211, 2015, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10212, 2015, 'Key Spec', 'Food & Farm Safe PVC • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 43', 2),
(10213, 2015, 'Upper Material', 'Food & Farm Safe PVC', 3),
(10214, 2015, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10215, 2015, 'Toe Protection', 'None (Plain Reinforced Soft Toe)', 5),
(10216, 2015, 'Underfoot Midsole', 'None (High Flexibility Sole)', 6),
(10217, 2015, 'Slip Resistance', 'Self-Cleaning Mud-Release Cleated Lugs', 7),
(10218, 2015, 'Shaft Height', '30.0 cm', 8),
(10219, 2015, 'Unit Weight', '1350 g / pair', 9),
(10220, 2015, 'Available Sizing', 'EU 38 - 43', 10),
(10221, 2015, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 17.5 kg)', 11),
(10222, 2015, 'Wholesale FOB Reference', '$6.24 / pair (Rp 144,900 Factory List)', 12),
(10223, 2015, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10224, 2015, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10225, 2015, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10226, 2016, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10227, 2016, 'Key Spec', 'PVC Daur Ulang Ramah Lingkungan • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 44', 2),
(10228, 2016, 'Upper Material', 'PVC Daur Ulang Ramah Lingkungan', 3),
(10229, 2016, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10230, 2016, 'Toe Protection', 'None (Plain Reinforced Soft Toe)', 5),
(10231, 2016, 'Underfoot Midsole', 'None (High Flexibility Sole)', 6),
(10232, 2016, 'Slip Resistance', 'Self-Cleaning Mud-Release Cleated Lugs', 7),
(10233, 2016, 'Shaft Height', '30.0 cm', 8),
(10234, 2016, 'Unit Weight', '1350 g / pair', 9),
(10235, 2016, 'Available Sizing', 'EU 38 - 44', 10),
(10236, 2016, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 17.5 kg)', 11),
(10237, 2016, 'Wholesale FOB Reference', '$4.07 / pair (Rp 94,400 Factory List)', 12),
(10238, 2016, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10239, 2016, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10240, 2016, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10241, 2017, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10242, 2017, 'Key Spec', 'Elastis PVC • Self-Cleaning Mud-Release Cleated Lugs • EU 39 - 43', 2),
(10243, 2017, 'Upper Material', 'Elastis PVC', 3),
(10244, 2017, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10245, 2017, 'Toe Protection', 'None (Plain Reinforced Soft Toe)', 5),
(10246, 2017, 'Underfoot Midsole', 'None (High Flexibility Sole)', 6),
(10247, 2017, 'Slip Resistance', 'Self-Cleaning Mud-Release Cleated Lugs', 7),
(10248, 2017, 'Shaft Height', '30.0 cm', 8),
(10249, 2017, 'Unit Weight', '1350 g / pair', 9),
(10250, 2017, 'Available Sizing', 'EU 39 - 43', 10);

INSERT INTO `product_specifications` (`id`, `product_id`, `spec_label`, `spec_value`, `display_order`) VALUES
(10251, 2017, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 17.5 kg)', 11),
(10252, 2017, 'Wholesale FOB Reference', '$3.47 / pair (Rp 80,625 Factory List)', 12),
(10253, 2017, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10254, 2017, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10255, 2017, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10256, 2018, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10257, 2018, 'Key Spec', 'Dual Tone PVC Injeksi • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 44', 2),
(10258, 2018, 'Upper Material', 'Dual Tone PVC Injeksi', 3),
(10259, 2018, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10260, 2018, 'Toe Protection', 'None (Plain Reinforced Soft Toe)', 5),
(10261, 2018, 'Underfoot Midsole', 'None (High Flexibility Sole)', 6),
(10262, 2018, 'Slip Resistance', 'Self-Cleaning Mud-Release Cleated Lugs', 7),
(10263, 2018, 'Shaft Height', '30.0 cm', 8),
(10264, 2018, 'Unit Weight', '1350 g / pair', 9),
(10265, 2018, 'Available Sizing', 'EU 38 - 44', 10),
(10266, 2018, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 17.5 kg)', 11),
(10267, 2018, 'Wholesale FOB Reference', '$5.41 / pair (Rp 125,566 Factory List)', 12),
(10268, 2018, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10269, 2018, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10270, 2018, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10271, 2019, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10272, 2019, 'Key Spec', 'Camouflage PVC Pattern • Self-Cleaning Mud-Release Cleated Lugs • EU 39 - 44', 2),
(10273, 2019, 'Upper Material', 'Camouflage PVC Pattern', 3),
(10274, 2019, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10275, 2019, 'Toe Protection', 'None (Plain Reinforced Soft Toe)', 5),
(10276, 2019, 'Underfoot Midsole', 'None (High Flexibility Sole)', 6),
(10277, 2019, 'Slip Resistance', 'Self-Cleaning Mud-Release Cleated Lugs', 7),
(10278, 2019, 'Shaft Height', '30.0 cm', 8),
(10279, 2019, 'Unit Weight', '1350 g / pair', 9),
(10280, 2019, 'Available Sizing', 'EU 39 - 44', 10),
(10281, 2019, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 17.5 kg)', 11),
(10282, 2019, 'Wholesale FOB Reference', '$7.36 / pair (Rp 170,900 Factory List)', 12),
(10283, 2019, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10284, 2019, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10285, 2019, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10286, 2020, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10287, 2020, 'Key Spec', 'Earth Tone PVC • Self-Cleaning Mud-Release Cleated Lugs • EU 39 - 44', 2),
(10288, 2020, 'Upper Material', 'Earth Tone PVC', 3),
(10289, 2020, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10290, 2020, 'Toe Protection', 'None (Plain Reinforced Soft Toe)', 5),
(10291, 2020, 'Underfoot Midsole', 'None (High Flexibility Sole)', 6),
(10292, 2020, 'Slip Resistance', 'Self-Cleaning Mud-Release Cleated Lugs', 7),
(10293, 2020, 'Shaft Height', '30.0 cm', 8),
(10294, 2020, 'Unit Weight', '1350 g / pair', 9),
(10295, 2020, 'Available Sizing', 'EU 39 - 44', 10),
(10296, 2020, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 17.5 kg)', 11),
(10297, 2020, 'Wholesale FOB Reference', '$7.36 / pair (Rp 170,900 Factory List)', 12),
(10298, 2020, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10299, 2020, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10300, 2020, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10301, 2021, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10302, 2021, 'Key Spec', 'Heavy Duty PVC • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 44', 2),
(10303, 2021, 'Upper Material', 'Heavy Duty PVC', 3),
(10304, 2021, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10305, 2021, 'Toe Protection', 'None (Plain Reinforced Soft Toe)', 5),
(10306, 2021, 'Underfoot Midsole', 'None (High Flexibility Sole)', 6),
(10307, 2021, 'Slip Resistance', 'Self-Cleaning Mud-Release Cleated Lugs', 7),
(10308, 2021, 'Shaft Height', '30.0 cm', 8),
(10309, 2021, 'Unit Weight', '1350 g / pair', 9),
(10310, 2021, 'Available Sizing', 'EU 38 - 44', 10),
(10311, 2021, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 17.5 kg)', 11),
(10312, 2021, 'Wholesale FOB Reference', '$5.34 / pair (Rp 124,066 Factory List)', 12),
(10313, 2021, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10314, 2021, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10315, 2021, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10316, 2022, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10317, 2022, 'Key Spec', 'Soft PVC Compound • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 43', 2),
(10318, 2022, 'Upper Material', 'Soft PVC Compound', 3),
(10319, 2022, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10320, 2022, 'Toe Protection', 'None (Plain Reinforced Soft Toe)', 5),
(10321, 2022, 'Underfoot Midsole', 'None (High Flexibility Sole)', 6),
(10322, 2022, 'Slip Resistance', 'Self-Cleaning Mud-Release Cleated Lugs', 7),
(10323, 2022, 'Shaft Height', '30.0 cm', 8),
(10324, 2022, 'Unit Weight', '1350 g / pair', 9),
(10325, 2022, 'Available Sizing', 'EU 38 - 43', 10),
(10326, 2022, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 17.5 kg)', 11),
(10327, 2022, 'Wholesale FOB Reference', '$5.47 / pair (Rp 126,999 Factory List)', 12),
(10328, 2022, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10329, 2022, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10330, 2022, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10331, 2023, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10332, 2023, 'Key Spec', 'Reinforced PVC • Self-Cleaning Mud-Release Cleated Lugs • EU 39 - 44', 2),
(10333, 2023, 'Upper Material', 'Reinforced PVC', 3),
(10334, 2023, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10335, 2023, 'Toe Protection', 'None (Plain Reinforced Soft Toe)', 5),
(10336, 2023, 'Underfoot Midsole', 'None (High Flexibility Sole)', 6),
(10337, 2023, 'Slip Resistance', 'Self-Cleaning Mud-Release Cleated Lugs', 7),
(10338, 2023, 'Shaft Height', '30.0 cm', 8),
(10339, 2023, 'Unit Weight', '1350 g / pair', 9),
(10340, 2023, 'Available Sizing', 'EU 39 - 44', 10),
(10341, 2023, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 17.5 kg)', 11),
(10342, 2023, 'Wholesale FOB Reference', '$5.47 / pair (Rp 126,999 Factory List)', 12),
(10343, 2023, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10344, 2023, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10345, 2023, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10346, 2024, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10347, 2024, 'Key Spec', 'Sanitized PVC • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 43', 2),
(10348, 2024, 'Upper Material', 'Sanitized PVC', 3),
(10349, 2024, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10350, 2024, 'Toe Protection', 'None (Plain Reinforced Soft Toe)', 5),
(10351, 2024, 'Underfoot Midsole', 'None (High Flexibility Sole)', 6),
(10352, 2024, 'Slip Resistance', 'Self-Cleaning Mud-Release Cleated Lugs', 7),
(10353, 2024, 'Shaft Height', '30.0 cm', 8),
(10354, 2024, 'Unit Weight', '1350 g / pair', 9),
(10355, 2024, 'Available Sizing', 'EU 38 - 43', 10),
(10356, 2024, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 17.5 kg)', 11),
(10357, 2024, 'Wholesale FOB Reference', '$4.24 / pair (Rp 98,400 Factory List)', 12),
(10358, 2024, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10359, 2024, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10360, 2024, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10361, 2025, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10362, 2025, 'Key Spec', 'Multi-Use PVC • Self-Cleaning Mud-Release Cleated Lugs • EU 38 - 44', 2),
(10363, 2025, 'Upper Material', 'Multi-Use PVC', 3),
(10364, 2025, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10365, 2025, 'Toe Protection', 'None (Plain Reinforced Soft Toe)', 5),
(10366, 2025, 'Underfoot Midsole', 'None (High Flexibility Sole)', 6),
(10367, 2025, 'Slip Resistance', 'Self-Cleaning Mud-Release Cleated Lugs', 7),
(10368, 2025, 'Shaft Height', '30.0 cm', 8),
(10369, 2025, 'Unit Weight', '1350 g / pair', 9),
(10370, 2025, 'Available Sizing', 'EU 38 - 44', 10),
(10371, 2025, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 17.5 kg)', 11),
(10372, 2025, 'Wholesale FOB Reference', '$3.20 / pair (Rp 74,400 Factory List)', 12),
(10373, 2025, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10374, 2025, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10375, 2025, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10376, 2026, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10377, 2026, 'Key Spec', 'PVC Nitrile + Steel Toe • Self-Cleaning Mud-Release Cleated Lugs • EU 39 - 44', 2),
(10378, 2026, 'Upper Material', 'PVC Nitrile + Steel Toe', 3),
(10379, 2026, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10380, 2026, 'Toe Protection', 'None (Plain Reinforced Soft Toe)', 5),
(10381, 2026, 'Underfoot Midsole', 'None (High Flexibility Sole)', 6),
(10382, 2026, 'Slip Resistance', 'Self-Cleaning Mud-Release Cleated Lugs', 7),
(10383, 2026, 'Shaft Height', '30.0 cm', 8),
(10384, 2026, 'Unit Weight', '1350 g / pair', 9),
(10385, 2026, 'Available Sizing', 'EU 39 - 44', 10),
(10386, 2026, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 17.5 kg)', 11),
(10387, 2026, 'Wholesale FOB Reference', '$11.78 / pair (Rp 273,566 Factory List)', 12),
(10388, 2026, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10389, 2026, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10390, 2026, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10391, 2027, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10392, 2027, 'Key Spec', 'High Shaft PVC (38 - 40 cm) • Saltwater-Resistant Anti-Hydroplaning Tread • EU 39 - 45', 2),
(10393, 2027, 'Upper Material', 'High Shaft PVC (38 - 40 cm)', 3),
(10394, 2027, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10395, 2027, 'Toe Protection', 'None (Plain Reinforced Soft Toe)', 5),
(10396, 2027, 'Underfoot Midsole', 'None', 6),
(10397, 2027, 'Slip Resistance', 'Saltwater-Resistant Anti-Hydroplaning Tread', 7),
(10398, 2027, 'Shaft Height', '40.0 cm', 8),
(10399, 2027, 'Unit Weight', '1750 g / pair', 9),
(10400, 2027, 'Available Sizing', 'EU 39 - 45', 10),
(10401, 2027, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 19.5 kg)', 11),
(10402, 2027, 'Wholesale FOB Reference', '$4.44 / pair (Rp 103,125 Factory List)', 12),
(10403, 2027, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10404, 2027, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10405, 2027, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10406, 2028, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10407, 2028, 'Key Spec', 'Micro-cellular PVC / Rubber Sole • Oil & Grease SRC Anti-Slip Rubber Pods • EU 36 - 44', 2),
(10408, 2028, 'Upper Material', 'Micro-cellular PVC / Rubber Sole', 3),
(10409, 2028, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10410, 2028, 'Toe Protection', 'Reinforced Ergonomic Toe Box', 5),
(10411, 2028, 'Underfoot Midsole', 'Ergonomic Anti-Fatigue Cushion Insole', 6),
(10412, 2028, 'Slip Resistance', 'Oil & Grease SRC Anti-Slip Rubber Pods', 7),
(10413, 2028, 'Shaft Height', '11.5 cm', 8),
(10414, 2028, 'Unit Weight', '750 g / pair', 9),
(10415, 2028, 'Available Sizing', 'EU 36 - 44', 10),
(10416, 2028, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 11.5 kg)', 11),
(10417, 2028, 'Wholesale FOB Reference', '$8.85 / pair (Rp 205,478 Factory List)', 12),
(10418, 2028, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10419, 2028, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10420, 2028, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10421, 2029, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10422, 2029, 'Key Spec', 'Micro-cellular PVC / Rubber Sole • Oil & Grease SRC Anti-Slip Rubber Pods • EU 36 - 44', 2),
(10423, 2029, 'Upper Material', 'Micro-cellular PVC / Rubber Sole', 3),
(10424, 2029, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10425, 2029, 'Toe Protection', 'Reinforced Ergonomic Toe Box', 5),
(10426, 2029, 'Underfoot Midsole', 'Ergonomic Anti-Fatigue Cushion Insole', 6),
(10427, 2029, 'Slip Resistance', 'Oil & Grease SRC Anti-Slip Rubber Pods', 7),
(10428, 2029, 'Shaft Height', '11.5 cm', 8),
(10429, 2029, 'Unit Weight', '750 g / pair', 9),
(10430, 2029, 'Available Sizing', 'EU 36 - 44', 10),
(10431, 2029, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 11.5 kg)', 11),
(10432, 2029, 'Wholesale FOB Reference', '$8.90 / pair (Rp 206,700 Factory List)', 12),
(10433, 2029, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10434, 2029, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10435, 2029, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10436, 2030, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10437, 2030, 'Key Spec', 'Ortholite Memory Foam Pad • Oil & Grease SRC Anti-Slip Rubber Pods • Multi-Size', 2),
(10438, 2030, 'Upper Material', 'Ortholite Memory Foam Pad', 3),
(10439, 2030, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10440, 2030, 'Toe Protection', 'Reinforced Ergonomic Toe Box', 5),
(10441, 2030, 'Underfoot Midsole', 'Ergonomic Anti-Fatigue Cushion Insole', 6),
(10442, 2030, 'Slip Resistance', 'Oil & Grease SRC Anti-Slip Rubber Pods', 7),
(10443, 2030, 'Shaft Height', '1.5 cm', 8),
(10444, 2030, 'Unit Weight', '120 g / pair', 9),
(10445, 2030, 'Available Sizing', 'Multi-Size', 10),
(10446, 2030, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 11.5 kg)', 11),
(10447, 2030, 'Wholesale FOB Reference', '$5.67 / pair (Rp 131,700 Factory List)', 12),
(10448, 2030, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10449, 2030, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10450, 2030, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10451, 2031, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10452, 2031, 'Key Spec', 'Medical Grade PVC Antiseptik • Medical-Grade Anti-Slip Pattern • EU 36 - 43', 2),
(10453, 2031, 'Upper Material', 'Medical Grade PVC Antiseptik', 3),
(10454, 2031, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10455, 2031, 'Toe Protection', 'Reinforced Hygiene Clog Toe', 5),
(10456, 2031, 'Underfoot Midsole', 'Orthopedic Shock-Absorbing Footbed', 6),
(10457, 2031, 'Slip Resistance', 'Medical-Grade Anti-Slip Pattern', 7),
(10458, 2031, 'Shaft Height', '9.0 cm', 8),
(10459, 2031, 'Unit Weight', '580 g / pair', 9),
(10460, 2031, 'Available Sizing', 'EU 36 - 43', 10),
(10461, 2031, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 9.5 kg)', 11),
(10462, 2031, 'Wholesale FOB Reference', '$11.42 / pair (Rp 265,000 Factory List)', 12),
(10463, 2031, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10464, 2031, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10465, 2031, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10466, 2032, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10467, 2032, 'Key Spec', 'Medical Grade PVC Antiseptik • Medical-Grade Anti-Slip Pattern • EU 36 - 43', 2),
(10468, 2032, 'Upper Material', 'Medical Grade PVC Antiseptik', 3),
(10469, 2032, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10470, 2032, 'Toe Protection', 'Reinforced Hygiene Clog Toe', 5),
(10471, 2032, 'Underfoot Midsole', 'Orthopedic Shock-Absorbing Footbed', 6),
(10472, 2032, 'Slip Resistance', 'Medical-Grade Anti-Slip Pattern', 7),
(10473, 2032, 'Shaft Height', '9.0 cm', 8),
(10474, 2032, 'Unit Weight', '580 g / pair', 9),
(10475, 2032, 'Available Sizing', 'EU 36 - 43', 10),
(10476, 2032, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 9.5 kg)', 11),
(10477, 2032, 'Wholesale FOB Reference', '$11.67 / pair (Rp 271,000 Factory List)', 12),
(10478, 2032, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10479, 2032, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10480, 2032, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10481, 2033, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10482, 2033, 'Key Spec', 'Sanitized Medical PVC • Medical-Grade Anti-Slip Pattern • EU 36 - 43', 2),
(10483, 2033, 'Upper Material', 'Sanitized Medical PVC', 3),
(10484, 2033, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10485, 2033, 'Toe Protection', 'Reinforced Hygiene Clog Toe', 5),
(10486, 2033, 'Underfoot Midsole', 'Orthopedic Shock-Absorbing Footbed', 6),
(10487, 2033, 'Slip Resistance', 'Medical-Grade Anti-Slip Pattern', 7),
(10488, 2033, 'Shaft Height', '9.0 cm', 8),
(10489, 2033, 'Unit Weight', '580 g / pair', 9),
(10490, 2033, 'Available Sizing', 'EU 36 - 43', 10),
(10491, 2033, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 9.5 kg)', 11),
(10492, 2033, 'Wholesale FOB Reference', '$11.18 / pair (Rp 259,540 Factory List)', 12),
(10493, 2033, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10494, 2033, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10495, 2033, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10496, 2034, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10497, 2034, 'Key Spec', 'Ergonomic Insole Bed • Medical-Grade Anti-Slip Pattern • Multi-Size', 2),
(10498, 2034, 'Upper Material', 'Ergonomic Insole Bed', 3),
(10499, 2034, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10500, 2034, 'Toe Protection', 'Reinforced Hygiene Clog Toe', 5);

INSERT INTO `product_specifications` (`id`, `product_id`, `spec_label`, `spec_value`, `display_order`) VALUES
(10501, 2034, 'Underfoot Midsole', 'Orthopedic Shock-Absorbing Footbed', 6),
(10502, 2034, 'Slip Resistance', 'Medical-Grade Anti-Slip Pattern', 7),
(10503, 2034, 'Shaft Height', '1.5 cm', 8),
(10504, 2034, 'Unit Weight', '120 g / pair', 9),
(10505, 2034, 'Available Sizing', 'Multi-Size', 10),
(10506, 2034, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 9.5 kg)', 11),
(10507, 2034, 'Wholesale FOB Reference', '$9.05 / pair (Rp 210,000 Factory List)', 12),
(10508, 2034, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10509, 2034, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10510, 2034, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10511, 2035, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10512, 2035, 'Key Spec', 'Ergonomic Insole Bed • Medical-Grade Anti-Slip Pattern • Multi-Size', 2),
(10513, 2035, 'Upper Material', 'Ergonomic Insole Bed', 3),
(10514, 2035, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10515, 2035, 'Toe Protection', 'Reinforced Hygiene Clog Toe', 5),
(10516, 2035, 'Underfoot Midsole', 'Orthopedic Shock-Absorbing Footbed', 6),
(10517, 2035, 'Slip Resistance', 'Medical-Grade Anti-Slip Pattern', 7),
(10518, 2035, 'Shaft Height', '1.5 cm', 8),
(10519, 2035, 'Unit Weight', '120 g / pair', 9),
(10520, 2035, 'Available Sizing', 'Multi-Size', 10),
(10521, 2035, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 9.5 kg)', 11),
(10522, 2035, 'Wholesale FOB Reference', '$6.76 / pair (Rp 157,000 Factory List)', 12),
(10523, 2035, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10524, 2035, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10525, 2035, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10526, 2036, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10527, 2036, 'Key Spec', 'Medical Grade PVC • Medical-Grade Anti-Slip Pattern • EU 36 - 41', 2),
(10528, 2036, 'Upper Material', 'Medical Grade PVC', 3),
(10529, 2036, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10530, 2036, 'Toe Protection', 'Reinforced Hygiene Clog Toe', 5),
(10531, 2036, 'Underfoot Midsole', 'Orthopedic Shock-Absorbing Footbed', 6),
(10532, 2036, 'Slip Resistance', 'Medical-Grade Anti-Slip Pattern', 7),
(10533, 2036, 'Shaft Height', '9.0 cm', 8),
(10534, 2036, 'Unit Weight', '580 g / pair', 9),
(10535, 2036, 'Available Sizing', 'EU 36 - 41', 10),
(10536, 2036, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 9.5 kg)', 11),
(10537, 2036, 'Wholesale FOB Reference', '$12.31 / pair (Rp 285,666 Factory List)', 12),
(10538, 2036, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10539, 2036, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10540, 2036, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10541, 2037, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10542, 2037, 'Key Spec', 'Medical Grade PVC • Medical-Grade Anti-Slip Pattern • EU 37 - 43', 2),
(10543, 2037, 'Upper Material', 'Medical Grade PVC', 3),
(10544, 2037, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10545, 2037, 'Toe Protection', 'Reinforced Hygiene Clog Toe', 5),
(10546, 2037, 'Underfoot Midsole', 'Orthopedic Shock-Absorbing Footbed', 6),
(10547, 2037, 'Slip Resistance', 'Medical-Grade Anti-Slip Pattern', 7),
(10548, 2037, 'Shaft Height', '9.0 cm', 8),
(10549, 2037, 'Unit Weight', '580 g / pair', 9),
(10550, 2037, 'Available Sizing', 'EU 37 - 43', 10),
(10551, 2037, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 9.5 kg)', 11),
(10552, 2037, 'Wholesale FOB Reference', '$12.02 / pair (Rp 279,000 Factory List)', 12),
(10553, 2037, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10554, 2037, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10555, 2037, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10556, 2038, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10557, 2038, 'Key Spec', 'Breathable Vent PVC / Rubber Sole • Grooved Rain Water-Dispersion Sole • EU 38 - 43', 2),
(10558, 2038, 'Upper Material', 'Breathable Vent PVC / Rubber Sole', 3),
(10559, 2038, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10560, 2038, 'Toe Protection', 'None (Ankle Guard Protection)', 5),
(10561, 2038, 'Underfoot Midsole', 'None (Footpeg Gripping Sole)', 6),
(10562, 2038, 'Slip Resistance', 'Grooved Rain Water-Dispersion Sole', 7),
(10563, 2038, 'Shaft Height', '21.0 cm', 8),
(10564, 2038, 'Unit Weight', '860 g / pair', 9),
(10565, 2038, 'Available Sizing', 'EU 38 - 43', 10),
(10566, 2038, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 12.5 kg)', 11),
(10567, 2038, 'Wholesale FOB Reference', '$2.85 / pair (Rp 66,150 Factory List)', 12),
(10568, 2038, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10569, 2038, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10570, 2038, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10571, 2039, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10572, 2039, 'Key Spec', 'Dual Injeksi PVC • Grooved Rain Water-Dispersion Sole • EU 38 - 44', 2),
(10573, 2039, 'Upper Material', 'Dual Injeksi PVC', 3),
(10574, 2039, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10575, 2039, 'Toe Protection', 'None (Ankle Guard Protection)', 5),
(10576, 2039, 'Underfoot Midsole', 'None (Footpeg Gripping Sole)', 6),
(10577, 2039, 'Slip Resistance', 'Grooved Rain Water-Dispersion Sole', 7),
(10578, 2039, 'Shaft Height', '21.0 cm', 8),
(10579, 2039, 'Unit Weight', '860 g / pair', 9),
(10580, 2039, 'Available Sizing', 'EU 38 - 44', 10),
(10581, 2039, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 12.5 kg)', 11),
(10582, 2039, 'Wholesale FOB Reference', '$2.85 / pair (Rp 66,150 Factory List)', 12),
(10583, 2039, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10584, 2039, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10585, 2039, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10586, 2040, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10587, 2040, 'Key Spec', 'Soft PVC / Karet Sol • Grooved Rain Water-Dispersion Sole • EU 39 - 43', 2),
(10588, 2040, 'Upper Material', 'Soft PVC / Karet Sol', 3),
(10589, 2040, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10590, 2040, 'Toe Protection', 'None (Ankle Guard Protection)', 5),
(10591, 2040, 'Underfoot Midsole', 'None (Footpeg Gripping Sole)', 6),
(10592, 2040, 'Slip Resistance', 'Grooved Rain Water-Dispersion Sole', 7),
(10593, 2040, 'Shaft Height', '22.0 cm', 8),
(10594, 2040, 'Unit Weight', '880 g / pair', 9),
(10595, 2040, 'Available Sizing', 'EU 39 - 43', 10),
(10596, 2040, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 12.5 kg)', 11),
(10597, 2040, 'Wholesale FOB Reference', '$4.20 / pair (Rp 97,400 Factory List)', 12),
(10598, 2040, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10599, 2040, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10600, 2040, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10601, 2041, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10602, 2041, 'Key Spec', 'Breathable Vent PVC • Grooved Rain Water-Dispersion Sole • EU 38 - 43', 2),
(10603, 2041, 'Upper Material', 'Breathable Vent PVC', 3),
(10604, 2041, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10605, 2041, 'Toe Protection', 'None (Ankle Guard Protection)', 5),
(10606, 2041, 'Underfoot Midsole', 'None (Footpeg Gripping Sole)', 6),
(10607, 2041, 'Slip Resistance', 'Grooved Rain Water-Dispersion Sole', 7),
(10608, 2041, 'Shaft Height', '21.0 cm', 8),
(10609, 2041, 'Unit Weight', '860 g / pair', 9),
(10610, 2041, 'Available Sizing', 'EU 38 - 43', 10),
(10611, 2041, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 12.5 kg)', 11),
(10612, 2041, 'Wholesale FOB Reference', '$2.85 / pair (Rp 66,150 Factory List)', 12),
(10613, 2041, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10614, 2041, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10615, 2041, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10616, 2042, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10617, 2042, 'Key Spec', 'High Grip PVC Sole • Grooved Rain Water-Dispersion Sole • EU 38 - 43', 2),
(10618, 2042, 'Upper Material', 'High Grip PVC Sole', 3),
(10619, 2042, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10620, 2042, 'Toe Protection', 'None (Ankle Guard Protection)', 5),
(10621, 2042, 'Underfoot Midsole', 'None (Footpeg Gripping Sole)', 6),
(10622, 2042, 'Slip Resistance', 'Grooved Rain Water-Dispersion Sole', 7),
(10623, 2042, 'Shaft Height', '21.0 cm', 8),
(10624, 2042, 'Unit Weight', '860 g / pair', 9),
(10625, 2042, 'Available Sizing', 'EU 38 - 43', 10),
(10626, 2042, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 12.5 kg)', 11),
(10627, 2042, 'Wholesale FOB Reference', '$2.67 / pair (Rp 61,900 Factory List)', 12),
(10628, 2042, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10629, 2042, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10630, 2042, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10631, 2043, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10632, 2043, 'Key Spec', 'Casual Motorcross Style • Grooved Rain Water-Dispersion Sole • EU 38 - 43', 2),
(10633, 2043, 'Upper Material', 'Casual Motorcross Style', 3),
(10634, 2043, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10635, 2043, 'Toe Protection', 'None (Ankle Guard Protection)', 5),
(10636, 2043, 'Underfoot Midsole', 'None (Footpeg Gripping Sole)', 6),
(10637, 2043, 'Slip Resistance', 'Grooved Rain Water-Dispersion Sole', 7),
(10638, 2043, 'Shaft Height', '21.0 cm', 8),
(10639, 2043, 'Unit Weight', '860 g / pair', 9),
(10640, 2043, 'Available Sizing', 'EU 38 - 43', 10),
(10641, 2043, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 12.5 kg)', 11),
(10642, 2043, 'Wholesale FOB Reference', '$2.85 / pair (Rp 66,150 Factory List)', 12),
(10643, 2043, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10644, 2043, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10645, 2043, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10646, 2044, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10647, 2044, 'Key Spec', 'Short Ankle PVC Boot • Grooved Rain Water-Dispersion Sole • EU 38 - 43', 2),
(10648, 2044, 'Upper Material', 'Short Ankle PVC Boot', 3),
(10649, 2044, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10650, 2044, 'Toe Protection', 'None (Ankle Guard Protection)', 5),
(10651, 2044, 'Underfoot Midsole', 'None (Footpeg Gripping Sole)', 6),
(10652, 2044, 'Slip Resistance', 'Grooved Rain Water-Dispersion Sole', 7),
(10653, 2044, 'Shaft Height', '21.0 cm', 8),
(10654, 2044, 'Unit Weight', '860 g / pair', 9),
(10655, 2044, 'Available Sizing', 'EU 38 - 43', 10),
(10656, 2044, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 12.5 kg)', 11),
(10657, 2044, 'Wholesale FOB Reference', '$5.82 / pair (Rp 135,100 Factory List)', 12),
(10658, 2044, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10659, 2044, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10660, 2044, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10661, 2045, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10662, 2045, 'Key Spec', 'Reinforced Ankle PVC • Grooved Rain Water-Dispersion Sole • EU 38 - 44', 2),
(10663, 2045, 'Upper Material', 'Reinforced Ankle PVC', 3),
(10664, 2045, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10665, 2045, 'Toe Protection', 'None (Ankle Guard Protection)', 5),
(10666, 2045, 'Underfoot Midsole', 'None (Footpeg Gripping Sole)', 6),
(10667, 2045, 'Slip Resistance', 'Grooved Rain Water-Dispersion Sole', 7),
(10668, 2045, 'Shaft Height', '21.0 cm', 8),
(10669, 2045, 'Unit Weight', '860 g / pair', 9),
(10670, 2045, 'Available Sizing', 'EU 38 - 44', 10),
(10671, 2045, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 12.5 kg)', 11),
(10672, 2045, 'Wholesale FOB Reference', '$5.82 / pair (Rp 135,100 Factory List)', 12),
(10673, 2045, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10674, 2045, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10675, 2045, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10676, 2046, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10677, 2046, 'Key Spec', 'Aerodynamic Riding PVC • Grooved Rain Water-Dispersion Sole • EU 38 - 44', 2),
(10678, 2046, 'Upper Material', 'Aerodynamic Riding PVC', 3),
(10679, 2046, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10680, 2046, 'Toe Protection', 'None (Ankle Guard Protection)', 5),
(10681, 2046, 'Underfoot Midsole', 'None (Footpeg Gripping Sole)', 6),
(10682, 2046, 'Slip Resistance', 'Grooved Rain Water-Dispersion Sole', 7),
(10683, 2046, 'Shaft Height', '21.0 cm', 8),
(10684, 2046, 'Unit Weight', '860 g / pair', 9),
(10685, 2046, 'Available Sizing', 'EU 38 - 44', 10),
(10686, 2046, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 12.5 kg)', 11),
(10687, 2046, 'Wholesale FOB Reference', '$5.82 / pair (Rp 135,100 Factory List)', 12),
(10688, 2046, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10689, 2046, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10690, 2046, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10691, 2047, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10692, 2047, 'Key Spec', 'All-Weather PVC • Grooved Rain Water-Dispersion Sole • EU 38 - 43', 2),
(10693, 2047, 'Upper Material', 'All-Weather PVC', 3),
(10694, 2047, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10695, 2047, 'Toe Protection', 'None (Ankle Guard Protection)', 5),
(10696, 2047, 'Underfoot Midsole', 'None (Footpeg Gripping Sole)', 6),
(10697, 2047, 'Slip Resistance', 'Grooved Rain Water-Dispersion Sole', 7),
(10698, 2047, 'Shaft Height', '21.0 cm', 8),
(10699, 2047, 'Unit Weight', '860 g / pair', 9),
(10700, 2047, 'Available Sizing', 'EU 38 - 43', 10),
(10701, 2047, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 12.5 kg)', 11),
(10702, 2047, 'Wholesale FOB Reference', '$2.54 / pair (Rp 58,900 Factory List)', 12),
(10703, 2047, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10704, 2047, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10705, 2047, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10706, 2048, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10707, 2048, 'Key Spec', 'Breathable Mesh-Pattern PVC • Grooved Rain Water-Dispersion Sole • EU 38 - 43', 2),
(10708, 2048, 'Upper Material', 'Breathable Mesh-Pattern PVC', 3),
(10709, 2048, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10710, 2048, 'Toe Protection', 'None (Ankle Guard Protection)', 5),
(10711, 2048, 'Underfoot Midsole', 'None (Footpeg Gripping Sole)', 6),
(10712, 2048, 'Slip Resistance', 'Grooved Rain Water-Dispersion Sole', 7),
(10713, 2048, 'Shaft Height', '21.0 cm', 8),
(10714, 2048, 'Unit Weight', '860 g / pair', 9),
(10715, 2048, 'Available Sizing', 'EU 38 - 43', 10),
(10716, 2048, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 12.5 kg)', 11),
(10717, 2048, 'Wholesale FOB Reference', '$2.67 / pair (Rp 61,900 Factory List)', 12),
(10718, 2048, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10719, 2048, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10720, 2048, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10721, 2049, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10722, 2049, 'Key Spec', 'Dynamic Racing PVC • Grooved Rain Water-Dispersion Sole • EU 38 - 43', 2),
(10723, 2049, 'Upper Material', 'Dynamic Racing PVC', 3),
(10724, 2049, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10725, 2049, 'Toe Protection', 'None (Ankle Guard Protection)', 5),
(10726, 2049, 'Underfoot Midsole', 'None (Footpeg Gripping Sole)', 6),
(10727, 2049, 'Slip Resistance', 'Grooved Rain Water-Dispersion Sole', 7),
(10728, 2049, 'Shaft Height', '21.0 cm', 8),
(10729, 2049, 'Unit Weight', '860 g / pair', 9),
(10730, 2049, 'Available Sizing', 'EU 38 - 43', 10),
(10731, 2049, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 12.5 kg)', 11),
(10732, 2049, 'Wholesale FOB Reference', '$2.67 / pair (Rp 61,900 Factory List)', 12),
(10733, 2049, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10734, 2049, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10735, 2049, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10736, 2050, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10737, 2050, 'Key Spec', 'Virgin PVC Transparan Mewah • Deep Cleat Tractor Tread • EU 38 - 43', 2),
(10738, 2050, 'Upper Material', 'Virgin PVC Transparan Mewah', 3),
(10739, 2050, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10740, 2050, 'Toe Protection', 'None (Heavy PVC Reinforced Toe)', 5),
(10741, 2050, 'Underfoot Midsole', 'None', 6),
(10742, 2050, 'Slip Resistance', 'Deep Cleat Tractor Tread', 7),
(10743, 2050, 'Shaft Height', '36.0 cm', 8),
(10744, 2050, 'Unit Weight', '1450 g / pair', 9),
(10745, 2050, 'Available Sizing', 'EU 38 - 43', 10),
(10746, 2050, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 18.0 kg)', 11),
(10747, 2050, 'Wholesale FOB Reference', '$5.09 / pair (Rp 118,050 Factory List)', 12),
(10748, 2050, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10749, 2050, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10750, 2050, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15);

INSERT INTO `product_specifications` (`id`, `product_id`, `spec_label`, `spec_value`, `display_order`) VALUES
(10751, 2051, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10752, 2051, 'Key Spec', 'Tebal PVC Injeksi • Deep Cleat Tractor Tread • EU 38 - 43', 2),
(10753, 2051, 'Upper Material', 'Tebal PVC Injeksi', 3),
(10754, 2051, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10755, 2051, 'Toe Protection', 'None (Heavy PVC Reinforced Toe)', 5),
(10756, 2051, 'Underfoot Midsole', 'None', 6),
(10757, 2051, 'Slip Resistance', 'Deep Cleat Tractor Tread', 7),
(10758, 2051, 'Shaft Height', '36.0 cm', 8),
(10759, 2051, 'Unit Weight', '1450 g / pair', 9),
(10760, 2051, 'Available Sizing', 'EU 38 - 43', 10),
(10761, 2051, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 18.0 kg)', 11),
(10762, 2051, 'Wholesale FOB Reference', '$5.09 / pair (Rp 118,050 Factory List)', 12),
(10763, 2051, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10764, 2051, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10765, 2051, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10766, 2052, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10767, 2052, 'Key Spec', 'Special Edition PVC • Deep Cleat Tractor Tread • EU 37 - 42', 2),
(10768, 2052, 'Upper Material', 'Special Edition PVC', 3),
(10769, 2052, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10770, 2052, 'Toe Protection', 'None (Heavy PVC Reinforced Toe)', 5),
(10771, 2052, 'Underfoot Midsole', 'None', 6),
(10772, 2052, 'Slip Resistance', 'Deep Cleat Tractor Tread', 7),
(10773, 2052, 'Shaft Height', '36.0 cm', 8),
(10774, 2052, 'Unit Weight', '1450 g / pair', 9),
(10775, 2052, 'Available Sizing', 'EU 37 - 42', 10),
(10776, 2052, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 18.0 kg)', 11),
(10777, 2052, 'Wholesale FOB Reference', '$3.88 / pair (Rp 90,175 Factory List)', 12),
(10778, 2052, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10779, 2052, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10780, 2052, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10781, 2053, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10782, 2053, 'Key Spec', 'Solid Waterproof PVC • Deep Cleat Tractor Tread • EU 38 - 43', 2),
(10783, 2053, 'Upper Material', 'Solid Waterproof PVC', 3),
(10784, 2053, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10785, 2053, 'Toe Protection', 'None (Heavy PVC Reinforced Toe)', 5),
(10786, 2053, 'Underfoot Midsole', 'None', 6),
(10787, 2053, 'Slip Resistance', 'Deep Cleat Tractor Tread', 7),
(10788, 2053, 'Shaft Height', '36.0 cm', 8),
(10789, 2053, 'Unit Weight', '1450 g / pair', 9),
(10790, 2053, 'Available Sizing', 'EU 38 - 43', 10),
(10791, 2053, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 18.0 kg)', 11),
(10792, 2053, 'Wholesale FOB Reference', '$3.06 / pair (Rp 71,050 Factory List)', 12),
(10793, 2053, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10794, 2053, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10795, 2053, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10796, 2054, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10797, 2054, 'Key Spec', 'Tricolour Injection PVC • Deep Cleat Tractor Tread • EU 38 - 43', 2),
(10798, 2054, 'Upper Material', 'Tricolour Injection PVC', 3),
(10799, 2054, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10800, 2054, 'Toe Protection', 'None (Heavy PVC Reinforced Toe)', 5),
(10801, 2054, 'Underfoot Midsole', 'None', 6),
(10802, 2054, 'Slip Resistance', 'Deep Cleat Tractor Tread', 7),
(10803, 2054, 'Shaft Height', '36.0 cm', 8),
(10804, 2054, 'Unit Weight', '1450 g / pair', 9),
(10805, 2054, 'Available Sizing', 'EU 38 - 43', 10),
(10806, 2054, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 18.0 kg)', 11),
(10807, 2054, 'Wholesale FOB Reference', '$6.40 / pair (Rp 148,499 Factory List)', 12),
(10808, 2054, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10809, 2054, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10810, 2054, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10811, 2055, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10812, 2055, 'Key Spec', 'Modern Soft PVC • Deep Cleat Tractor Tread • EU 38 - 43', 2),
(10813, 2055, 'Upper Material', 'Modern Soft PVC', 3),
(10814, 2055, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10815, 2055, 'Toe Protection', 'None (Heavy PVC Reinforced Toe)', 5),
(10816, 2055, 'Underfoot Midsole', 'None', 6),
(10817, 2055, 'Slip Resistance', 'Deep Cleat Tractor Tread', 7),
(10818, 2055, 'Shaft Height', '36.0 cm', 8),
(10819, 2055, 'Unit Weight', '1450 g / pair', 9),
(10820, 2055, 'Available Sizing', 'EU 38 - 43', 10),
(10821, 2055, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 18.0 kg)', 11),
(10822, 2055, 'Wholesale FOB Reference', '$5.06 / pair (Rp 117,383 Factory List)', 12),
(10823, 2055, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10824, 2055, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10825, 2055, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10826, 2056, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10827, 2056, 'Key Spec', 'Food Grade PVC • Herringbone Siped Rubber Sole • EU 38 - 43', 2),
(10828, 2056, 'Upper Material', 'Food Grade PVC', 3),
(10829, 2056, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10830, 2056, 'Toe Protection', 'Vulcanized Style Cap', 5),
(10831, 2056, 'Underfoot Midsole', 'Cushioned Insole', 6),
(10832, 2056, 'Slip Resistance', 'Herringbone Siped Rubber Sole', 7),
(10833, 2056, 'Shaft Height', '9.0 cm', 8),
(10834, 2056, 'Unit Weight', '680 g / pair', 9),
(10835, 2056, 'Available Sizing', 'EU 38 - 43', 10),
(10836, 2056, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 11.5 kg)', 11),
(10837, 2056, 'Wholesale FOB Reference', '$1.91 / pair (Rp 44,433 Factory List)', 12),
(10838, 2056, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10839, 2056, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10840, 2056, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10841, 2057, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10842, 2057, 'Key Spec', 'Heavy Elastic PVC • Deep Cleat Tractor Tread • EU 38 - 43', 2),
(10843, 2057, 'Upper Material', 'Heavy Elastic PVC', 3),
(10844, 2057, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10845, 2057, 'Toe Protection', 'None (Heavy PVC Reinforced Toe)', 5),
(10846, 2057, 'Underfoot Midsole', 'None', 6),
(10847, 2057, 'Slip Resistance', 'Deep Cleat Tractor Tread', 7),
(10848, 2057, 'Shaft Height', '36.0 cm', 8),
(10849, 2057, 'Unit Weight', '1450 g / pair', 9),
(10850, 2057, 'Available Sizing', 'EU 38 - 43', 10),
(10851, 2057, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 18.0 kg)', 11),
(10852, 2057, 'Wholesale FOB Reference', '$6.24 / pair (Rp 144,900 Factory List)', 12),
(10853, 2057, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10854, 2057, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10855, 2057, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10856, 2058, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10857, 2058, 'Key Spec', 'Compact PVC • Deep Cleat Tractor Tread • EU 38 - 43', 2),
(10858, 2058, 'Upper Material', 'Compact PVC', 3),
(10859, 2058, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10860, 2058, 'Toe Protection', 'None (Heavy PVC Reinforced Toe)', 5),
(10861, 2058, 'Underfoot Midsole', 'None', 6),
(10862, 2058, 'Slip Resistance', 'Deep Cleat Tractor Tread', 7),
(10863, 2058, 'Shaft Height', '36.0 cm', 8),
(10864, 2058, 'Unit Weight', '1450 g / pair', 9),
(10865, 2058, 'Available Sizing', 'EU 38 - 43', 10),
(10866, 2058, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 18.0 kg)', 11),
(10867, 2058, 'Wholesale FOB Reference', '$6.37 / pair (Rp 147,845 Factory List)', 12),
(10868, 2058, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10869, 2058, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10870, 2058, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10871, 2059, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10872, 2059, 'Key Spec', 'Higienis PVC • Herringbone Siped Rubber Sole • EU 38 - 43', 2),
(10873, 2059, 'Upper Material', 'Higienis PVC', 3),
(10874, 2059, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10875, 2059, 'Toe Protection', 'Vulcanized Style Cap', 5),
(10876, 2059, 'Underfoot Midsole', 'Cushioned Insole', 6),
(10877, 2059, 'Slip Resistance', 'Herringbone Siped Rubber Sole', 7),
(10878, 2059, 'Shaft Height', '9.0 cm', 8),
(10879, 2059, 'Unit Weight', '680 g / pair', 9),
(10880, 2059, 'Available Sizing', 'EU 38 - 43', 10),
(10881, 2059, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 11.5 kg)', 11),
(10882, 2059, 'Wholesale FOB Reference', '$1.64 / pair (Rp 38,125 Factory List)', 12),
(10883, 2059, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10884, 2059, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10885, 2059, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10886, 2060, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10887, 2060, 'Key Spec', 'Thick Wall PVC • Deep Cleat Tractor Tread • EU 38 - 44', 2),
(10888, 2060, 'Upper Material', 'Thick Wall PVC', 3),
(10889, 2060, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10890, 2060, 'Toe Protection', 'None (Heavy PVC Reinforced Toe)', 5),
(10891, 2060, 'Underfoot Midsole', 'None', 6),
(10892, 2060, 'Slip Resistance', 'Deep Cleat Tractor Tread', 7),
(10893, 2060, 'Shaft Height', '36.0 cm', 8),
(10894, 2060, 'Unit Weight', '1450 g / pair', 9),
(10895, 2060, 'Available Sizing', 'EU 38 - 44', 10),
(10896, 2060, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 18.0 kg)', 11),
(10897, 2060, 'Wholesale FOB Reference', '$3.66 / pair (Rp 85,000 Factory List)', 12),
(10898, 2060, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10899, 2060, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10900, 2060, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10901, 2061, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10902, 2061, 'Key Spec', 'Food Safe PVC Compound • Deep Cleat Tractor Tread • EU 38 - 43', 2),
(10903, 2061, 'Upper Material', 'Food Safe PVC Compound', 3),
(10904, 2061, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10905, 2061, 'Toe Protection', 'None (Heavy PVC Reinforced Toe)', 5),
(10906, 2061, 'Underfoot Midsole', 'None', 6),
(10907, 2061, 'Slip Resistance', 'Deep Cleat Tractor Tread', 7),
(10908, 2061, 'Shaft Height', '36.0 cm', 8),
(10909, 2061, 'Unit Weight', '1450 g / pair', 9),
(10910, 2061, 'Available Sizing', 'EU 38 - 43', 10),
(10911, 2061, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 18.0 kg)', 11),
(10912, 2061, 'Wholesale FOB Reference', '$3.66 / pair (Rp 85,000 Factory List)', 12),
(10913, 2061, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10914, 2061, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10915, 2061, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10916, 2062, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10917, 2062, 'Key Spec', 'Lightweight PVC • Deep Cleat Tractor Tread • EU 38 - 43', 2),
(10918, 2062, 'Upper Material', 'Lightweight PVC', 3),
(10919, 2062, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10920, 2062, 'Toe Protection', 'None (Heavy PVC Reinforced Toe)', 5),
(10921, 2062, 'Underfoot Midsole', 'None', 6),
(10922, 2062, 'Slip Resistance', 'Deep Cleat Tractor Tread', 7),
(10923, 2062, 'Shaft Height', '36.0 cm', 8),
(10924, 2062, 'Unit Weight', '1450 g / pair', 9),
(10925, 2062, 'Available Sizing', 'EU 38 - 43', 10),
(10926, 2062, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 18.0 kg)', 11),
(10927, 2062, 'Wholesale FOB Reference', '$5.67 / pair (Rp 131,550 Factory List)', 12),
(10928, 2062, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10929, 2062, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10930, 2062, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10931, 2063, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10932, 2063, 'Key Spec', 'Rugged Sole PVC • Herringbone Siped Rubber Sole • EU 38 - 43', 2),
(10933, 2063, 'Upper Material', 'Rugged Sole PVC', 3),
(10934, 2063, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10935, 2063, 'Toe Protection', 'Vulcanized Style Cap', 5),
(10936, 2063, 'Underfoot Midsole', 'Cushioned Insole', 6),
(10937, 2063, 'Slip Resistance', 'Herringbone Siped Rubber Sole', 7),
(10938, 2063, 'Shaft Height', '8.0 cm', 8),
(10939, 2063, 'Unit Weight', '620 g / pair', 9),
(10940, 2063, 'Available Sizing', 'EU 38 - 43', 10),
(10941, 2063, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 11.5 kg)', 11),
(10942, 2063, 'Wholesale FOB Reference', '$2.43 / pair (Rp 56,525 Factory List)', 12),
(10943, 2063, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10944, 2063, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10945, 2063, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10946, 2064, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10947, 2064, 'Key Spec', 'Durable Rubberized PVC • Deep Cleat Tractor Tread • EU 38 - 43', 2),
(10948, 2064, 'Upper Material', 'Durable Rubberized PVC', 3),
(10949, 2064, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10950, 2064, 'Toe Protection', 'None (Heavy PVC Reinforced Toe)', 5),
(10951, 2064, 'Underfoot Midsole', 'None', 6),
(10952, 2064, 'Slip Resistance', 'Deep Cleat Tractor Tread', 7),
(10953, 2064, 'Shaft Height', '36.0 cm', 8),
(10954, 2064, 'Unit Weight', '1450 g / pair', 9),
(10955, 2064, 'Available Sizing', 'EU 38 - 43', 10),
(10956, 2064, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 18.0 kg)', 11),
(10957, 2064, 'Wholesale FOB Reference', '$3.88 / pair (Rp 90,175 Factory List)', 12),
(10958, 2064, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10959, 2064, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10960, 2064, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10961, 2065, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10962, 2065, 'Key Spec', 'Ultraflex Polymer PVC • Deep Cleat Tractor Tread • EU 38 - 43', 2),
(10963, 2065, 'Upper Material', 'Ultraflex Polymer PVC', 3),
(10964, 2065, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10965, 2065, 'Toe Protection', 'None (Heavy PVC Reinforced Toe)', 5),
(10966, 2065, 'Underfoot Midsole', 'None', 6),
(10967, 2065, 'Slip Resistance', 'Deep Cleat Tractor Tread', 7),
(10968, 2065, 'Shaft Height', '36.0 cm', 8),
(10969, 2065, 'Unit Weight', '1450 g / pair', 9),
(10970, 2065, 'Available Sizing', 'EU 38 - 43', 10),
(10971, 2065, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 18.0 kg)', 11),
(10972, 2065, 'Wholesale FOB Reference', '$8.08 / pair (Rp 187,566 Factory List)', 12),
(10973, 2065, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10974, 2065, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10975, 2065, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10976, 2066, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10977, 2066, 'Key Spec', 'Solid Work PVC • Deep Cleat Tractor Tread • EU 38 - 44', 2),
(10978, 2066, 'Upper Material', 'Solid Work PVC', 3),
(10979, 2066, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10980, 2066, 'Toe Protection', 'None (Heavy PVC Reinforced Toe)', 5),
(10981, 2066, 'Underfoot Midsole', 'None', 6),
(10982, 2066, 'Slip Resistance', 'Deep Cleat Tractor Tread', 7),
(10983, 2066, 'Shaft Height', '36.0 cm', 8),
(10984, 2066, 'Unit Weight', '1450 g / pair', 9),
(10985, 2066, 'Available Sizing', 'EU 38 - 44', 10),
(10986, 2066, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 18.0 kg)', 11),
(10987, 2066, 'Wholesale FOB Reference', '$3.66 / pair (Rp 85,000 Factory List)', 12),
(10988, 2066, 'Container 20ft Capacity', '3,600 Pairs', 13),
(10989, 2066, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(10990, 2066, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(10991, 2067, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(10992, 2067, 'Key Spec', 'Seamless Molded PVC • Deep Cleat Tractor Tread • EU 38 - 43', 2),
(10993, 2067, 'Upper Material', 'Seamless Molded PVC', 3),
(10994, 2067, 'Outsole', 'Molded PVC Cleated Sole', 4),
(10995, 2067, 'Toe Protection', 'None (Heavy PVC Reinforced Toe)', 5),
(10996, 2067, 'Underfoot Midsole', 'None', 6),
(10997, 2067, 'Slip Resistance', 'Deep Cleat Tractor Tread', 7),
(10998, 2067, 'Shaft Height', '36.0 cm', 8),
(10999, 2067, 'Unit Weight', '1450 g / pair', 9),
(11000, 2067, 'Available Sizing', 'EU 38 - 43', 10);

INSERT INTO `product_specifications` (`id`, `product_id`, `spec_label`, `spec_value`, `display_order`) VALUES
(11001, 2067, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 18.0 kg)', 11),
(11002, 2067, 'Wholesale FOB Reference', '$5.00 / pair (Rp 116,066 Factory List)', 12),
(11003, 2067, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11004, 2067, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11005, 2067, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11006, 2068, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11007, 2068, 'Key Spec', 'Sanitized PVC • Herringbone Siped Rubber Sole • EU 38 - 43', 2),
(11008, 2068, 'Upper Material', 'Sanitized PVC', 3),
(11009, 2068, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11010, 2068, 'Toe Protection', 'Vulcanized Style Cap', 5),
(11011, 2068, 'Underfoot Midsole', 'Cushioned Insole', 6),
(11012, 2068, 'Slip Resistance', 'Herringbone Siped Rubber Sole', 7),
(11013, 2068, 'Shaft Height', '9.0 cm', 8),
(11014, 2068, 'Unit Weight', '680 g / pair', 9),
(11015, 2068, 'Available Sizing', 'EU 38 - 43', 10),
(11016, 2068, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 11.5 kg)', 11),
(11017, 2068, 'Wholesale FOB Reference', '$1.66 / pair (Rp 38,500 Factory List)', 12),
(11018, 2068, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11019, 2068, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11020, 2068, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11021, 2069, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11022, 2069, 'Key Spec', 'Standard Utility PVC • Herringbone Siped Rubber Sole • EU 38 - 43', 2),
(11023, 2069, 'Upper Material', 'Standard Utility PVC', 3),
(11024, 2069, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11025, 2069, 'Toe Protection', 'Vulcanized Style Cap', 5),
(11026, 2069, 'Underfoot Midsole', 'Cushioned Insole', 6),
(11027, 2069, 'Slip Resistance', 'Herringbone Siped Rubber Sole', 7),
(11028, 2069, 'Shaft Height', '9.0 cm', 8),
(11029, 2069, 'Unit Weight', '680 g / pair', 9),
(11030, 2069, 'Available Sizing', 'EU 38 - 43', 10),
(11031, 2069, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 11.5 kg)', 11),
(11032, 2069, 'Wholesale FOB Reference', '$1.72 / pair (Rp 39,900 Factory List)', 12),
(11033, 2069, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11034, 2069, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11035, 2069, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11036, 2070, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11037, 2070, 'Key Spec', 'Dual Density PVC • Deep Cleat Tractor Tread • EU 38 - 43', 2),
(11038, 2070, 'Upper Material', 'Dual Density PVC', 3),
(11039, 2070, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11040, 2070, 'Toe Protection', 'None (Heavy PVC Reinforced Toe)', 5),
(11041, 2070, 'Underfoot Midsole', 'None', 6),
(11042, 2070, 'Slip Resistance', 'Deep Cleat Tractor Tread', 7),
(11043, 2070, 'Shaft Height', '36.0 cm', 8),
(11044, 2070, 'Unit Weight', '1450 g / pair', 9),
(11045, 2070, 'Available Sizing', 'EU 38 - 43', 10),
(11046, 2070, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 18.0 kg)', 11),
(11047, 2070, 'Wholesale FOB Reference', '$7.02 / pair (Rp 162,999 Factory List)', 12),
(11048, 2070, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11049, 2070, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11050, 2070, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11051, 2071, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11052, 2071, 'Key Spec', 'Dual Density PVC • Deep Cleat Tractor Tread • EU 38 - 43', 2),
(11053, 2071, 'Upper Material', 'Dual Density PVC', 3),
(11054, 2071, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11055, 2071, 'Toe Protection', 'None (Heavy PVC Reinforced Toe)', 5),
(11056, 2071, 'Underfoot Midsole', 'None', 6),
(11057, 2071, 'Slip Resistance', 'Deep Cleat Tractor Tread', 7),
(11058, 2071, 'Shaft Height', '36.0 cm', 8),
(11059, 2071, 'Unit Weight', '1450 g / pair', 9),
(11060, 2071, 'Available Sizing', 'EU 38 - 43', 10),
(11061, 2071, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 18.0 kg)', 11),
(11062, 2071, 'Wholesale FOB Reference', '$7.29 / pair (Rp 169,133 Factory List)', 12),
(11063, 2071, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11064, 2071, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11065, 2071, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11066, 2072, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11067, 2072, 'Key Spec', 'Dual Density PVC • Deep Cleat Tractor Tread • EU 38 - 43', 2),
(11068, 2072, 'Upper Material', 'Dual Density PVC', 3),
(11069, 2072, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11070, 2072, 'Toe Protection', 'None (Heavy PVC Reinforced Toe)', 5),
(11071, 2072, 'Underfoot Midsole', 'None', 6),
(11072, 2072, 'Slip Resistance', 'Deep Cleat Tractor Tread', 7),
(11073, 2072, 'Shaft Height', '36.0 cm', 8),
(11074, 2072, 'Unit Weight', '1450 g / pair', 9),
(11075, 2072, 'Available Sizing', 'EU 38 - 43', 10),
(11076, 2072, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 18.0 kg)', 11),
(11077, 2072, 'Wholesale FOB Reference', '$7.29 / pair (Rp 169,133 Factory List)', 12),
(11078, 2072, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11079, 2072, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11080, 2072, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11081, 2073, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11082, 2073, 'Key Spec', 'Dual Density PVC • Deep Cleat Tractor Tread • EU 38 - 43', 2),
(11083, 2073, 'Upper Material', 'Dual Density PVC', 3),
(11084, 2073, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11085, 2073, 'Toe Protection', 'None (Heavy PVC Reinforced Toe)', 5),
(11086, 2073, 'Underfoot Midsole', 'None', 6),
(11087, 2073, 'Slip Resistance', 'Deep Cleat Tractor Tread', 7),
(11088, 2073, 'Shaft Height', '36.0 cm', 8),
(11089, 2073, 'Unit Weight', '1450 g / pair', 9),
(11090, 2073, 'Available Sizing', 'EU 38 - 43', 10),
(11091, 2073, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 18.0 kg)', 11),
(11092, 2073, 'Wholesale FOB Reference', '$7.29 / pair (Rp 169,133 Factory List)', 12),
(11093, 2073, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11094, 2073, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11095, 2073, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11096, 2074, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11097, 2074, 'Key Spec', 'Ultraflex Rubber-PVC • Deep Cleat Tractor Tread • EU 38 - 43', 2),
(11098, 2074, 'Upper Material', 'Ultraflex Rubber-PVC', 3),
(11099, 2074, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11100, 2074, 'Toe Protection', 'None (Heavy PVC Reinforced Toe)', 5),
(11101, 2074, 'Underfoot Midsole', 'None', 6),
(11102, 2074, 'Slip Resistance', 'Deep Cleat Tractor Tread', 7),
(11103, 2074, 'Shaft Height', '36.0 cm', 8),
(11104, 2074, 'Unit Weight', '1450 g / pair', 9),
(11105, 2074, 'Available Sizing', 'EU 38 - 43', 10),
(11106, 2074, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 18.0 kg)', 11),
(11107, 2074, 'Wholesale FOB Reference', '$8.08 / pair (Rp 187,566 Factory List)', 12),
(11108, 2074, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11109, 2074, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11110, 2074, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11111, 2075, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11112, 2075, 'Key Spec', 'Ultraflex Rubber-PVC • Deep Cleat Tractor Tread • EU 38 - 43', 2),
(11113, 2075, 'Upper Material', 'Ultraflex Rubber-PVC', 3),
(11114, 2075, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11115, 2075, 'Toe Protection', 'None (Heavy PVC Reinforced Toe)', 5),
(11116, 2075, 'Underfoot Midsole', 'None', 6),
(11117, 2075, 'Slip Resistance', 'Deep Cleat Tractor Tread', 7),
(11118, 2075, 'Shaft Height', '36.0 cm', 8),
(11119, 2075, 'Unit Weight', '1450 g / pair', 9),
(11120, 2075, 'Available Sizing', 'EU 38 - 43', 10),
(11121, 2075, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 18.0 kg)', 11),
(11122, 2075, 'Wholesale FOB Reference', '$8.08 / pair (Rp 187,566 Factory List)', 12),
(11123, 2075, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11124, 2075, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11125, 2075, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11126, 2076, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11127, 2076, 'Key Spec', 'Traditional Heavy PVC • Deep Cleat Tractor Tread • EU 38 - 43', 2),
(11128, 2076, 'Upper Material', 'Traditional Heavy PVC', 3),
(11129, 2076, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11130, 2076, 'Toe Protection', 'None (Heavy PVC Reinforced Toe)', 5),
(11131, 2076, 'Underfoot Midsole', 'None', 6),
(11132, 2076, 'Slip Resistance', 'Deep Cleat Tractor Tread', 7),
(11133, 2076, 'Shaft Height', '36.0 cm', 8),
(11134, 2076, 'Unit Weight', '1450 g / pair', 9),
(11135, 2076, 'Available Sizing', 'EU 38 - 43', 10),
(11136, 2076, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 18.0 kg)', 11),
(11137, 2076, 'Wholesale FOB Reference', '$4.25 / pair (Rp 98,766 Factory List)', 12),
(11138, 2076, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11139, 2076, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11140, 2076, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11141, 2077, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11142, 2077, 'Key Spec', 'Traditional Heavy PVC • Deep Cleat Tractor Tread • EU 38 - 43', 2),
(11143, 2077, 'Upper Material', 'Traditional Heavy PVC', 3),
(11144, 2077, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11145, 2077, 'Toe Protection', 'None (Heavy PVC Reinforced Toe)', 5),
(11146, 2077, 'Underfoot Midsole', 'None', 6),
(11147, 2077, 'Slip Resistance', 'Deep Cleat Tractor Tread', 7),
(11148, 2077, 'Shaft Height', '36.0 cm', 8),
(11149, 2077, 'Unit Weight', '1450 g / pair', 9),
(11150, 2077, 'Available Sizing', 'EU 38 - 43', 10),
(11151, 2077, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 18.0 kg)', 11),
(11152, 2077, 'Wholesale FOB Reference', '$7.09 / pair (Rp 164,666 Factory List)', 12),
(11153, 2077, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11154, 2077, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11155, 2077, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11156, 2078, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11157, 2078, 'Key Spec', 'Non-Toxic Flexible PVC • Wave Texture Non-Marking Sole • EU 28 - 35', 2),
(11158, 2078, 'Upper Material', 'Non-Toxic Flexible PVC', 3),
(11159, 2078, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11160, 2078, 'Toe Protection', 'Soft Flexible Rounded Toe (Phthalate Free)', 5),
(11161, 2078, 'Underfoot Midsole', 'None', 6),
(11162, 2078, 'Slip Resistance', 'Wave Texture Non-Marking Sole', 7),
(11163, 2078, 'Shaft Height', '20.0 cm', 8),
(11164, 2078, 'Unit Weight', '520 g / pair', 9),
(11165, 2078, 'Available Sizing', 'EU 28 - 35', 10),
(11166, 2078, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 8.5 kg)', 11),
(11167, 2078, 'Wholesale FOB Reference', '$2.95 / pair (Rp 68,566 Factory List)', 12),
(11168, 2078, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11169, 2078, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11170, 2078, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11171, 2079, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11172, 2079, 'Key Spec', 'Non-Toxic Flexible PVC • Wave Texture Non-Marking Sole • EU 28 - 35', 2),
(11173, 2079, 'Upper Material', 'Non-Toxic Flexible PVC', 3),
(11174, 2079, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11175, 2079, 'Toe Protection', 'Soft Flexible Rounded Toe (Phthalate Free)', 5),
(11176, 2079, 'Underfoot Midsole', 'None', 6),
(11177, 2079, 'Slip Resistance', 'Wave Texture Non-Marking Sole', 7),
(11178, 2079, 'Shaft Height', '20.0 cm', 8),
(11179, 2079, 'Unit Weight', '520 g / pair', 9),
(11180, 2079, 'Available Sizing', 'EU 28 - 35', 10),
(11181, 2079, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 8.5 kg)', 11),
(11182, 2079, 'Wholesale FOB Reference', '$2.95 / pair (Rp 68,566 Factory List)', 12),
(11183, 2079, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11184, 2079, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11185, 2079, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11186, 2080, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11187, 2080, 'Key Spec', 'Non-Toxic Flexible PVC • Wave Texture Non-Marking Sole • EU 28 - 35', 2),
(11188, 2080, 'Upper Material', 'Non-Toxic Flexible PVC', 3),
(11189, 2080, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11190, 2080, 'Toe Protection', 'Soft Flexible Rounded Toe (Phthalate Free)', 5),
(11191, 2080, 'Underfoot Midsole', 'None', 6),
(11192, 2080, 'Slip Resistance', 'Wave Texture Non-Marking Sole', 7),
(11193, 2080, 'Shaft Height', '20.0 cm', 8),
(11194, 2080, 'Unit Weight', '520 g / pair', 9),
(11195, 2080, 'Available Sizing', 'EU 28 - 35', 10),
(11196, 2080, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 8.5 kg)', 11),
(11197, 2080, 'Wholesale FOB Reference', '$2.95 / pair (Rp 68,566 Factory List)', 12),
(11198, 2080, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11199, 2080, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11200, 2080, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11201, 2081, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11202, 2081, 'Key Spec', 'Printed Safe PVC • Wave Texture Non-Marking Sole • EU 26 - 32', 2),
(11203, 2081, 'Upper Material', 'Printed Safe PVC', 3),
(11204, 2081, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11205, 2081, 'Toe Protection', 'Soft Flexible Rounded Toe (Phthalate Free)', 5),
(11206, 2081, 'Underfoot Midsole', 'None', 6),
(11207, 2081, 'Slip Resistance', 'Wave Texture Non-Marking Sole', 7),
(11208, 2081, 'Shaft Height', '20.0 cm', 8),
(11209, 2081, 'Unit Weight', '520 g / pair', 9),
(11210, 2081, 'Available Sizing', 'EU 26 - 32', 10),
(11211, 2081, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 8.5 kg)', 11),
(11212, 2081, 'Wholesale FOB Reference', '$2.57 / pair (Rp 59,566 Factory List)', 12),
(11213, 2081, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11214, 2081, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11215, 2081, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11216, 2082, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11217, 2082, 'Key Spec', 'Printed Safe PVC • Wave Texture Non-Marking Sole • EU 26 - 32', 2),
(11218, 2082, 'Upper Material', 'Printed Safe PVC', 3),
(11219, 2082, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11220, 2082, 'Toe Protection', 'Soft Flexible Rounded Toe (Phthalate Free)', 5),
(11221, 2082, 'Underfoot Midsole', 'None', 6),
(11222, 2082, 'Slip Resistance', 'Wave Texture Non-Marking Sole', 7),
(11223, 2082, 'Shaft Height', '20.0 cm', 8),
(11224, 2082, 'Unit Weight', '520 g / pair', 9),
(11225, 2082, 'Available Sizing', 'EU 26 - 32', 10),
(11226, 2082, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 8.5 kg)', 11),
(11227, 2082, 'Wholesale FOB Reference', '$2.57 / pair (Rp 59,566 Factory List)', 12),
(11228, 2082, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11229, 2082, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11230, 2082, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11231, 2083, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11232, 2083, 'Key Spec', 'Printed Safe PVC • Wave Texture Non-Marking Sole • EU 26 - 32', 2),
(11233, 2083, 'Upper Material', 'Printed Safe PVC', 3),
(11234, 2083, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11235, 2083, 'Toe Protection', 'Soft Flexible Rounded Toe (Phthalate Free)', 5),
(11236, 2083, 'Underfoot Midsole', 'None', 6),
(11237, 2083, 'Slip Resistance', 'Wave Texture Non-Marking Sole', 7),
(11238, 2083, 'Shaft Height', '20.0 cm', 8),
(11239, 2083, 'Unit Weight', '520 g / pair', 9),
(11240, 2083, 'Available Sizing', 'EU 26 - 32', 10),
(11241, 2083, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 8.5 kg)', 11),
(11242, 2083, 'Wholesale FOB Reference', '$2.57 / pair (Rp 59,566 Factory List)', 12),
(11243, 2083, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11244, 2083, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11245, 2083, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11246, 2084, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11247, 2084, 'Key Spec', 'Printed PVC Bebas Timbal • Wave Texture Non-Marking Sole • EU 27 - 34', 2),
(11248, 2084, 'Upper Material', 'Printed PVC Bebas Timbal', 3),
(11249, 2084, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11250, 2084, 'Toe Protection', 'Soft Flexible Rounded Toe (Phthalate Free)', 5);

INSERT INTO `product_specifications` (`id`, `product_id`, `spec_label`, `spec_value`, `display_order`) VALUES
(11251, 2084, 'Underfoot Midsole', 'None', 6),
(11252, 2084, 'Slip Resistance', 'Wave Texture Non-Marking Sole', 7),
(11253, 2084, 'Shaft Height', '20.0 cm', 8),
(11254, 2084, 'Unit Weight', '520 g / pair', 9),
(11255, 2084, 'Available Sizing', 'EU 27 - 34', 10),
(11256, 2084, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 8.5 kg)', 11),
(11257, 2084, 'Wholesale FOB Reference', '$2.82 / pair (Rp 65,425 Factory List)', 12),
(11258, 2084, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11259, 2084, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11260, 2084, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11261, 2085, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11262, 2085, 'Key Spec', 'Dual Tone PVC • Wave Texture Non-Marking Sole • EU 28 - 35', 2),
(11263, 2085, 'Upper Material', 'Dual Tone PVC', 3),
(11264, 2085, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11265, 2085, 'Toe Protection', 'Soft Flexible Rounded Toe (Phthalate Free)', 5),
(11266, 2085, 'Underfoot Midsole', 'None', 6),
(11267, 2085, 'Slip Resistance', 'Wave Texture Non-Marking Sole', 7),
(11268, 2085, 'Shaft Height', '20.0 cm', 8),
(11269, 2085, 'Unit Weight', '520 g / pair', 9),
(11270, 2085, 'Available Sizing', 'EU 28 - 35', 10),
(11271, 2085, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 8.5 kg)', 11),
(11272, 2085, 'Wholesale FOB Reference', '$2.95 / pair (Rp 68,566 Factory List)', 12),
(11273, 2085, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11274, 2085, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11275, 2085, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11276, 2086, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11277, 2086, 'Key Spec', 'Texture Look PVC • Wave Texture Non-Marking Sole • EU 28 - 35', 2),
(11278, 2086, 'Upper Material', 'Texture Look PVC', 3),
(11279, 2086, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11280, 2086, 'Toe Protection', 'Soft Flexible Rounded Toe (Phthalate Free)', 5),
(11281, 2086, 'Underfoot Midsole', 'None', 6),
(11282, 2086, 'Slip Resistance', 'Wave Texture Non-Marking Sole', 7),
(11283, 2086, 'Shaft Height', '20.0 cm', 8),
(11284, 2086, 'Unit Weight', '520 g / pair', 9),
(11285, 2086, 'Available Sizing', 'EU 28 - 35', 10),
(11286, 2086, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 8.5 kg)', 11),
(11287, 2086, 'Wholesale FOB Reference', '$2.95 / pair (Rp 68,566 Factory List)', 12),
(11288, 2086, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11289, 2086, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11290, 2086, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11291, 2087, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11292, 2087, 'Key Spec', 'Printed Fun PVC • Wave Texture Non-Marking Sole • EU 28 - 35', 2),
(11293, 2087, 'Upper Material', 'Printed Fun PVC', 3),
(11294, 2087, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11295, 2087, 'Toe Protection', 'Soft Flexible Rounded Toe (Phthalate Free)', 5),
(11296, 2087, 'Underfoot Midsole', 'None', 6),
(11297, 2087, 'Slip Resistance', 'Wave Texture Non-Marking Sole', 7),
(11298, 2087, 'Shaft Height', '20.0 cm', 8),
(11299, 2087, 'Unit Weight', '520 g / pair', 9),
(11300, 2087, 'Available Sizing', 'EU 28 - 35', 10),
(11301, 2087, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 8.5 kg)', 11),
(11302, 2087, 'Wholesale FOB Reference', '$2.67 / pair (Rp 61,900 Factory List)', 12),
(11303, 2087, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11304, 2087, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11305, 2087, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11306, 2088, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11307, 2088, 'Key Spec', 'Printed Striped PVC • Wave Texture Non-Marking Sole • EU 28 - 35', 2),
(11308, 2088, 'Upper Material', 'Printed Striped PVC', 3),
(11309, 2088, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11310, 2088, 'Toe Protection', 'Soft Flexible Rounded Toe (Phthalate Free)', 5),
(11311, 2088, 'Underfoot Midsole', 'None', 6),
(11312, 2088, 'Slip Resistance', 'Wave Texture Non-Marking Sole', 7),
(11313, 2088, 'Shaft Height', '20.0 cm', 8),
(11314, 2088, 'Unit Weight', '520 g / pair', 9),
(11315, 2088, 'Available Sizing', 'EU 28 - 35', 10),
(11316, 2088, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 8.5 kg)', 11),
(11317, 2088, 'Wholesale FOB Reference', '$2.95 / pair (Rp 68,566 Factory List)', 12),
(11318, 2088, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11319, 2088, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11320, 2088, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11321, 2089, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11322, 2089, 'Key Spec', 'Multi Tone PVC • Wave Texture Non-Marking Sole • EU 28 - 35', 2),
(11323, 2089, 'Upper Material', 'Multi Tone PVC', 3),
(11324, 2089, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11325, 2089, 'Toe Protection', 'Soft Flexible Rounded Toe (Phthalate Free)', 5),
(11326, 2089, 'Underfoot Midsole', 'None', 6),
(11327, 2089, 'Slip Resistance', 'Wave Texture Non-Marking Sole', 7),
(11328, 2089, 'Shaft Height', '20.0 cm', 8),
(11329, 2089, 'Unit Weight', '520 g / pair', 9),
(11330, 2089, 'Available Sizing', 'EU 28 - 35', 10),
(11331, 2089, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 8.5 kg)', 11),
(11332, 2089, 'Wholesale FOB Reference', '$2.95 / pair (Rp 68,566 Factory List)', 12),
(11333, 2089, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11334, 2089, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11335, 2089, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11336, 2090, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11337, 2090, 'Key Spec', 'Classic Kids PVC • Wave Texture Non-Marking Sole • EU 26 - 33', 2),
(11338, 2090, 'Upper Material', 'Classic Kids PVC', 3),
(11339, 2090, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11340, 2090, 'Toe Protection', 'Soft Flexible Rounded Toe (Phthalate Free)', 5),
(11341, 2090, 'Underfoot Midsole', 'None', 6),
(11342, 2090, 'Slip Resistance', 'Wave Texture Non-Marking Sole', 7),
(11343, 2090, 'Shaft Height', '20.0 cm', 8),
(11344, 2090, 'Unit Weight', '620 g / pair', 9),
(11345, 2090, 'Available Sizing', 'EU 26 - 33', 10),
(11346, 2090, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 8.5 kg)', 11),
(11347, 2090, 'Wholesale FOB Reference', '$3.14 / pair (Rp 72,825 Factory List)', 12),
(11348, 2090, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11349, 2090, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11350, 2090, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11351, 2091, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11352, 2091, 'Key Spec', 'Soft Foam Injected PVC • Flat Anti-Slip Suction Sipes • EU 36 - 40', 2),
(11353, 2091, 'Upper Material', 'Soft Foam Injected PVC', 3),
(11354, 2091, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11355, 2091, 'Toe Protection', 'None', 5),
(11356, 2091, 'Underfoot Midsole', 'Ergonomic Textured Footbed', 6),
(11357, 2091, 'Slip Resistance', 'Flat Anti-Slip Suction Sipes', 7),
(11358, 2091, 'Shaft Height', '6.5 cm', 8),
(11359, 2091, 'Unit Weight', '360 g / pair', 9),
(11360, 2091, 'Available Sizing', 'EU 36 - 40', 10),
(11361, 2091, 'Packaging', '24 Pairs / Master Carton (0.110 m³ • 10.5 kg)', 11),
(11362, 2091, 'Wholesale FOB Reference', '$2.33 / pair (Rp 54,066 Factory List)', 12),
(11363, 2091, 'Container 20ft Capacity', '7,200 Pairs', 13),
(11364, 2091, 'Container 40ft HQ Capacity', '17,000 Pairs', 14),
(11365, 2091, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11366, 2092, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11367, 2092, 'Key Spec', 'All-Weather PVC / EVA Blend • Flat Anti-Slip Suction Sipes • EU 39 - 43', 2),
(11368, 2092, 'Upper Material', 'All-Weather PVC / EVA Blend', 3),
(11369, 2092, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11370, 2092, 'Toe Protection', 'None', 5),
(11371, 2092, 'Underfoot Midsole', 'Ergonomic Textured Footbed', 6),
(11372, 2092, 'Slip Resistance', 'Flat Anti-Slip Suction Sipes', 7),
(11373, 2092, 'Shaft Height', '6.5 cm', 8),
(11374, 2092, 'Unit Weight', '360 g / pair', 9),
(11375, 2092, 'Available Sizing', 'EU 39 - 43', 10),
(11376, 2092, 'Packaging', '24 Pairs / Master Carton (0.110 m³ • 10.5 kg)', 11),
(11377, 2092, 'Wholesale FOB Reference', '$2.90 / pair (Rp 67,400 Factory List)', 12),
(11378, 2092, 'Container 20ft Capacity', '7,200 Pairs', 13),
(11379, 2092, 'Container 40ft HQ Capacity', '17,000 Pairs', 14),
(11380, 2092, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11381, 2093, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11382, 2093, 'Key Spec', 'Durable PVC • Flat Anti-Slip Suction Sipes • EU 39 - 43', 2),
(11383, 2093, 'Upper Material', 'Durable PVC', 3),
(11384, 2093, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11385, 2093, 'Toe Protection', 'None', 5),
(11386, 2093, 'Underfoot Midsole', 'Ergonomic Textured Footbed', 6),
(11387, 2093, 'Slip Resistance', 'Flat Anti-Slip Suction Sipes', 7),
(11388, 2093, 'Shaft Height', '6.5 cm', 8),
(11389, 2093, 'Unit Weight', '360 g / pair', 9),
(11390, 2093, 'Available Sizing', 'EU 39 - 43', 10),
(11391, 2093, 'Packaging', '24 Pairs / Master Carton (0.110 m³ • 10.5 kg)', 11),
(11392, 2093, 'Wholesale FOB Reference', '$2.90 / pair (Rp 67,400 Factory List)', 12),
(11393, 2093, 'Container 20ft Capacity', '7,200 Pairs', 13),
(11394, 2093, 'Container 40ft HQ Capacity', '17,000 Pairs', 14),
(11395, 2093, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11396, 2094, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11397, 2094, 'Key Spec', 'Ergonomic Casual PVC • Flat Anti-Slip Suction Sipes • EU 39 - 43', 2),
(11398, 2094, 'Upper Material', 'Ergonomic Casual PVC', 3),
(11399, 2094, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11400, 2094, 'Toe Protection', 'None', 5),
(11401, 2094, 'Underfoot Midsole', 'Ergonomic Textured Footbed', 6),
(11402, 2094, 'Slip Resistance', 'Flat Anti-Slip Suction Sipes', 7),
(11403, 2094, 'Shaft Height', '6.5 cm', 8),
(11404, 2094, 'Unit Weight', '360 g / pair', 9),
(11405, 2094, 'Available Sizing', 'EU 39 - 43', 10),
(11406, 2094, 'Packaging', '24 Pairs / Master Carton (0.110 m³ • 10.5 kg)', 11),
(11407, 2094, 'Wholesale FOB Reference', '$2.90 / pair (Rp 67,400 Factory List)', 12),
(11408, 2094, 'Container 20ft Capacity', '7,200 Pairs', 13),
(11409, 2094, 'Container 40ft HQ Capacity', '17,000 Pairs', 14),
(11410, 2094, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11411, 2095, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11412, 2095, 'Key Spec', 'Hygienic Soft PVC • Flat Anti-Slip Suction Sipes • EU 36 - 41', 2),
(11413, 2095, 'Upper Material', 'Hygienic Soft PVC', 3),
(11414, 2095, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11415, 2095, 'Toe Protection', 'None', 5),
(11416, 2095, 'Underfoot Midsole', 'Ergonomic Textured Footbed', 6),
(11417, 2095, 'Slip Resistance', 'Flat Anti-Slip Suction Sipes', 7),
(11418, 2095, 'Shaft Height', '6.5 cm', 8),
(11419, 2095, 'Unit Weight', '360 g / pair', 9),
(11420, 2095, 'Available Sizing', 'EU 36 - 41', 10),
(11421, 2095, 'Packaging', '24 Pairs / Master Carton (0.110 m³ • 10.5 kg)', 11),
(11422, 2095, 'Wholesale FOB Reference', '$2.04 / pair (Rp 47,400 Factory List)', 12),
(11423, 2095, 'Container 20ft Capacity', '7,200 Pairs', 13),
(11424, 2095, 'Container 40ft HQ Capacity', '17,000 Pairs', 14),
(11425, 2095, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11426, 2096, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11427, 2096, 'Key Spec', 'Hygienic Soft PVC • Flat Anti-Slip Suction Sipes • EU 36 - 42', 2),
(11428, 2096, 'Upper Material', 'Hygienic Soft PVC', 3),
(11429, 2096, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11430, 2096, 'Toe Protection', 'None', 5),
(11431, 2096, 'Underfoot Midsole', 'Ergonomic Textured Footbed', 6),
(11432, 2096, 'Slip Resistance', 'Flat Anti-Slip Suction Sipes', 7),
(11433, 2096, 'Shaft Height', '6.5 cm', 8),
(11434, 2096, 'Unit Weight', '360 g / pair', 9),
(11435, 2096, 'Available Sizing', 'EU 36 - 42', 10),
(11436, 2096, 'Packaging', '24 Pairs / Master Carton (0.110 m³ • 10.5 kg)', 11),
(11437, 2096, 'Wholesale FOB Reference', '$2.33 / pair (Rp 54,066 Factory List)', 12),
(11438, 2096, 'Container 20ft Capacity', '7,200 Pairs', 13),
(11439, 2096, 'Container 40ft HQ Capacity', '17,000 Pairs', 14),
(11440, 2096, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11441, 2097, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11442, 2097, 'Key Spec', 'Sporty Accented PVC • Flat Anti-Slip Suction Sipes • EU 36 - 42', 2),
(11443, 2097, 'Upper Material', 'Sporty Accented PVC', 3),
(11444, 2097, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11445, 2097, 'Toe Protection', 'None', 5),
(11446, 2097, 'Underfoot Midsole', 'Ergonomic Textured Footbed', 6),
(11447, 2097, 'Slip Resistance', 'Flat Anti-Slip Suction Sipes', 7),
(11448, 2097, 'Shaft Height', '6.5 cm', 8),
(11449, 2097, 'Unit Weight', '360 g / pair', 9),
(11450, 2097, 'Available Sizing', 'EU 36 - 42', 10),
(11451, 2097, 'Packaging', '24 Pairs / Master Carton (0.110 m³ • 10.5 kg)', 11),
(11452, 2097, 'Wholesale FOB Reference', '$2.04 / pair (Rp 47,400 Factory List)', 12),
(11453, 2097, 'Container 20ft Capacity', '7,200 Pairs', 13),
(11454, 2097, 'Container 40ft HQ Capacity', '17,000 Pairs', 14),
(11455, 2097, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11456, 2098, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11457, 2098, 'Key Spec', 'Contrast Sole PVC • Flat Anti-Slip Suction Sipes • EU 36 - 42', 2),
(11458, 2098, 'Upper Material', 'Contrast Sole PVC', 3),
(11459, 2098, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11460, 2098, 'Toe Protection', 'None', 5),
(11461, 2098, 'Underfoot Midsole', 'Ergonomic Textured Footbed', 6),
(11462, 2098, 'Slip Resistance', 'Flat Anti-Slip Suction Sipes', 7),
(11463, 2098, 'Shaft Height', '6.5 cm', 8),
(11464, 2098, 'Unit Weight', '360 g / pair', 9),
(11465, 2098, 'Available Sizing', 'EU 36 - 42', 10),
(11466, 2098, 'Packaging', '24 Pairs / Master Carton (0.110 m³ • 10.5 kg)', 11),
(11467, 2098, 'Wholesale FOB Reference', '$2.04 / pair (Rp 47,400 Factory List)', 12),
(11468, 2098, 'Container 20ft Capacity', '7,200 Pairs', 13),
(11469, 2098, 'Container 40ft HQ Capacity', '17,000 Pairs', 14),
(11470, 2098, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11471, 2099, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11472, 2099, 'Key Spec', 'Solid Rubberized Slide • Flat Anti-Slip Suction Sipes • EU 38 - 43', 2),
(11473, 2099, 'Upper Material', 'Solid Rubberized Slide', 3),
(11474, 2099, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11475, 2099, 'Toe Protection', 'None', 5),
(11476, 2099, 'Underfoot Midsole', 'Ergonomic Textured Footbed', 6),
(11477, 2099, 'Slip Resistance', 'Flat Anti-Slip Suction Sipes', 7),
(11478, 2099, 'Shaft Height', '6.5 cm', 8),
(11479, 2099, 'Unit Weight', '360 g / pair', 9),
(11480, 2099, 'Available Sizing', 'EU 38 - 43', 10),
(11481, 2099, 'Packaging', '24 Pairs / Master Carton (0.110 m³ • 10.5 kg)', 11),
(11482, 2099, 'Wholesale FOB Reference', '$1.62 / pair (Rp 37,674 Factory List)', 12),
(11483, 2099, 'Container 20ft Capacity', '7,200 Pairs', 13),
(11484, 2099, 'Container 40ft HQ Capacity', '17,000 Pairs', 14),
(11485, 2099, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11486, 2100, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11487, 2100, 'Key Spec', 'Lightweight Slide PVC • Flat Anti-Slip Suction Sipes • EU 38 - 43', 2),
(11488, 2100, 'Upper Material', 'Lightweight Slide PVC', 3),
(11489, 2100, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11490, 2100, 'Toe Protection', 'None', 5),
(11491, 2100, 'Underfoot Midsole', 'Ergonomic Textured Footbed', 6),
(11492, 2100, 'Slip Resistance', 'Flat Anti-Slip Suction Sipes', 7),
(11493, 2100, 'Shaft Height', '6.5 cm', 8),
(11494, 2100, 'Unit Weight', '360 g / pair', 9),
(11495, 2100, 'Available Sizing', 'EU 38 - 43', 10),
(11496, 2100, 'Packaging', '24 Pairs / Master Carton (0.110 m³ • 10.5 kg)', 11),
(11497, 2100, 'Wholesale FOB Reference', '$1.59 / pair (Rp 36,933 Factory List)', 12),
(11498, 2100, 'Container 20ft Capacity', '7,200 Pairs', 13),
(11499, 2100, 'Container 40ft HQ Capacity', '17,000 Pairs', 14),
(11500, 2100, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15);

INSERT INTO `product_specifications` (`id`, `product_id`, `spec_label`, `spec_value`, `display_order`) VALUES
(11501, 2101, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11502, 2101, 'Key Spec', 'Heavy Duty Slide • Flat Anti-Slip Suction Sipes • EU 38 - 43', 2),
(11503, 2101, 'Upper Material', 'Heavy Duty Slide', 3),
(11504, 2101, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11505, 2101, 'Toe Protection', 'None', 5),
(11506, 2101, 'Underfoot Midsole', 'Ergonomic Textured Footbed', 6),
(11507, 2101, 'Slip Resistance', 'Flat Anti-Slip Suction Sipes', 7),
(11508, 2101, 'Shaft Height', '6.5 cm', 8),
(11509, 2101, 'Unit Weight', '360 g / pair', 9),
(11510, 2101, 'Available Sizing', 'EU 38 - 43', 10),
(11511, 2101, 'Packaging', '24 Pairs / Master Carton (0.110 m³ • 10.5 kg)', 11),
(11512, 2101, 'Wholesale FOB Reference', '$1.59 / pair (Rp 36,933 Factory List)', 12),
(11513, 2101, 'Container 20ft Capacity', '7,200 Pairs', 13),
(11514, 2101, 'Container 40ft HQ Capacity', '17,000 Pairs', 14),
(11515, 2101, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11516, 2102, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11517, 2102, 'Key Spec', 'Ergonomic Outsole • Flat Anti-Slip Suction Sipes • EU 38 - 43', 2),
(11518, 2102, 'Upper Material', 'Ergonomic Outsole', 3),
(11519, 2102, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11520, 2102, 'Toe Protection', 'None', 5),
(11521, 2102, 'Underfoot Midsole', 'Ergonomic Textured Footbed', 6),
(11522, 2102, 'Slip Resistance', 'Flat Anti-Slip Suction Sipes', 7),
(11523, 2102, 'Shaft Height', '6.5 cm', 8),
(11524, 2102, 'Unit Weight', '360 g / pair', 9),
(11525, 2102, 'Available Sizing', 'EU 38 - 43', 10),
(11526, 2102, 'Packaging', '24 Pairs / Master Carton (0.110 m³ • 10.5 kg)', 11),
(11527, 2102, 'Wholesale FOB Reference', '$1.59 / pair (Rp 36,933 Factory List)', 12),
(11528, 2102, 'Container 20ft Capacity', '7,200 Pairs', 13),
(11529, 2102, 'Container 40ft HQ Capacity', '17,000 Pairs', 14),
(11530, 2102, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11531, 2103, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11532, 2103, 'Key Spec', 'High Traction Sandal • Flat Anti-Slip Suction Sipes • EU 38 - 43', 2),
(11533, 2103, 'Upper Material', 'High Traction Sandal', 3),
(11534, 2103, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11535, 2103, 'Toe Protection', 'None', 5),
(11536, 2103, 'Underfoot Midsole', 'Ergonomic Textured Footbed', 6),
(11537, 2103, 'Slip Resistance', 'Flat Anti-Slip Suction Sipes', 7),
(11538, 2103, 'Shaft Height', '6.5 cm', 8),
(11539, 2103, 'Unit Weight', '360 g / pair', 9),
(11540, 2103, 'Available Sizing', 'EU 38 - 43', 10),
(11541, 2103, 'Packaging', '24 Pairs / Master Carton (0.110 m³ • 10.5 kg)', 11),
(11542, 2103, 'Wholesale FOB Reference', '$1.90 / pair (Rp 44,100 Factory List)', 12),
(11543, 2103, 'Container 20ft Capacity', '7,200 Pairs', 13),
(11544, 2103, 'Container 40ft HQ Capacity', '17,000 Pairs', 14),
(11545, 2103, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11546, 2104, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11547, 2104, 'Key Spec', 'Comfort Wave Sole • Flat Anti-Slip Suction Sipes • EU 38 - 43', 2),
(11548, 2104, 'Upper Material', 'Comfort Wave Sole', 3),
(11549, 2104, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11550, 2104, 'Toe Protection', 'None', 5),
(11551, 2104, 'Underfoot Midsole', 'Ergonomic Textured Footbed', 6),
(11552, 2104, 'Slip Resistance', 'Flat Anti-Slip Suction Sipes', 7),
(11553, 2104, 'Shaft Height', '6.5 cm', 8),
(11554, 2104, 'Unit Weight', '360 g / pair', 9),
(11555, 2104, 'Available Sizing', 'EU 38 - 43', 10),
(11556, 2104, 'Packaging', '24 Pairs / Master Carton (0.110 m³ • 10.5 kg)', 11),
(11557, 2104, 'Wholesale FOB Reference', '$1.59 / pair (Rp 36,933 Factory List)', 12),
(11558, 2104, 'Container 20ft Capacity', '7,200 Pairs', 13),
(11559, 2104, 'Container 40ft HQ Capacity', '17,000 Pairs', 14),
(11560, 2104, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11561, 2105, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11562, 2105, 'Key Spec', 'Vulcanized Style Waterproof PVC • Herringbone Siped Rubber Sole • EU 38 - 43', 2),
(11563, 2105, 'Upper Material', 'Vulcanized Style Waterproof PVC', 3),
(11564, 2105, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11565, 2105, 'Toe Protection', 'Vulcanized Style Cap', 5),
(11566, 2105, 'Underfoot Midsole', 'Cushioned Insole', 6),
(11567, 2105, 'Slip Resistance', 'Herringbone Siped Rubber Sole', 7),
(11568, 2105, 'Shaft Height', '9.5 cm', 8),
(11569, 2105, 'Unit Weight', '650 g / pair', 9),
(11570, 2105, 'Available Sizing', 'EU 38 - 43', 10),
(11571, 2105, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 11.5 kg)', 11),
(11572, 2105, 'Wholesale FOB Reference', '$2.18 / pair (Rp 50,566 Factory List)', 12),
(11573, 2105, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11574, 2105, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11575, 2105, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11576, 2106, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11577, 2106, 'Key Spec', 'Triple Black All-Weather PVC • Herringbone Siped Rubber Sole • EU 38 - 43', 2),
(11578, 2106, 'Upper Material', 'Triple Black All-Weather PVC', 3),
(11579, 2106, 'Outsole', 'Molded PVC Cleated Sole', 4),
(11580, 2106, 'Toe Protection', 'Vulcanized Style Cap', 5),
(11581, 2106, 'Underfoot Midsole', 'Cushioned Insole', 6),
(11582, 2106, 'Slip Resistance', 'Herringbone Siped Rubber Sole', 7),
(11583, 2106, 'Shaft Height', '9.5 cm', 8),
(11584, 2106, 'Unit Weight', '650 g / pair', 9),
(11585, 2106, 'Available Sizing', 'EU 38 - 43', 10),
(11586, 2106, 'Packaging', '12 Pairs / Master Carton (0.096 m³ • 11.5 kg)', 11),
(11587, 2106, 'Wholesale FOB Reference', '$3.05 / pair (Rp 70,900 Factory List)', 12),
(11588, 2106, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11589, 2106, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11590, 2106, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11591, 2107, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11592, 2107, 'Key Spec', 'Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45', 2),
(11593, 2107, 'Upper Material', 'Reinforced PVC Compound', 3),
(11594, 2107, 'Outsole', 'Nitrile Rubber Heavy Lug Anti-Puncture Sole', 4),
(11595, 2107, 'Toe Protection', 'Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)', 5),
(11596, 2107, 'Underfoot Midsole', 'Steel Midsole Plate 1100N (Puncture Proof)', 6),
(11597, 2107, 'Slip Resistance', 'Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant)', 7),
(11598, 2107, 'Shaft Height', '38.0 cm', 8),
(11599, 2107, 'Unit Weight', '2250 g / pair', 9),
(11600, 2107, 'Available Sizing', 'EU 38 - 45', 10),
(11601, 2107, 'Packaging', '10 Pairs / Master Carton (0.096 m³ • 23.5 kg)', 11),
(11602, 2107, 'Wholesale FOB Reference', '$10.30 / pair (Rp 239,000 Factory List)', 12),
(11603, 2107, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11604, 2107, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11605, 2107, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11606, 2108, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11607, 2108, 'Key Spec', 'Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45', 2),
(11608, 2108, 'Upper Material', 'Reinforced PVC Compound', 3),
(11609, 2108, 'Outsole', 'Nitrile Rubber Heavy Lug Anti-Puncture Sole', 4),
(11610, 2108, 'Toe Protection', 'Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)', 5),
(11611, 2108, 'Underfoot Midsole', 'Steel Midsole Plate 1100N (Puncture Proof)', 6),
(11612, 2108, 'Slip Resistance', 'Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant)', 7),
(11613, 2108, 'Shaft Height', '38.0 cm', 8),
(11614, 2108, 'Unit Weight', '2250 g / pair', 9),
(11615, 2108, 'Available Sizing', 'EU 38 - 45', 10),
(11616, 2108, 'Packaging', '10 Pairs / Master Carton (0.096 m³ • 23.5 kg)', 11),
(11617, 2108, 'Wholesale FOB Reference', '$7.62 / pair (Rp 177,000 Factory List)', 12),
(11618, 2108, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11619, 2108, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11620, 2108, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11621, 2109, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11622, 2109, 'Key Spec', 'Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45', 2),
(11623, 2109, 'Upper Material', 'Reinforced PVC Compound', 3),
(11624, 2109, 'Outsole', 'Nitrile Rubber Heavy Lug Anti-Puncture Sole', 4),
(11625, 2109, 'Toe Protection', 'Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)', 5),
(11626, 2109, 'Underfoot Midsole', 'Steel Midsole Plate 1100N (Puncture Proof)', 6),
(11627, 2109, 'Slip Resistance', 'Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant)', 7),
(11628, 2109, 'Shaft Height', '38.0 cm', 8),
(11629, 2109, 'Unit Weight', '2250 g / pair', 9),
(11630, 2109, 'Available Sizing', 'EU 38 - 45', 10),
(11631, 2109, 'Packaging', '10 Pairs / Master Carton (0.096 m³ • 23.5 kg)', 11),
(11632, 2109, 'Wholesale FOB Reference', '$7.62 / pair (Rp 177,000 Factory List)', 12),
(11633, 2109, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11634, 2109, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11635, 2109, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11636, 2110, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11637, 2110, 'Key Spec', 'Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45', 2),
(11638, 2110, 'Upper Material', 'Reinforced PVC Compound', 3),
(11639, 2110, 'Outsole', 'Nitrile Rubber Heavy Lug Anti-Puncture Sole', 4),
(11640, 2110, 'Toe Protection', 'Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)', 5),
(11641, 2110, 'Underfoot Midsole', 'Steel Midsole Plate 1100N (Puncture Proof)', 6),
(11642, 2110, 'Slip Resistance', 'Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant)', 7),
(11643, 2110, 'Shaft Height', '38.0 cm', 8),
(11644, 2110, 'Unit Weight', '2250 g / pair', 9),
(11645, 2110, 'Available Sizing', 'EU 38 - 45', 10),
(11646, 2110, 'Packaging', '10 Pairs / Master Carton (0.096 m³ • 23.5 kg)', 11),
(11647, 2110, 'Wholesale FOB Reference', '$4.74 / pair (Rp 110,000 Factory List)', 12),
(11648, 2110, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11649, 2110, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11650, 2110, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11651, 2111, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11652, 2111, 'Key Spec', 'Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45', 2),
(11653, 2111, 'Upper Material', 'Reinforced PVC Compound', 3),
(11654, 2111, 'Outsole', 'Nitrile Rubber Heavy Lug Anti-Puncture Sole', 4),
(11655, 2111, 'Toe Protection', 'Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)', 5),
(11656, 2111, 'Underfoot Midsole', 'Steel Midsole Plate 1100N (Puncture Proof)', 6),
(11657, 2111, 'Slip Resistance', 'Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant)', 7),
(11658, 2111, 'Shaft Height', '38.0 cm', 8),
(11659, 2111, 'Unit Weight', '2250 g / pair', 9),
(11660, 2111, 'Available Sizing', 'EU 38 - 45', 10),
(11661, 2111, 'Packaging', '10 Pairs / Master Carton (0.096 m³ • 23.5 kg)', 11),
(11662, 2111, 'Wholesale FOB Reference', '$4.74 / pair (Rp 110,000 Factory List)', 12),
(11663, 2111, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11664, 2111, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11665, 2111, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11666, 2112, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11667, 2112, 'Key Spec', 'Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45', 2),
(11668, 2112, 'Upper Material', 'Reinforced PVC Compound', 3),
(11669, 2112, 'Outsole', 'Nitrile Rubber Heavy Lug Anti-Puncture Sole', 4),
(11670, 2112, 'Toe Protection', 'Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)', 5),
(11671, 2112, 'Underfoot Midsole', 'Steel Midsole Plate 1100N (Puncture Proof)', 6),
(11672, 2112, 'Slip Resistance', 'Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant)', 7),
(11673, 2112, 'Shaft Height', '38.0 cm', 8),
(11674, 2112, 'Unit Weight', '2250 g / pair', 9),
(11675, 2112, 'Available Sizing', 'EU 38 - 45', 10),
(11676, 2112, 'Packaging', '10 Pairs / Master Carton (0.096 m³ • 23.5 kg)', 11),
(11677, 2112, 'Wholesale FOB Reference', '$3.34 / pair (Rp 77,500 Factory List)', 12),
(11678, 2112, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11679, 2112, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11680, 2112, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11681, 2113, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11682, 2113, 'Key Spec', 'Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45', 2),
(11683, 2113, 'Upper Material', 'Reinforced PVC Compound', 3),
(11684, 2113, 'Outsole', 'Nitrile Rubber Heavy Lug Anti-Puncture Sole', 4),
(11685, 2113, 'Toe Protection', 'Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)', 5),
(11686, 2113, 'Underfoot Midsole', 'Steel Midsole Plate 1100N (Puncture Proof)', 6),
(11687, 2113, 'Slip Resistance', 'Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant)', 7),
(11688, 2113, 'Shaft Height', '38.0 cm', 8),
(11689, 2113, 'Unit Weight', '2250 g / pair', 9),
(11690, 2113, 'Available Sizing', 'EU 38 - 45', 10),
(11691, 2113, 'Packaging', '10 Pairs / Master Carton (0.096 m³ • 23.5 kg)', 11),
(11692, 2113, 'Wholesale FOB Reference', '$4.09 / pair (Rp 95,000 Factory List)', 12),
(11693, 2113, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11694, 2113, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11695, 2113, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11696, 2114, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11697, 2114, 'Key Spec', 'Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45', 2),
(11698, 2114, 'Upper Material', 'Reinforced PVC Compound', 3),
(11699, 2114, 'Outsole', 'Nitrile Rubber Heavy Lug Anti-Puncture Sole', 4),
(11700, 2114, 'Toe Protection', 'Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)', 5),
(11701, 2114, 'Underfoot Midsole', 'Steel Midsole Plate 1100N (Puncture Proof)', 6),
(11702, 2114, 'Slip Resistance', 'Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant)', 7),
(11703, 2114, 'Shaft Height', '38.0 cm', 8),
(11704, 2114, 'Unit Weight', '2250 g / pair', 9),
(11705, 2114, 'Available Sizing', 'EU 38 - 45', 10),
(11706, 2114, 'Packaging', '10 Pairs / Master Carton (0.096 m³ • 23.5 kg)', 11),
(11707, 2114, 'Wholesale FOB Reference', '$4.74 / pair (Rp 110,000 Factory List)', 12),
(11708, 2114, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11709, 2114, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11710, 2114, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11711, 2115, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11712, 2115, 'Key Spec', 'Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45', 2),
(11713, 2115, 'Upper Material', 'Reinforced PVC Compound', 3),
(11714, 2115, 'Outsole', 'Nitrile Rubber Heavy Lug Anti-Puncture Sole', 4),
(11715, 2115, 'Toe Protection', 'Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)', 5),
(11716, 2115, 'Underfoot Midsole', 'Steel Midsole Plate 1100N (Puncture Proof)', 6),
(11717, 2115, 'Slip Resistance', 'Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant)', 7),
(11718, 2115, 'Shaft Height', '38.0 cm', 8),
(11719, 2115, 'Unit Weight', '2250 g / pair', 9),
(11720, 2115, 'Available Sizing', 'EU 38 - 45', 10),
(11721, 2115, 'Packaging', '10 Pairs / Master Carton (0.096 m³ • 23.5 kg)', 11),
(11722, 2115, 'Wholesale FOB Reference', '$7.19 / pair (Rp 167,000 Factory List)', 12),
(11723, 2115, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11724, 2115, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11725, 2115, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11726, 2116, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11727, 2116, 'Key Spec', 'Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45', 2),
(11728, 2116, 'Upper Material', 'Reinforced PVC Compound', 3),
(11729, 2116, 'Outsole', 'Nitrile Rubber Heavy Lug Anti-Puncture Sole', 4),
(11730, 2116, 'Toe Protection', 'Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)', 5),
(11731, 2116, 'Underfoot Midsole', 'Steel Midsole Plate 1100N (Puncture Proof)', 6),
(11732, 2116, 'Slip Resistance', 'Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant)', 7),
(11733, 2116, 'Shaft Height', '38.0 cm', 8),
(11734, 2116, 'Unit Weight', '2250 g / pair', 9),
(11735, 2116, 'Available Sizing', 'EU 38 - 45', 10),
(11736, 2116, 'Packaging', '10 Pairs / Master Carton (0.096 m³ • 23.5 kg)', 11),
(11737, 2116, 'Wholesale FOB Reference', '$9.33 / pair (Rp 216,500 Factory List)', 12),
(11738, 2116, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11739, 2116, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11740, 2116, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11741, 2117, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11742, 2117, 'Key Spec', 'Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45', 2),
(11743, 2117, 'Upper Material', 'Reinforced PVC Compound', 3),
(11744, 2117, 'Outsole', 'Nitrile Rubber Heavy Lug Anti-Puncture Sole', 4),
(11745, 2117, 'Toe Protection', 'Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)', 5),
(11746, 2117, 'Underfoot Midsole', 'Steel Midsole Plate 1100N (Puncture Proof)', 6),
(11747, 2117, 'Slip Resistance', 'Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant)', 7),
(11748, 2117, 'Shaft Height', '38.0 cm', 8),
(11749, 2117, 'Unit Weight', '2250 g / pair', 9),
(11750, 2117, 'Available Sizing', 'EU 38 - 45', 10);

INSERT INTO `product_specifications` (`id`, `product_id`, `spec_label`, `spec_value`, `display_order`) VALUES
(11751, 2117, 'Packaging', '10 Pairs / Master Carton (0.096 m³ • 23.5 kg)', 11),
(11752, 2117, 'Wholesale FOB Reference', '$9.33 / pair (Rp 216,500 Factory List)', 12),
(11753, 2117, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11754, 2117, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11755, 2117, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11756, 2118, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11757, 2118, 'Key Spec', 'Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45', 2),
(11758, 2118, 'Upper Material', 'Reinforced PVC Compound', 3),
(11759, 2118, 'Outsole', 'Nitrile Rubber Heavy Lug Anti-Puncture Sole', 4),
(11760, 2118, 'Toe Protection', 'Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)', 5),
(11761, 2118, 'Underfoot Midsole', 'Steel Midsole Plate 1100N (Puncture Proof)', 6),
(11762, 2118, 'Slip Resistance', 'Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant)', 7),
(11763, 2118, 'Shaft Height', '38.0 cm', 8),
(11764, 2118, 'Unit Weight', '2250 g / pair', 9),
(11765, 2118, 'Available Sizing', 'EU 38 - 45', 10),
(11766, 2118, 'Packaging', '10 Pairs / Master Carton (0.096 m³ • 23.5 kg)', 11),
(11767, 2118, 'Wholesale FOB Reference', '$9.33 / pair (Rp 216,500 Factory List)', 12),
(11768, 2118, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11769, 2118, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11770, 2118, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11771, 2119, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11772, 2119, 'Key Spec', 'Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45', 2),
(11773, 2119, 'Upper Material', 'Reinforced PVC Compound', 3),
(11774, 2119, 'Outsole', 'Nitrile Rubber Heavy Lug Anti-Puncture Sole', 4),
(11775, 2119, 'Toe Protection', 'Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)', 5),
(11776, 2119, 'Underfoot Midsole', 'Steel Midsole Plate 1100N (Puncture Proof)', 6),
(11777, 2119, 'Slip Resistance', 'Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant)', 7),
(11778, 2119, 'Shaft Height', '38.0 cm', 8),
(11779, 2119, 'Unit Weight', '2250 g / pair', 9),
(11780, 2119, 'Available Sizing', 'EU 38 - 45', 10),
(11781, 2119, 'Packaging', '10 Pairs / Master Carton (0.096 m³ • 23.5 kg)', 11),
(11782, 2119, 'Wholesale FOB Reference', '$9.33 / pair (Rp 216,500 Factory List)', 12),
(11783, 2119, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11784, 2119, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11785, 2119, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11786, 2120, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11787, 2120, 'Key Spec', 'Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45', 2),
(11788, 2120, 'Upper Material', 'Reinforced PVC Compound', 3),
(11789, 2120, 'Outsole', 'Nitrile Rubber Heavy Lug Anti-Puncture Sole', 4),
(11790, 2120, 'Toe Protection', 'Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)', 5),
(11791, 2120, 'Underfoot Midsole', 'Steel Midsole Plate 1100N (Puncture Proof)', 6),
(11792, 2120, 'Slip Resistance', 'Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant)', 7),
(11793, 2120, 'Shaft Height', '38.0 cm', 8),
(11794, 2120, 'Unit Weight', '2250 g / pair', 9),
(11795, 2120, 'Available Sizing', 'EU 38 - 45', 10),
(11796, 2120, 'Packaging', '10 Pairs / Master Carton (0.096 m³ • 23.5 kg)', 11),
(11797, 2120, 'Wholesale FOB Reference', '$9.33 / pair (Rp 216,500 Factory List)', 12),
(11798, 2120, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11799, 2120, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11800, 2120, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11801, 2121, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11802, 2121, 'Key Spec', 'Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45', 2),
(11803, 2121, 'Upper Material', 'Reinforced PVC Compound', 3),
(11804, 2121, 'Outsole', 'Nitrile Rubber Heavy Lug Anti-Puncture Sole', 4),
(11805, 2121, 'Toe Protection', 'Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)', 5),
(11806, 2121, 'Underfoot Midsole', 'Steel Midsole Plate 1100N (Puncture Proof)', 6),
(11807, 2121, 'Slip Resistance', 'Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant)', 7),
(11808, 2121, 'Shaft Height', '38.0 cm', 8),
(11809, 2121, 'Unit Weight', '2250 g / pair', 9),
(11810, 2121, 'Available Sizing', 'EU 38 - 45', 10),
(11811, 2121, 'Packaging', '10 Pairs / Master Carton (0.096 m³ • 23.5 kg)', 11),
(11812, 2121, 'Wholesale FOB Reference', '$9.33 / pair (Rp 216,500 Factory List)', 12),
(11813, 2121, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11814, 2121, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11815, 2121, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11816, 2122, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11817, 2122, 'Key Spec', 'Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45', 2),
(11818, 2122, 'Upper Material', 'Reinforced PVC Compound', 3),
(11819, 2122, 'Outsole', 'Nitrile Rubber Heavy Lug Anti-Puncture Sole', 4),
(11820, 2122, 'Toe Protection', 'Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)', 5),
(11821, 2122, 'Underfoot Midsole', 'Steel Midsole Plate 1100N (Puncture Proof)', 6),
(11822, 2122, 'Slip Resistance', 'Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant)', 7),
(11823, 2122, 'Shaft Height', '38.0 cm', 8),
(11824, 2122, 'Unit Weight', '2250 g / pair', 9),
(11825, 2122, 'Available Sizing', 'EU 38 - 45', 10),
(11826, 2122, 'Packaging', '10 Pairs / Master Carton (0.096 m³ • 23.5 kg)', 11),
(11827, 2122, 'Wholesale FOB Reference', '$9.33 / pair (Rp 216,500 Factory List)', 12),
(11828, 2122, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11829, 2122, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11830, 2122, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11831, 2123, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11832, 2123, 'Key Spec', 'Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45', 2),
(11833, 2123, 'Upper Material', 'Reinforced PVC Compound', 3),
(11834, 2123, 'Outsole', 'Nitrile Rubber Heavy Lug Anti-Puncture Sole', 4),
(11835, 2123, 'Toe Protection', 'Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)', 5),
(11836, 2123, 'Underfoot Midsole', 'Steel Midsole Plate 1100N (Puncture Proof)', 6),
(11837, 2123, 'Slip Resistance', 'Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant)', 7),
(11838, 2123, 'Shaft Height', '38.0 cm', 8),
(11839, 2123, 'Unit Weight', '2250 g / pair', 9),
(11840, 2123, 'Available Sizing', 'EU 38 - 45', 10),
(11841, 2123, 'Packaging', '10 Pairs / Master Carton (0.096 m³ • 23.5 kg)', 11),
(11842, 2123, 'Wholesale FOB Reference', '$6.03 / pair (Rp 140,000 Factory List)', 12),
(11843, 2123, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11844, 2123, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11845, 2123, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11846, 2124, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11847, 2124, 'Key Spec', 'Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45', 2),
(11848, 2124, 'Upper Material', 'Reinforced PVC Compound', 3),
(11849, 2124, 'Outsole', 'Nitrile Rubber Heavy Lug Anti-Puncture Sole', 4),
(11850, 2124, 'Toe Protection', 'Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)', 5),
(11851, 2124, 'Underfoot Midsole', 'Steel Midsole Plate 1100N (Puncture Proof)', 6),
(11852, 2124, 'Slip Resistance', 'Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant)', 7),
(11853, 2124, 'Shaft Height', '38.0 cm', 8),
(11854, 2124, 'Unit Weight', '2250 g / pair', 9),
(11855, 2124, 'Available Sizing', 'EU 38 - 45', 10),
(11856, 2124, 'Packaging', '10 Pairs / Master Carton (0.096 m³ • 23.5 kg)', 11),
(11857, 2124, 'Wholesale FOB Reference', '$3.88 / pair (Rp 90,000 Factory List)', 12),
(11858, 2124, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11859, 2124, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11860, 2124, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15),
(11861, 2125, 'Compliance', 'SNI 0111:2009, ISO 9001:2015, GPSR EU 2023/988', 1),
(11862, 2125, 'Key Spec', 'Reinforced PVC Compound • Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant) • EU 38 - 45', 2),
(11863, 2125, 'Upper Material', 'Reinforced PVC Compound', 3),
(11864, 2125, 'Outsole', 'Nitrile Rubber Heavy Lug Anti-Puncture Sole', 4),
(11865, 2125, 'Toe Protection', 'Heavy-Duty Steel Toe Cap 200J (EN ISO 20345 S5)', 5),
(11866, 2125, 'Underfoot Midsole', 'Steel Midsole Plate 1100N (Puncture Proof)', 6),
(11867, 2125, 'Slip Resistance', 'Deep Tractor Lug Nitrile Sole (SRC Oil & Chemical Resistant)', 7),
(11868, 2125, 'Shaft Height', '38.0 cm', 8),
(11869, 2125, 'Unit Weight', '2250 g / pair', 9),
(11870, 2125, 'Available Sizing', 'EU 38 - 45', 10),
(11871, 2125, 'Packaging', '10 Pairs / Master Carton (0.096 m³ • 23.5 kg)', 11),
(11872, 2125, 'Wholesale FOB Reference', '$6.94 / pair (Rp 161,000 Factory List)', 12),
(11873, 2125, 'Container 20ft Capacity', '3,600 Pairs', 13),
(11874, 2125, 'Container 40ft HQ Capacity', '8,500 Pairs', 14),
(11875, 2125, 'Port of Loading', 'Tanjung Perak Seaport (ID SUB), Surabaya, Indonesia', 15);

-- -------------------------------------------------------------
-- 6. PRODUCT USE CASES (532 rows)
-- -------------------------------------------------------------
INSERT INTO `product_use_cases` (`id`, `product_id`, `use_case`) VALUES
(10001, 2001, 'Pertambangan Batubara'),
(10002, 2001, 'Migas'),
(10003, 2001, 'Proyek Sipil Konstruksi Berat'),
(10004, 2001, 'Pabrik Kimia'),
(10005, 2001, 'Peleburan Logam'),
(10006, 2002, 'Pertambangan Batubara'),
(10007, 2002, 'Migas'),
(10008, 2002, 'Proyek Sipil Konstruksi Berat'),
(10009, 2002, 'Pabrik Kimia'),
(10010, 2002, 'Peleburan Logam'),
(10011, 2003, 'Pertambangan Batubara'),
(10012, 2003, 'Migas'),
(10013, 2003, 'Proyek Sipil Konstruksi Berat'),
(10014, 2003, 'Pabrik Kimia'),
(10015, 2003, 'Peleburan Logam'),
(10016, 2004, 'Pertambangan Batubara'),
(10017, 2004, 'Migas'),
(10018, 2004, 'Proyek Sipil Konstruksi Berat'),
(10019, 2004, 'Pabrik Kimia'),
(10020, 2004, 'Peleburan Logam'),
(10021, 2005, 'Pertambangan Batubara'),
(10022, 2005, 'Migas'),
(10023, 2005, 'Proyek Sipil Konstruksi Berat'),
(10024, 2005, 'Pabrik Kimia'),
(10025, 2005, 'Peleburan Logam'),
(10026, 2006, 'Pertambangan Batubara'),
(10027, 2006, 'Migas'),
(10028, 2006, 'Proyek Sipil Konstruksi Berat'),
(10029, 2006, 'Pabrik Kimia'),
(10030, 2006, 'Peleburan Logam'),
(10031, 2007, 'Pertambangan Batubara'),
(10032, 2007, 'Migas'),
(10033, 2007, 'Proyek Sipil Konstruksi Berat'),
(10034, 2007, 'Pabrik Kimia'),
(10035, 2007, 'Peleburan Logam'),
(10036, 2008, 'Perkebunan Kelapa Sawit'),
(10037, 2008, 'Sawah Padi'),
(10038, 2008, 'Kehutanan'),
(10039, 2008, 'Peternakan Sapi'),
(10040, 2008, 'Irigasi Rawa'),
(10041, 2009, 'Perkebunan Kelapa Sawit'),
(10042, 2009, 'Sawah Padi'),
(10043, 2009, 'Kehutanan'),
(10044, 2009, 'Peternakan Sapi'),
(10045, 2009, 'Irigasi Rawa'),
(10046, 2010, 'Perkebunan Kelapa Sawit'),
(10047, 2010, 'Sawah Padi'),
(10048, 2010, 'Kehutanan'),
(10049, 2010, 'Peternakan Sapi'),
(10050, 2010, 'Irigasi Rawa'),
(10051, 2011, 'Perkebunan Kelapa Sawit'),
(10052, 2011, 'Sawah Padi'),
(10053, 2011, 'Kehutanan'),
(10054, 2011, 'Peternakan Sapi'),
(10055, 2011, 'Irigasi Rawa'),
(10056, 2012, 'Perkebunan Kelapa Sawit'),
(10057, 2012, 'Sawah Padi'),
(10058, 2012, 'Kehutanan'),
(10059, 2012, 'Peternakan Sapi'),
(10060, 2012, 'Irigasi Rawa'),
(10061, 2013, 'Perkebunan Kelapa Sawit'),
(10062, 2013, 'Sawah Padi'),
(10063, 2013, 'Kehutanan'),
(10064, 2013, 'Peternakan Sapi'),
(10065, 2013, 'Irigasi Rawa'),
(10066, 2014, 'Perkebunan Kelapa Sawit'),
(10067, 2014, 'Sawah Padi'),
(10068, 2014, 'Kehutanan'),
(10069, 2014, 'Peternakan Sapi'),
(10070, 2014, 'Irigasi Rawa'),
(10071, 2015, 'Perkebunan Kelapa Sawit'),
(10072, 2015, 'Sawah Padi'),
(10073, 2015, 'Kehutanan'),
(10074, 2015, 'Peternakan Sapi'),
(10075, 2015, 'Irigasi Rawa'),
(10076, 2016, 'Perkebunan Kelapa Sawit'),
(10077, 2016, 'Sawah Padi'),
(10078, 2016, 'Kehutanan'),
(10079, 2016, 'Peternakan Sapi'),
(10080, 2016, 'Irigasi Rawa'),
(10081, 2017, 'Perkebunan Kelapa Sawit'),
(10082, 2017, 'Sawah Padi'),
(10083, 2017, 'Kehutanan'),
(10084, 2017, 'Peternakan Sapi'),
(10085, 2017, 'Irigasi Rawa'),
(10086, 2018, 'Perkebunan Kelapa Sawit'),
(10087, 2018, 'Sawah Padi'),
(10088, 2018, 'Kehutanan'),
(10089, 2018, 'Peternakan Sapi'),
(10090, 2018, 'Irigasi Rawa'),
(10091, 2019, 'Perkebunan Kelapa Sawit'),
(10092, 2019, 'Sawah Padi'),
(10093, 2019, 'Kehutanan'),
(10094, 2019, 'Peternakan Sapi'),
(10095, 2019, 'Irigasi Rawa'),
(10096, 2020, 'Perkebunan Kelapa Sawit'),
(10097, 2020, 'Sawah Padi'),
(10098, 2020, 'Kehutanan'),
(10099, 2020, 'Peternakan Sapi'),
(10100, 2020, 'Irigasi Rawa'),
(10101, 2021, 'Perkebunan Kelapa Sawit'),
(10102, 2021, 'Sawah Padi'),
(10103, 2021, 'Kehutanan'),
(10104, 2021, 'Peternakan Sapi'),
(10105, 2021, 'Irigasi Rawa'),
(10106, 2022, 'Perkebunan Kelapa Sawit'),
(10107, 2022, 'Sawah Padi'),
(10108, 2022, 'Kehutanan'),
(10109, 2022, 'Peternakan Sapi'),
(10110, 2022, 'Irigasi Rawa'),
(10111, 2023, 'Perkebunan Kelapa Sawit'),
(10112, 2023, 'Sawah Padi'),
(10113, 2023, 'Kehutanan'),
(10114, 2023, 'Peternakan Sapi'),
(10115, 2023, 'Irigasi Rawa'),
(10116, 2024, 'Perkebunan Kelapa Sawit'),
(10117, 2024, 'Sawah Padi'),
(10118, 2024, 'Kehutanan'),
(10119, 2024, 'Peternakan Sapi'),
(10120, 2024, 'Irigasi Rawa'),
(10121, 2025, 'Perkebunan Kelapa Sawit'),
(10122, 2025, 'Sawah Padi'),
(10123, 2025, 'Kehutanan'),
(10124, 2025, 'Peternakan Sapi'),
(10125, 2025, 'Irigasi Rawa'),
(10126, 2026, 'Perkebunan Kelapa Sawit'),
(10127, 2026, 'Sawah Padi'),
(10128, 2026, 'Kehutanan'),
(10129, 2026, 'Peternakan Sapi'),
(10130, 2026, 'Irigasi Rawa'),
(10131, 2027, 'Perikanan Laut Dalam'),
(10132, 2027, 'Industri Cold Storage'),
(10133, 2027, 'Galangan Kapal'),
(10134, 2027, 'Pengolahan Ikan'),
(10135, 2028, 'Dapur Komersial HORECA'),
(10136, 2028, 'Bakery'),
(10137, 2028, 'Restoran Cepat Saji'),
(10138, 2028, 'Pabrik Pengolahan Makanan'),
(10139, 2029, 'Dapur Komersial HORECA'),
(10140, 2029, 'Bakery'),
(10141, 2029, 'Restoran Cepat Saji'),
(10142, 2029, 'Pabrik Pengolahan Makanan'),
(10143, 2030, 'Dapur Komersial HORECA'),
(10144, 2030, 'Bakery'),
(10145, 2030, 'Restoran Cepat Saji'),
(10146, 2030, 'Pabrik Pengolahan Makanan'),
(10147, 2031, 'Rumah Sakit'),
(10148, 2031, 'Laboratorium Medis'),
(10149, 2031, 'Industri Farmasi'),
(10150, 2031, 'Cleanroom Semikonduktor'),
(10151, 2031, 'Sanitasi'),
(10152, 2032, 'Rumah Sakit'),
(10153, 2032, 'Laboratorium Medis'),
(10154, 2032, 'Industri Farmasi'),
(10155, 2032, 'Cleanroom Semikonduktor'),
(10156, 2032, 'Sanitasi'),
(10157, 2033, 'Rumah Sakit'),
(10158, 2033, 'Laboratorium Medis'),
(10159, 2033, 'Industri Farmasi'),
(10160, 2033, 'Cleanroom Semikonduktor'),
(10161, 2033, 'Sanitasi'),
(10162, 2034, 'Rumah Sakit'),
(10163, 2034, 'Laboratorium Medis'),
(10164, 2034, 'Industri Farmasi'),
(10165, 2034, 'Cleanroom Semikonduktor'),
(10166, 2034, 'Sanitasi'),
(10167, 2035, 'Rumah Sakit'),
(10168, 2035, 'Laboratorium Medis'),
(10169, 2035, 'Industri Farmasi'),
(10170, 2035, 'Cleanroom Semikonduktor'),
(10171, 2035, 'Sanitasi'),
(10172, 2036, 'Rumah Sakit'),
(10173, 2036, 'Laboratorium Medis'),
(10174, 2036, 'Industri Farmasi'),
(10175, 2036, 'Cleanroom Semikonduktor'),
(10176, 2036, 'Sanitasi'),
(10177, 2037, 'Rumah Sakit'),
(10178, 2037, 'Laboratorium Medis'),
(10179, 2037, 'Industri Farmasi'),
(10180, 2037, 'Cleanroom Semikonduktor'),
(10181, 2037, 'Sanitasi'),
(10182, 2038, 'Kurir Logistik Ekspedisi'),
(10183, 2038, 'Pengendara Sepeda Motor Harian'),
(10184, 2038, 'Komuter Hujan'),
(10185, 2038, 'Touring'),
(10186, 2039, 'Kurir Logistik Ekspedisi'),
(10187, 2039, 'Pengendara Sepeda Motor Harian'),
(10188, 2039, 'Komuter Hujan'),
(10189, 2039, 'Touring'),
(10190, 2040, 'Kurir Logistik Ekspedisi'),
(10191, 2040, 'Pengendara Sepeda Motor Harian'),
(10192, 2040, 'Komuter Hujan'),
(10193, 2040, 'Touring'),
(10194, 2041, 'Kurir Logistik Ekspedisi'),
(10195, 2041, 'Pengendara Sepeda Motor Harian'),
(10196, 2041, 'Komuter Hujan'),
(10197, 2041, 'Touring'),
(10198, 2042, 'Kurir Logistik Ekspedisi'),
(10199, 2042, 'Pengendara Sepeda Motor Harian'),
(10200, 2042, 'Komuter Hujan'),
(10201, 2042, 'Touring'),
(10202, 2043, 'Kurir Logistik Ekspedisi'),
(10203, 2043, 'Pengendara Sepeda Motor Harian'),
(10204, 2043, 'Komuter Hujan'),
(10205, 2043, 'Touring'),
(10206, 2044, 'Kurir Logistik Ekspedisi'),
(10207, 2044, 'Pengendara Sepeda Motor Harian'),
(10208, 2044, 'Komuter Hujan'),
(10209, 2044, 'Touring'),
(10210, 2045, 'Kurir Logistik Ekspedisi'),
(10211, 2045, 'Pengendara Sepeda Motor Harian'),
(10212, 2045, 'Komuter Hujan'),
(10213, 2045, 'Touring'),
(10214, 2046, 'Kurir Logistik Ekspedisi'),
(10215, 2046, 'Pengendara Sepeda Motor Harian'),
(10216, 2046, 'Komuter Hujan'),
(10217, 2046, 'Touring'),
(10218, 2047, 'Kurir Logistik Ekspedisi'),
(10219, 2047, 'Pengendara Sepeda Motor Harian'),
(10220, 2047, 'Komuter Hujan'),
(10221, 2047, 'Touring'),
(10222, 2048, 'Kurir Logistik Ekspedisi'),
(10223, 2048, 'Pengendara Sepeda Motor Harian'),
(10224, 2048, 'Komuter Hujan'),
(10225, 2048, 'Touring'),
(10226, 2049, 'Kurir Logistik Ekspedisi'),
(10227, 2049, 'Pengendara Sepeda Motor Harian'),
(10228, 2049, 'Komuter Hujan'),
(10229, 2049, 'Touring'),
(10230, 2050, 'Penanganan Banjir Musiman'),
(10231, 2050, 'Dinas Kebersihan & Sanitasi Kota'),
(10232, 2050, 'Pekerjaan Rumah Tangga'),
(10233, 2050, 'Got & Saluran Air'),
(10234, 2051, 'Penanganan Banjir Musiman'),
(10235, 2051, 'Dinas Kebersihan & Sanitasi Kota'),
(10236, 2051, 'Pekerjaan Rumah Tangga'),
(10237, 2051, 'Got & Saluran Air'),
(10238, 2052, 'Penanganan Banjir Musiman'),
(10239, 2052, 'Dinas Kebersihan & Sanitasi Kota'),
(10240, 2052, 'Pekerjaan Rumah Tangga'),
(10241, 2052, 'Got & Saluran Air'),
(10242, 2053, 'Penanganan Banjir Musiman'),
(10243, 2053, 'Dinas Kebersihan & Sanitasi Kota'),
(10244, 2053, 'Pekerjaan Rumah Tangga'),
(10245, 2053, 'Got & Saluran Air'),
(10246, 2054, 'Penanganan Banjir Musiman'),
(10247, 2054, 'Dinas Kebersihan & Sanitasi Kota'),
(10248, 2054, 'Pekerjaan Rumah Tangga'),
(10249, 2054, 'Got & Saluran Air'),
(10250, 2055, 'Penanganan Banjir Musiman');

INSERT INTO `product_use_cases` (`id`, `product_id`, `use_case`) VALUES
(10251, 2055, 'Dinas Kebersihan & Sanitasi Kota'),
(10252, 2055, 'Pekerjaan Rumah Tangga'),
(10253, 2055, 'Got & Saluran Air'),
(10254, 2056, 'Pekerja Lapangan Santai'),
(10255, 2056, 'Gaya Kasual Tahan Air'),
(10256, 2056, 'Komuter Hujan Modis'),
(10257, 2057, 'Penanganan Banjir Musiman'),
(10258, 2057, 'Dinas Kebersihan & Sanitasi Kota'),
(10259, 2057, 'Pekerjaan Rumah Tangga'),
(10260, 2057, 'Got & Saluran Air'),
(10261, 2058, 'Penanganan Banjir Musiman'),
(10262, 2058, 'Dinas Kebersihan & Sanitasi Kota'),
(10263, 2058, 'Pekerjaan Rumah Tangga'),
(10264, 2058, 'Got & Saluran Air'),
(10265, 2059, 'Pekerja Lapangan Santai'),
(10266, 2059, 'Gaya Kasual Tahan Air'),
(10267, 2059, 'Komuter Hujan Modis'),
(10268, 2060, 'Penanganan Banjir Musiman'),
(10269, 2060, 'Dinas Kebersihan & Sanitasi Kota'),
(10270, 2060, 'Pekerjaan Rumah Tangga'),
(10271, 2060, 'Got & Saluran Air'),
(10272, 2061, 'Penanganan Banjir Musiman'),
(10273, 2061, 'Dinas Kebersihan & Sanitasi Kota'),
(10274, 2061, 'Pekerjaan Rumah Tangga'),
(10275, 2061, 'Got & Saluran Air'),
(10276, 2062, 'Penanganan Banjir Musiman'),
(10277, 2062, 'Dinas Kebersihan & Sanitasi Kota'),
(10278, 2062, 'Pekerjaan Rumah Tangga'),
(10279, 2062, 'Got & Saluran Air'),
(10280, 2063, 'Pekerja Lapangan Santai'),
(10281, 2063, 'Gaya Kasual Tahan Air'),
(10282, 2063, 'Komuter Hujan Modis'),
(10283, 2064, 'Penanganan Banjir Musiman'),
(10284, 2064, 'Dinas Kebersihan & Sanitasi Kota'),
(10285, 2064, 'Pekerjaan Rumah Tangga'),
(10286, 2064, 'Got & Saluran Air'),
(10287, 2065, 'Penanganan Banjir Musiman'),
(10288, 2065, 'Dinas Kebersihan & Sanitasi Kota'),
(10289, 2065, 'Pekerjaan Rumah Tangga'),
(10290, 2065, 'Got & Saluran Air'),
(10291, 2066, 'Penanganan Banjir Musiman'),
(10292, 2066, 'Dinas Kebersihan & Sanitasi Kota'),
(10293, 2066, 'Pekerjaan Rumah Tangga'),
(10294, 2066, 'Got & Saluran Air'),
(10295, 2067, 'Penanganan Banjir Musiman'),
(10296, 2067, 'Dinas Kebersihan & Sanitasi Kota'),
(10297, 2067, 'Pekerjaan Rumah Tangga'),
(10298, 2067, 'Got & Saluran Air'),
(10299, 2068, 'Pekerja Lapangan Santai'),
(10300, 2068, 'Gaya Kasual Tahan Air'),
(10301, 2068, 'Komuter Hujan Modis'),
(10302, 2069, 'Pekerja Lapangan Santai'),
(10303, 2069, 'Gaya Kasual Tahan Air'),
(10304, 2069, 'Komuter Hujan Modis'),
(10305, 2070, 'Penanganan Banjir Musiman'),
(10306, 2070, 'Dinas Kebersihan & Sanitasi Kota'),
(10307, 2070, 'Pekerjaan Rumah Tangga'),
(10308, 2070, 'Got & Saluran Air'),
(10309, 2071, 'Penanganan Banjir Musiman'),
(10310, 2071, 'Dinas Kebersihan & Sanitasi Kota'),
(10311, 2071, 'Pekerjaan Rumah Tangga'),
(10312, 2071, 'Got & Saluran Air'),
(10313, 2072, 'Penanganan Banjir Musiman'),
(10314, 2072, 'Dinas Kebersihan & Sanitasi Kota'),
(10315, 2072, 'Pekerjaan Rumah Tangga'),
(10316, 2072, 'Got & Saluran Air'),
(10317, 2073, 'Penanganan Banjir Musiman'),
(10318, 2073, 'Dinas Kebersihan & Sanitasi Kota'),
(10319, 2073, 'Pekerjaan Rumah Tangga'),
(10320, 2073, 'Got & Saluran Air'),
(10321, 2074, 'Penanganan Banjir Musiman'),
(10322, 2074, 'Dinas Kebersihan & Sanitasi Kota'),
(10323, 2074, 'Pekerjaan Rumah Tangga'),
(10324, 2074, 'Got & Saluran Air'),
(10325, 2075, 'Penanganan Banjir Musiman'),
(10326, 2075, 'Dinas Kebersihan & Sanitasi Kota'),
(10327, 2075, 'Pekerjaan Rumah Tangga'),
(10328, 2075, 'Got & Saluran Air'),
(10329, 2076, 'Penanganan Banjir Musiman'),
(10330, 2076, 'Dinas Kebersihan & Sanitasi Kota'),
(10331, 2076, 'Pekerjaan Rumah Tangga'),
(10332, 2076, 'Got & Saluran Air'),
(10333, 2077, 'Penanganan Banjir Musiman'),
(10334, 2077, 'Dinas Kebersihan & Sanitasi Kota'),
(10335, 2077, 'Pekerjaan Rumah Tangga'),
(10336, 2077, 'Got & Saluran Air'),
(10337, 2078, 'Anak Sekolah Musim Hujan'),
(10338, 2078, 'Aktivitas Luar Ruangan Taman'),
(10339, 2078, 'Bermain Genangan Air Bersih'),
(10340, 2079, 'Anak Sekolah Musim Hujan'),
(10341, 2079, 'Aktivitas Luar Ruangan Taman'),
(10342, 2079, 'Bermain Genangan Air Bersih'),
(10343, 2080, 'Anak Sekolah Musim Hujan'),
(10344, 2080, 'Aktivitas Luar Ruangan Taman'),
(10345, 2080, 'Bermain Genangan Air Bersih'),
(10346, 2081, 'Anak Sekolah Musim Hujan'),
(10347, 2081, 'Aktivitas Luar Ruangan Taman'),
(10348, 2081, 'Bermain Genangan Air Bersih'),
(10349, 2082, 'Anak Sekolah Musim Hujan'),
(10350, 2082, 'Aktivitas Luar Ruangan Taman'),
(10351, 2082, 'Bermain Genangan Air Bersih'),
(10352, 2083, 'Anak Sekolah Musim Hujan'),
(10353, 2083, 'Aktivitas Luar Ruangan Taman'),
(10354, 2083, 'Bermain Genangan Air Bersih'),
(10355, 2084, 'Anak Sekolah Musim Hujan'),
(10356, 2084, 'Aktivitas Luar Ruangan Taman'),
(10357, 2084, 'Bermain Genangan Air Bersih'),
(10358, 2085, 'Anak Sekolah Musim Hujan'),
(10359, 2085, 'Aktivitas Luar Ruangan Taman'),
(10360, 2085, 'Bermain Genangan Air Bersih'),
(10361, 2086, 'Anak Sekolah Musim Hujan'),
(10362, 2086, 'Aktivitas Luar Ruangan Taman'),
(10363, 2086, 'Bermain Genangan Air Bersih'),
(10364, 2087, 'Anak Sekolah Musim Hujan'),
(10365, 2087, 'Aktivitas Luar Ruangan Taman'),
(10366, 2087, 'Bermain Genangan Air Bersih'),
(10367, 2088, 'Anak Sekolah Musim Hujan'),
(10368, 2088, 'Aktivitas Luar Ruangan Taman'),
(10369, 2088, 'Bermain Genangan Air Bersih'),
(10370, 2089, 'Anak Sekolah Musim Hujan'),
(10371, 2089, 'Aktivitas Luar Ruangan Taman'),
(10372, 2089, 'Bermain Genangan Air Bersih'),
(10373, 2090, 'Anak Sekolah Musim Hujan'),
(10374, 2090, 'Aktivitas Luar Ruangan Taman'),
(10375, 2090, 'Bermain Genangan Air Bersih'),
(10376, 2091, 'Area Basah Kolam Renang'),
(10377, 2091, 'Kasir Supermarket'),
(10378, 2091, 'Santai Harian'),
(10379, 2091, 'Pekerja Pasar Tradisional'),
(10380, 2092, 'Area Basah Kolam Renang'),
(10381, 2092, 'Kasir Supermarket'),
(10382, 2092, 'Santai Harian'),
(10383, 2092, 'Pekerja Pasar Tradisional'),
(10384, 2093, 'Area Basah Kolam Renang'),
(10385, 2093, 'Kasir Supermarket'),
(10386, 2093, 'Santai Harian'),
(10387, 2093, 'Pekerja Pasar Tradisional'),
(10388, 2094, 'Area Basah Kolam Renang'),
(10389, 2094, 'Kasir Supermarket'),
(10390, 2094, 'Santai Harian'),
(10391, 2094, 'Pekerja Pasar Tradisional'),
(10392, 2095, 'Area Basah Kolam Renang'),
(10393, 2095, 'Kasir Supermarket'),
(10394, 2095, 'Santai Harian'),
(10395, 2095, 'Pekerja Pasar Tradisional'),
(10396, 2096, 'Area Basah Kolam Renang'),
(10397, 2096, 'Kasir Supermarket'),
(10398, 2096, 'Santai Harian'),
(10399, 2096, 'Pekerja Pasar Tradisional'),
(10400, 2097, 'Area Basah Kolam Renang'),
(10401, 2097, 'Kasir Supermarket'),
(10402, 2097, 'Santai Harian'),
(10403, 2097, 'Pekerja Pasar Tradisional'),
(10404, 2098, 'Area Basah Kolam Renang'),
(10405, 2098, 'Kasir Supermarket'),
(10406, 2098, 'Santai Harian'),
(10407, 2098, 'Pekerja Pasar Tradisional'),
(10408, 2099, 'Area Basah Kolam Renang'),
(10409, 2099, 'Kasir Supermarket'),
(10410, 2099, 'Santai Harian'),
(10411, 2099, 'Pekerja Pasar Tradisional'),
(10412, 2100, 'Area Basah Kolam Renang'),
(10413, 2100, 'Kasir Supermarket'),
(10414, 2100, 'Santai Harian'),
(10415, 2100, 'Pekerja Pasar Tradisional'),
(10416, 2101, 'Area Basah Kolam Renang'),
(10417, 2101, 'Kasir Supermarket'),
(10418, 2101, 'Santai Harian'),
(10419, 2101, 'Pekerja Pasar Tradisional'),
(10420, 2102, 'Area Basah Kolam Renang'),
(10421, 2102, 'Kasir Supermarket'),
(10422, 2102, 'Santai Harian'),
(10423, 2102, 'Pekerja Pasar Tradisional'),
(10424, 2103, 'Area Basah Kolam Renang'),
(10425, 2103, 'Kasir Supermarket'),
(10426, 2103, 'Santai Harian'),
(10427, 2103, 'Pekerja Pasar Tradisional'),
(10428, 2104, 'Area Basah Kolam Renang'),
(10429, 2104, 'Kasir Supermarket'),
(10430, 2104, 'Santai Harian'),
(10431, 2104, 'Pekerja Pasar Tradisional'),
(10432, 2105, 'Pekerja Lapangan Santai'),
(10433, 2105, 'Gaya Kasual Tahan Air'),
(10434, 2105, 'Komuter Hujan Modis'),
(10435, 2106, 'Pekerja Lapangan Santai'),
(10436, 2106, 'Gaya Kasual Tahan Air'),
(10437, 2106, 'Komuter Hujan Modis'),
(10438, 2107, 'Pertambangan Tambang Terbuka'),
(10439, 2107, 'Galangan Kapal'),
(10440, 2107, 'Kilang Minyak'),
(10441, 2107, 'Pengecoran Logam'),
(10442, 2107, 'Konstruksi Jalan Tol'),
(10443, 2108, 'Pertambangan Tambang Terbuka'),
(10444, 2108, 'Galangan Kapal'),
(10445, 2108, 'Kilang Minyak'),
(10446, 2108, 'Pengecoran Logam'),
(10447, 2108, 'Konstruksi Jalan Tol'),
(10448, 2109, 'Pertambangan Tambang Terbuka'),
(10449, 2109, 'Galangan Kapal'),
(10450, 2109, 'Kilang Minyak'),
(10451, 2109, 'Pengecoran Logam'),
(10452, 2109, 'Konstruksi Jalan Tol'),
(10453, 2110, 'Pertambangan Tambang Terbuka'),
(10454, 2110, 'Galangan Kapal'),
(10455, 2110, 'Kilang Minyak'),
(10456, 2110, 'Pengecoran Logam'),
(10457, 2110, 'Konstruksi Jalan Tol'),
(10458, 2111, 'Pertambangan Tambang Terbuka'),
(10459, 2111, 'Galangan Kapal'),
(10460, 2111, 'Kilang Minyak'),
(10461, 2111, 'Pengecoran Logam'),
(10462, 2111, 'Konstruksi Jalan Tol'),
(10463, 2112, 'Pertambangan Tambang Terbuka'),
(10464, 2112, 'Galangan Kapal'),
(10465, 2112, 'Kilang Minyak'),
(10466, 2112, 'Pengecoran Logam'),
(10467, 2112, 'Konstruksi Jalan Tol'),
(10468, 2113, 'Pertambangan Tambang Terbuka'),
(10469, 2113, 'Galangan Kapal'),
(10470, 2113, 'Kilang Minyak'),
(10471, 2113, 'Pengecoran Logam'),
(10472, 2113, 'Konstruksi Jalan Tol'),
(10473, 2114, 'Pertambangan Tambang Terbuka'),
(10474, 2114, 'Galangan Kapal'),
(10475, 2114, 'Kilang Minyak'),
(10476, 2114, 'Pengecoran Logam'),
(10477, 2114, 'Konstruksi Jalan Tol'),
(10478, 2115, 'Pertambangan Tambang Terbuka'),
(10479, 2115, 'Galangan Kapal'),
(10480, 2115, 'Kilang Minyak'),
(10481, 2115, 'Pengecoran Logam'),
(10482, 2115, 'Konstruksi Jalan Tol'),
(10483, 2116, 'Pertambangan Tambang Terbuka'),
(10484, 2116, 'Galangan Kapal'),
(10485, 2116, 'Kilang Minyak'),
(10486, 2116, 'Pengecoran Logam'),
(10487, 2116, 'Konstruksi Jalan Tol'),
(10488, 2117, 'Pertambangan Tambang Terbuka'),
(10489, 2117, 'Galangan Kapal'),
(10490, 2117, 'Kilang Minyak'),
(10491, 2117, 'Pengecoran Logam'),
(10492, 2117, 'Konstruksi Jalan Tol'),
(10493, 2118, 'Pertambangan Tambang Terbuka'),
(10494, 2118, 'Galangan Kapal'),
(10495, 2118, 'Kilang Minyak'),
(10496, 2118, 'Pengecoran Logam'),
(10497, 2118, 'Konstruksi Jalan Tol'),
(10498, 2119, 'Pertambangan Tambang Terbuka'),
(10499, 2119, 'Galangan Kapal'),
(10500, 2119, 'Kilang Minyak');

INSERT INTO `product_use_cases` (`id`, `product_id`, `use_case`) VALUES
(10501, 2119, 'Pengecoran Logam'),
(10502, 2119, 'Konstruksi Jalan Tol'),
(10503, 2120, 'Pertambangan Tambang Terbuka'),
(10504, 2120, 'Galangan Kapal'),
(10505, 2120, 'Kilang Minyak'),
(10506, 2120, 'Pengecoran Logam'),
(10507, 2120, 'Konstruksi Jalan Tol'),
(10508, 2121, 'Pertambangan Tambang Terbuka'),
(10509, 2121, 'Galangan Kapal'),
(10510, 2121, 'Kilang Minyak'),
(10511, 2121, 'Pengecoran Logam'),
(10512, 2121, 'Konstruksi Jalan Tol'),
(10513, 2122, 'Pertambangan Tambang Terbuka'),
(10514, 2122, 'Galangan Kapal'),
(10515, 2122, 'Kilang Minyak'),
(10516, 2122, 'Pengecoran Logam'),
(10517, 2122, 'Konstruksi Jalan Tol'),
(10518, 2123, 'Pertambangan Tambang Terbuka'),
(10519, 2123, 'Galangan Kapal'),
(10520, 2123, 'Kilang Minyak'),
(10521, 2123, 'Pengecoran Logam'),
(10522, 2123, 'Konstruksi Jalan Tol'),
(10523, 2124, 'Pertambangan Tambang Terbuka'),
(10524, 2124, 'Galangan Kapal'),
(10525, 2124, 'Kilang Minyak'),
(10526, 2124, 'Pengecoran Logam'),
(10527, 2124, 'Konstruksi Jalan Tol'),
(10528, 2125, 'Pertambangan Tambang Terbuka'),
(10529, 2125, 'Galangan Kapal'),
(10530, 2125, 'Kilang Minyak'),
(10531, 2125, 'Pengecoran Logam'),
(10532, 2125, 'Konstruksi Jalan Tol');

-- -------------------------------------------------------------
-- 7. PRODUCT TARGET EXPORT REGIONS (625 rows)
-- -------------------------------------------------------------
INSERT INTO `product_regions` (`id`, `product_id`, `region`) VALUES
(10001, 2001, 'Europe (Germany, Netherlands, UK, France)'),
(10002, 2001, 'North America (United States, Canada)'),
(10003, 2001, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10004, 2001, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10005, 2001, 'Oceania (Australia, New Zealand)'),
(10006, 2002, 'Europe (Germany, Netherlands, UK, France)'),
(10007, 2002, 'North America (United States, Canada)'),
(10008, 2002, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10009, 2002, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10010, 2002, 'Oceania (Australia, New Zealand)'),
(10011, 2003, 'Europe (Germany, Netherlands, UK, France)'),
(10012, 2003, 'North America (United States, Canada)'),
(10013, 2003, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10014, 2003, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10015, 2003, 'Oceania (Australia, New Zealand)'),
(10016, 2004, 'Europe (Germany, Netherlands, UK, France)'),
(10017, 2004, 'North America (United States, Canada)'),
(10018, 2004, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10019, 2004, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10020, 2004, 'Oceania (Australia, New Zealand)'),
(10021, 2005, 'Europe (Germany, Netherlands, UK, France)'),
(10022, 2005, 'North America (United States, Canada)'),
(10023, 2005, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10024, 2005, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10025, 2005, 'Oceania (Australia, New Zealand)'),
(10026, 2006, 'Europe (Germany, Netherlands, UK, France)'),
(10027, 2006, 'North America (United States, Canada)'),
(10028, 2006, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10029, 2006, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10030, 2006, 'Oceania (Australia, New Zealand)'),
(10031, 2007, 'Europe (Germany, Netherlands, UK, France)'),
(10032, 2007, 'North America (United States, Canada)'),
(10033, 2007, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10034, 2007, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10035, 2007, 'Oceania (Australia, New Zealand)'),
(10036, 2008, 'Europe (Germany, Netherlands, UK, France)'),
(10037, 2008, 'North America (United States, Canada)'),
(10038, 2008, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10039, 2008, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10040, 2008, 'Oceania (Australia, New Zealand)'),
(10041, 2009, 'Europe (Germany, Netherlands, UK, France)'),
(10042, 2009, 'North America (United States, Canada)'),
(10043, 2009, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10044, 2009, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10045, 2009, 'Oceania (Australia, New Zealand)'),
(10046, 2010, 'Europe (Germany, Netherlands, UK, France)'),
(10047, 2010, 'North America (United States, Canada)'),
(10048, 2010, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10049, 2010, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10050, 2010, 'Oceania (Australia, New Zealand)'),
(10051, 2011, 'Europe (Germany, Netherlands, UK, France)'),
(10052, 2011, 'North America (United States, Canada)'),
(10053, 2011, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10054, 2011, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10055, 2011, 'Oceania (Australia, New Zealand)'),
(10056, 2012, 'Europe (Germany, Netherlands, UK, France)'),
(10057, 2012, 'North America (United States, Canada)'),
(10058, 2012, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10059, 2012, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10060, 2012, 'Oceania (Australia, New Zealand)'),
(10061, 2013, 'Europe (Germany, Netherlands, UK, France)'),
(10062, 2013, 'North America (United States, Canada)'),
(10063, 2013, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10064, 2013, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10065, 2013, 'Oceania (Australia, New Zealand)'),
(10066, 2014, 'Europe (Germany, Netherlands, UK, France)'),
(10067, 2014, 'North America (United States, Canada)'),
(10068, 2014, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10069, 2014, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10070, 2014, 'Oceania (Australia, New Zealand)'),
(10071, 2015, 'Europe (Germany, Netherlands, UK, France)'),
(10072, 2015, 'North America (United States, Canada)'),
(10073, 2015, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10074, 2015, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10075, 2015, 'Oceania (Australia, New Zealand)'),
(10076, 2016, 'Europe (Germany, Netherlands, UK, France)'),
(10077, 2016, 'North America (United States, Canada)'),
(10078, 2016, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10079, 2016, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10080, 2016, 'Oceania (Australia, New Zealand)'),
(10081, 2017, 'Europe (Germany, Netherlands, UK, France)'),
(10082, 2017, 'North America (United States, Canada)'),
(10083, 2017, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10084, 2017, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10085, 2017, 'Oceania (Australia, New Zealand)'),
(10086, 2018, 'Europe (Germany, Netherlands, UK, France)'),
(10087, 2018, 'North America (United States, Canada)'),
(10088, 2018, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10089, 2018, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10090, 2018, 'Oceania (Australia, New Zealand)'),
(10091, 2019, 'Europe (Germany, Netherlands, UK, France)'),
(10092, 2019, 'North America (United States, Canada)'),
(10093, 2019, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10094, 2019, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10095, 2019, 'Oceania (Australia, New Zealand)'),
(10096, 2020, 'Europe (Germany, Netherlands, UK, France)'),
(10097, 2020, 'North America (United States, Canada)'),
(10098, 2020, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10099, 2020, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10100, 2020, 'Oceania (Australia, New Zealand)'),
(10101, 2021, 'Europe (Germany, Netherlands, UK, France)'),
(10102, 2021, 'North America (United States, Canada)'),
(10103, 2021, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10104, 2021, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10105, 2021, 'Oceania (Australia, New Zealand)'),
(10106, 2022, 'Europe (Germany, Netherlands, UK, France)'),
(10107, 2022, 'North America (United States, Canada)'),
(10108, 2022, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10109, 2022, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10110, 2022, 'Oceania (Australia, New Zealand)'),
(10111, 2023, 'Europe (Germany, Netherlands, UK, France)'),
(10112, 2023, 'North America (United States, Canada)'),
(10113, 2023, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10114, 2023, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10115, 2023, 'Oceania (Australia, New Zealand)'),
(10116, 2024, 'Europe (Germany, Netherlands, UK, France)'),
(10117, 2024, 'North America (United States, Canada)'),
(10118, 2024, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10119, 2024, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10120, 2024, 'Oceania (Australia, New Zealand)'),
(10121, 2025, 'Europe (Germany, Netherlands, UK, France)'),
(10122, 2025, 'North America (United States, Canada)'),
(10123, 2025, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10124, 2025, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10125, 2025, 'Oceania (Australia, New Zealand)'),
(10126, 2026, 'Europe (Germany, Netherlands, UK, France)'),
(10127, 2026, 'North America (United States, Canada)'),
(10128, 2026, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10129, 2026, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10130, 2026, 'Oceania (Australia, New Zealand)'),
(10131, 2027, 'Europe (Germany, Netherlands, UK, France)'),
(10132, 2027, 'North America (United States, Canada)'),
(10133, 2027, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10134, 2027, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10135, 2027, 'Oceania (Australia, New Zealand)'),
(10136, 2028, 'Europe (Germany, Netherlands, UK, France)'),
(10137, 2028, 'North America (United States, Canada)'),
(10138, 2028, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10139, 2028, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10140, 2028, 'Oceania (Australia, New Zealand)'),
(10141, 2029, 'Europe (Germany, Netherlands, UK, France)'),
(10142, 2029, 'North America (United States, Canada)'),
(10143, 2029, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10144, 2029, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10145, 2029, 'Oceania (Australia, New Zealand)'),
(10146, 2030, 'Europe (Germany, Netherlands, UK, France)'),
(10147, 2030, 'North America (United States, Canada)'),
(10148, 2030, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10149, 2030, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10150, 2030, 'Oceania (Australia, New Zealand)'),
(10151, 2031, 'Europe (Germany, Netherlands, UK, France)'),
(10152, 2031, 'North America (United States, Canada)'),
(10153, 2031, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10154, 2031, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10155, 2031, 'Oceania (Australia, New Zealand)'),
(10156, 2032, 'Europe (Germany, Netherlands, UK, France)'),
(10157, 2032, 'North America (United States, Canada)'),
(10158, 2032, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10159, 2032, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10160, 2032, 'Oceania (Australia, New Zealand)'),
(10161, 2033, 'Europe (Germany, Netherlands, UK, France)'),
(10162, 2033, 'North America (United States, Canada)'),
(10163, 2033, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10164, 2033, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10165, 2033, 'Oceania (Australia, New Zealand)'),
(10166, 2034, 'Europe (Germany, Netherlands, UK, France)'),
(10167, 2034, 'North America (United States, Canada)'),
(10168, 2034, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10169, 2034, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10170, 2034, 'Oceania (Australia, New Zealand)'),
(10171, 2035, 'Europe (Germany, Netherlands, UK, France)'),
(10172, 2035, 'North America (United States, Canada)'),
(10173, 2035, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10174, 2035, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10175, 2035, 'Oceania (Australia, New Zealand)'),
(10176, 2036, 'Europe (Germany, Netherlands, UK, France)'),
(10177, 2036, 'North America (United States, Canada)'),
(10178, 2036, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10179, 2036, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10180, 2036, 'Oceania (Australia, New Zealand)'),
(10181, 2037, 'Europe (Germany, Netherlands, UK, France)'),
(10182, 2037, 'North America (United States, Canada)'),
(10183, 2037, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10184, 2037, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10185, 2037, 'Oceania (Australia, New Zealand)'),
(10186, 2038, 'Europe (Germany, Netherlands, UK, France)'),
(10187, 2038, 'North America (United States, Canada)'),
(10188, 2038, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10189, 2038, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10190, 2038, 'Oceania (Australia, New Zealand)'),
(10191, 2039, 'Europe (Germany, Netherlands, UK, France)'),
(10192, 2039, 'North America (United States, Canada)'),
(10193, 2039, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10194, 2039, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10195, 2039, 'Oceania (Australia, New Zealand)'),
(10196, 2040, 'Europe (Germany, Netherlands, UK, France)'),
(10197, 2040, 'North America (United States, Canada)'),
(10198, 2040, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10199, 2040, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10200, 2040, 'Oceania (Australia, New Zealand)'),
(10201, 2041, 'Europe (Germany, Netherlands, UK, France)'),
(10202, 2041, 'North America (United States, Canada)'),
(10203, 2041, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10204, 2041, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10205, 2041, 'Oceania (Australia, New Zealand)'),
(10206, 2042, 'Europe (Germany, Netherlands, UK, France)'),
(10207, 2042, 'North America (United States, Canada)'),
(10208, 2042, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10209, 2042, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10210, 2042, 'Oceania (Australia, New Zealand)'),
(10211, 2043, 'Europe (Germany, Netherlands, UK, France)'),
(10212, 2043, 'North America (United States, Canada)'),
(10213, 2043, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10214, 2043, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10215, 2043, 'Oceania (Australia, New Zealand)'),
(10216, 2044, 'Europe (Germany, Netherlands, UK, France)'),
(10217, 2044, 'North America (United States, Canada)'),
(10218, 2044, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10219, 2044, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10220, 2044, 'Oceania (Australia, New Zealand)'),
(10221, 2045, 'Europe (Germany, Netherlands, UK, France)'),
(10222, 2045, 'North America (United States, Canada)'),
(10223, 2045, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10224, 2045, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10225, 2045, 'Oceania (Australia, New Zealand)'),
(10226, 2046, 'Europe (Germany, Netherlands, UK, France)'),
(10227, 2046, 'North America (United States, Canada)'),
(10228, 2046, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10229, 2046, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10230, 2046, 'Oceania (Australia, New Zealand)'),
(10231, 2047, 'Europe (Germany, Netherlands, UK, France)'),
(10232, 2047, 'North America (United States, Canada)'),
(10233, 2047, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10234, 2047, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10235, 2047, 'Oceania (Australia, New Zealand)'),
(10236, 2048, 'Europe (Germany, Netherlands, UK, France)'),
(10237, 2048, 'North America (United States, Canada)'),
(10238, 2048, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10239, 2048, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10240, 2048, 'Oceania (Australia, New Zealand)'),
(10241, 2049, 'Europe (Germany, Netherlands, UK, France)'),
(10242, 2049, 'North America (United States, Canada)'),
(10243, 2049, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10244, 2049, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10245, 2049, 'Oceania (Australia, New Zealand)'),
(10246, 2050, 'Europe (Germany, Netherlands, UK, France)'),
(10247, 2050, 'North America (United States, Canada)'),
(10248, 2050, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10249, 2050, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10250, 2050, 'Oceania (Australia, New Zealand)');

INSERT INTO `product_regions` (`id`, `product_id`, `region`) VALUES
(10251, 2051, 'Europe (Germany, Netherlands, UK, France)'),
(10252, 2051, 'North America (United States, Canada)'),
(10253, 2051, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10254, 2051, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10255, 2051, 'Oceania (Australia, New Zealand)'),
(10256, 2052, 'Europe (Germany, Netherlands, UK, France)'),
(10257, 2052, 'North America (United States, Canada)'),
(10258, 2052, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10259, 2052, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10260, 2052, 'Oceania (Australia, New Zealand)'),
(10261, 2053, 'Europe (Germany, Netherlands, UK, France)'),
(10262, 2053, 'North America (United States, Canada)'),
(10263, 2053, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10264, 2053, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10265, 2053, 'Oceania (Australia, New Zealand)'),
(10266, 2054, 'Europe (Germany, Netherlands, UK, France)'),
(10267, 2054, 'North America (United States, Canada)'),
(10268, 2054, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10269, 2054, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10270, 2054, 'Oceania (Australia, New Zealand)'),
(10271, 2055, 'Europe (Germany, Netherlands, UK, France)'),
(10272, 2055, 'North America (United States, Canada)'),
(10273, 2055, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10274, 2055, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10275, 2055, 'Oceania (Australia, New Zealand)'),
(10276, 2056, 'Europe (Germany, Netherlands, UK, France)'),
(10277, 2056, 'North America (United States, Canada)'),
(10278, 2056, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10279, 2056, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10280, 2056, 'Oceania (Australia, New Zealand)'),
(10281, 2057, 'Europe (Germany, Netherlands, UK, France)'),
(10282, 2057, 'North America (United States, Canada)'),
(10283, 2057, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10284, 2057, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10285, 2057, 'Oceania (Australia, New Zealand)'),
(10286, 2058, 'Europe (Germany, Netherlands, UK, France)'),
(10287, 2058, 'North America (United States, Canada)'),
(10288, 2058, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10289, 2058, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10290, 2058, 'Oceania (Australia, New Zealand)'),
(10291, 2059, 'Europe (Germany, Netherlands, UK, France)'),
(10292, 2059, 'North America (United States, Canada)'),
(10293, 2059, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10294, 2059, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10295, 2059, 'Oceania (Australia, New Zealand)'),
(10296, 2060, 'Europe (Germany, Netherlands, UK, France)'),
(10297, 2060, 'North America (United States, Canada)'),
(10298, 2060, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10299, 2060, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10300, 2060, 'Oceania (Australia, New Zealand)'),
(10301, 2061, 'Europe (Germany, Netherlands, UK, France)'),
(10302, 2061, 'North America (United States, Canada)'),
(10303, 2061, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10304, 2061, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10305, 2061, 'Oceania (Australia, New Zealand)'),
(10306, 2062, 'Europe (Germany, Netherlands, UK, France)'),
(10307, 2062, 'North America (United States, Canada)'),
(10308, 2062, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10309, 2062, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10310, 2062, 'Oceania (Australia, New Zealand)'),
(10311, 2063, 'Europe (Germany, Netherlands, UK, France)'),
(10312, 2063, 'North America (United States, Canada)'),
(10313, 2063, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10314, 2063, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10315, 2063, 'Oceania (Australia, New Zealand)'),
(10316, 2064, 'Europe (Germany, Netherlands, UK, France)'),
(10317, 2064, 'North America (United States, Canada)'),
(10318, 2064, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10319, 2064, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10320, 2064, 'Oceania (Australia, New Zealand)'),
(10321, 2065, 'Europe (Germany, Netherlands, UK, France)'),
(10322, 2065, 'North America (United States, Canada)'),
(10323, 2065, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10324, 2065, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10325, 2065, 'Oceania (Australia, New Zealand)'),
(10326, 2066, 'Europe (Germany, Netherlands, UK, France)'),
(10327, 2066, 'North America (United States, Canada)'),
(10328, 2066, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10329, 2066, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10330, 2066, 'Oceania (Australia, New Zealand)'),
(10331, 2067, 'Europe (Germany, Netherlands, UK, France)'),
(10332, 2067, 'North America (United States, Canada)'),
(10333, 2067, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10334, 2067, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10335, 2067, 'Oceania (Australia, New Zealand)'),
(10336, 2068, 'Europe (Germany, Netherlands, UK, France)'),
(10337, 2068, 'North America (United States, Canada)'),
(10338, 2068, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10339, 2068, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10340, 2068, 'Oceania (Australia, New Zealand)'),
(10341, 2069, 'Europe (Germany, Netherlands, UK, France)'),
(10342, 2069, 'North America (United States, Canada)'),
(10343, 2069, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10344, 2069, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10345, 2069, 'Oceania (Australia, New Zealand)'),
(10346, 2070, 'Europe (Germany, Netherlands, UK, France)'),
(10347, 2070, 'North America (United States, Canada)'),
(10348, 2070, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10349, 2070, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10350, 2070, 'Oceania (Australia, New Zealand)'),
(10351, 2071, 'Europe (Germany, Netherlands, UK, France)'),
(10352, 2071, 'North America (United States, Canada)'),
(10353, 2071, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10354, 2071, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10355, 2071, 'Oceania (Australia, New Zealand)'),
(10356, 2072, 'Europe (Germany, Netherlands, UK, France)'),
(10357, 2072, 'North America (United States, Canada)'),
(10358, 2072, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10359, 2072, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10360, 2072, 'Oceania (Australia, New Zealand)'),
(10361, 2073, 'Europe (Germany, Netherlands, UK, France)'),
(10362, 2073, 'North America (United States, Canada)'),
(10363, 2073, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10364, 2073, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10365, 2073, 'Oceania (Australia, New Zealand)'),
(10366, 2074, 'Europe (Germany, Netherlands, UK, France)'),
(10367, 2074, 'North America (United States, Canada)'),
(10368, 2074, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10369, 2074, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10370, 2074, 'Oceania (Australia, New Zealand)'),
(10371, 2075, 'Europe (Germany, Netherlands, UK, France)'),
(10372, 2075, 'North America (United States, Canada)'),
(10373, 2075, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10374, 2075, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10375, 2075, 'Oceania (Australia, New Zealand)'),
(10376, 2076, 'Europe (Germany, Netherlands, UK, France)'),
(10377, 2076, 'North America (United States, Canada)'),
(10378, 2076, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10379, 2076, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10380, 2076, 'Oceania (Australia, New Zealand)'),
(10381, 2077, 'Europe (Germany, Netherlands, UK, France)'),
(10382, 2077, 'North America (United States, Canada)'),
(10383, 2077, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10384, 2077, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10385, 2077, 'Oceania (Australia, New Zealand)'),
(10386, 2078, 'Europe (Germany, Netherlands, UK, France)'),
(10387, 2078, 'North America (United States, Canada)'),
(10388, 2078, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10389, 2078, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10390, 2078, 'Oceania (Australia, New Zealand)'),
(10391, 2079, 'Europe (Germany, Netherlands, UK, France)'),
(10392, 2079, 'North America (United States, Canada)'),
(10393, 2079, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10394, 2079, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10395, 2079, 'Oceania (Australia, New Zealand)'),
(10396, 2080, 'Europe (Germany, Netherlands, UK, France)'),
(10397, 2080, 'North America (United States, Canada)'),
(10398, 2080, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10399, 2080, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10400, 2080, 'Oceania (Australia, New Zealand)'),
(10401, 2081, 'Europe (Germany, Netherlands, UK, France)'),
(10402, 2081, 'North America (United States, Canada)'),
(10403, 2081, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10404, 2081, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10405, 2081, 'Oceania (Australia, New Zealand)'),
(10406, 2082, 'Europe (Germany, Netherlands, UK, France)'),
(10407, 2082, 'North America (United States, Canada)'),
(10408, 2082, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10409, 2082, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10410, 2082, 'Oceania (Australia, New Zealand)'),
(10411, 2083, 'Europe (Germany, Netherlands, UK, France)'),
(10412, 2083, 'North America (United States, Canada)'),
(10413, 2083, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10414, 2083, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10415, 2083, 'Oceania (Australia, New Zealand)'),
(10416, 2084, 'Europe (Germany, Netherlands, UK, France)'),
(10417, 2084, 'North America (United States, Canada)'),
(10418, 2084, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10419, 2084, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10420, 2084, 'Oceania (Australia, New Zealand)'),
(10421, 2085, 'Europe (Germany, Netherlands, UK, France)'),
(10422, 2085, 'North America (United States, Canada)'),
(10423, 2085, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10424, 2085, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10425, 2085, 'Oceania (Australia, New Zealand)'),
(10426, 2086, 'Europe (Germany, Netherlands, UK, France)'),
(10427, 2086, 'North America (United States, Canada)'),
(10428, 2086, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10429, 2086, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10430, 2086, 'Oceania (Australia, New Zealand)'),
(10431, 2087, 'Europe (Germany, Netherlands, UK, France)'),
(10432, 2087, 'North America (United States, Canada)'),
(10433, 2087, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10434, 2087, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10435, 2087, 'Oceania (Australia, New Zealand)'),
(10436, 2088, 'Europe (Germany, Netherlands, UK, France)'),
(10437, 2088, 'North America (United States, Canada)'),
(10438, 2088, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10439, 2088, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10440, 2088, 'Oceania (Australia, New Zealand)'),
(10441, 2089, 'Europe (Germany, Netherlands, UK, France)'),
(10442, 2089, 'North America (United States, Canada)'),
(10443, 2089, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10444, 2089, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10445, 2089, 'Oceania (Australia, New Zealand)'),
(10446, 2090, 'Europe (Germany, Netherlands, UK, France)'),
(10447, 2090, 'North America (United States, Canada)'),
(10448, 2090, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10449, 2090, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10450, 2090, 'Oceania (Australia, New Zealand)'),
(10451, 2091, 'Europe (Germany, Netherlands, UK, France)'),
(10452, 2091, 'North America (United States, Canada)'),
(10453, 2091, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10454, 2091, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10455, 2091, 'Oceania (Australia, New Zealand)'),
(10456, 2092, 'Europe (Germany, Netherlands, UK, France)'),
(10457, 2092, 'North America (United States, Canada)'),
(10458, 2092, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10459, 2092, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10460, 2092, 'Oceania (Australia, New Zealand)'),
(10461, 2093, 'Europe (Germany, Netherlands, UK, France)'),
(10462, 2093, 'North America (United States, Canada)'),
(10463, 2093, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10464, 2093, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10465, 2093, 'Oceania (Australia, New Zealand)'),
(10466, 2094, 'Europe (Germany, Netherlands, UK, France)'),
(10467, 2094, 'North America (United States, Canada)'),
(10468, 2094, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10469, 2094, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10470, 2094, 'Oceania (Australia, New Zealand)'),
(10471, 2095, 'Europe (Germany, Netherlands, UK, France)'),
(10472, 2095, 'North America (United States, Canada)'),
(10473, 2095, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10474, 2095, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10475, 2095, 'Oceania (Australia, New Zealand)'),
(10476, 2096, 'Europe (Germany, Netherlands, UK, France)'),
(10477, 2096, 'North America (United States, Canada)'),
(10478, 2096, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10479, 2096, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10480, 2096, 'Oceania (Australia, New Zealand)'),
(10481, 2097, 'Europe (Germany, Netherlands, UK, France)'),
(10482, 2097, 'North America (United States, Canada)'),
(10483, 2097, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10484, 2097, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10485, 2097, 'Oceania (Australia, New Zealand)'),
(10486, 2098, 'Europe (Germany, Netherlands, UK, France)'),
(10487, 2098, 'North America (United States, Canada)'),
(10488, 2098, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10489, 2098, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10490, 2098, 'Oceania (Australia, New Zealand)'),
(10491, 2099, 'Europe (Germany, Netherlands, UK, France)'),
(10492, 2099, 'North America (United States, Canada)'),
(10493, 2099, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10494, 2099, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10495, 2099, 'Oceania (Australia, New Zealand)'),
(10496, 2100, 'Europe (Germany, Netherlands, UK, France)'),
(10497, 2100, 'North America (United States, Canada)'),
(10498, 2100, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10499, 2100, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10500, 2100, 'Oceania (Australia, New Zealand)');

INSERT INTO `product_regions` (`id`, `product_id`, `region`) VALUES
(10501, 2101, 'Europe (Germany, Netherlands, UK, France)'),
(10502, 2101, 'North America (United States, Canada)'),
(10503, 2101, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10504, 2101, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10505, 2101, 'Oceania (Australia, New Zealand)'),
(10506, 2102, 'Europe (Germany, Netherlands, UK, France)'),
(10507, 2102, 'North America (United States, Canada)'),
(10508, 2102, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10509, 2102, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10510, 2102, 'Oceania (Australia, New Zealand)'),
(10511, 2103, 'Europe (Germany, Netherlands, UK, France)'),
(10512, 2103, 'North America (United States, Canada)'),
(10513, 2103, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10514, 2103, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10515, 2103, 'Oceania (Australia, New Zealand)'),
(10516, 2104, 'Europe (Germany, Netherlands, UK, France)'),
(10517, 2104, 'North America (United States, Canada)'),
(10518, 2104, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10519, 2104, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10520, 2104, 'Oceania (Australia, New Zealand)'),
(10521, 2105, 'Europe (Germany, Netherlands, UK, France)'),
(10522, 2105, 'North America (United States, Canada)'),
(10523, 2105, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10524, 2105, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10525, 2105, 'Oceania (Australia, New Zealand)'),
(10526, 2106, 'Europe (Germany, Netherlands, UK, France)'),
(10527, 2106, 'North America (United States, Canada)'),
(10528, 2106, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10529, 2106, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10530, 2106, 'Oceania (Australia, New Zealand)'),
(10531, 2107, 'Europe (Germany, Netherlands, UK, France)'),
(10532, 2107, 'North America (United States, Canada)'),
(10533, 2107, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10534, 2107, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10535, 2107, 'Oceania (Australia, New Zealand)'),
(10536, 2108, 'Europe (Germany, Netherlands, UK, France)'),
(10537, 2108, 'North America (United States, Canada)'),
(10538, 2108, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10539, 2108, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10540, 2108, 'Oceania (Australia, New Zealand)'),
(10541, 2109, 'Europe (Germany, Netherlands, UK, France)'),
(10542, 2109, 'North America (United States, Canada)'),
(10543, 2109, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10544, 2109, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10545, 2109, 'Oceania (Australia, New Zealand)'),
(10546, 2110, 'Europe (Germany, Netherlands, UK, France)'),
(10547, 2110, 'North America (United States, Canada)'),
(10548, 2110, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10549, 2110, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10550, 2110, 'Oceania (Australia, New Zealand)'),
(10551, 2111, 'Europe (Germany, Netherlands, UK, France)'),
(10552, 2111, 'North America (United States, Canada)'),
(10553, 2111, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10554, 2111, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10555, 2111, 'Oceania (Australia, New Zealand)'),
(10556, 2112, 'Europe (Germany, Netherlands, UK, France)'),
(10557, 2112, 'North America (United States, Canada)'),
(10558, 2112, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10559, 2112, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10560, 2112, 'Oceania (Australia, New Zealand)'),
(10561, 2113, 'Europe (Germany, Netherlands, UK, France)'),
(10562, 2113, 'North America (United States, Canada)'),
(10563, 2113, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10564, 2113, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10565, 2113, 'Oceania (Australia, New Zealand)'),
(10566, 2114, 'Europe (Germany, Netherlands, UK, France)'),
(10567, 2114, 'North America (United States, Canada)'),
(10568, 2114, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10569, 2114, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10570, 2114, 'Oceania (Australia, New Zealand)'),
(10571, 2115, 'Europe (Germany, Netherlands, UK, France)'),
(10572, 2115, 'North America (United States, Canada)'),
(10573, 2115, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10574, 2115, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10575, 2115, 'Oceania (Australia, New Zealand)'),
(10576, 2116, 'Europe (Germany, Netherlands, UK, France)'),
(10577, 2116, 'North America (United States, Canada)'),
(10578, 2116, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10579, 2116, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10580, 2116, 'Oceania (Australia, New Zealand)'),
(10581, 2117, 'Europe (Germany, Netherlands, UK, France)'),
(10582, 2117, 'North America (United States, Canada)'),
(10583, 2117, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10584, 2117, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10585, 2117, 'Oceania (Australia, New Zealand)'),
(10586, 2118, 'Europe (Germany, Netherlands, UK, France)'),
(10587, 2118, 'North America (United States, Canada)'),
(10588, 2118, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10589, 2118, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10590, 2118, 'Oceania (Australia, New Zealand)'),
(10591, 2119, 'Europe (Germany, Netherlands, UK, France)'),
(10592, 2119, 'North America (United States, Canada)'),
(10593, 2119, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10594, 2119, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10595, 2119, 'Oceania (Australia, New Zealand)'),
(10596, 2120, 'Europe (Germany, Netherlands, UK, France)'),
(10597, 2120, 'North America (United States, Canada)'),
(10598, 2120, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10599, 2120, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10600, 2120, 'Oceania (Australia, New Zealand)'),
(10601, 2121, 'Europe (Germany, Netherlands, UK, France)'),
(10602, 2121, 'North America (United States, Canada)'),
(10603, 2121, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10604, 2121, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10605, 2121, 'Oceania (Australia, New Zealand)'),
(10606, 2122, 'Europe (Germany, Netherlands, UK, France)'),
(10607, 2122, 'North America (United States, Canada)'),
(10608, 2122, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10609, 2122, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10610, 2122, 'Oceania (Australia, New Zealand)'),
(10611, 2123, 'Europe (Germany, Netherlands, UK, France)'),
(10612, 2123, 'North America (United States, Canada)'),
(10613, 2123, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10614, 2123, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10615, 2123, 'Oceania (Australia, New Zealand)'),
(10616, 2124, 'Europe (Germany, Netherlands, UK, France)'),
(10617, 2124, 'North America (United States, Canada)'),
(10618, 2124, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10619, 2124, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10620, 2124, 'Oceania (Australia, New Zealand)'),
(10621, 2125, 'Europe (Germany, Netherlands, UK, France)'),
(10622, 2125, 'North America (United States, Canada)'),
(10623, 2125, 'ASEAN (Malaysia, Singapore, Thailand, Philippines)'),
(10624, 2125, 'Middle East (UAE, Saudi Arabia, Qatar)'),
(10625, 2125, 'Oceania (Australia, New Zealand)');

-- -------------------------------------------------------------
-- 8. PRODUCT CERTIFICATIONS (401 rows)
-- -------------------------------------------------------------
INSERT INTO `product_certifications` (`id`, `product_id`, `certification_name`, `certification_number`, `issued_date`, `expiry_date`, `document_url`) VALUES
(10001, 2001, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-max-coklat-hitam-mst-001.pdf'),
(10002, 2001, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-max-coklat-hitam-mst-001.pdf'),
(10003, 2001, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-max-coklat-hitam-mst-001.pdf'),
(10004, 2001, 'EN ISO 20345:2011 S5', 'Personal Protective Equipment - Safety Footwear 200J Toe & Midsole', '2024-03-01', '2029-02-28', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-max-coklat-hitam-mst-001.pdf'),
(10005, 2002, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-metaguard-mst-002.pdf'),
(10006, 2002, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-metaguard-mst-002.pdf'),
(10007, 2002, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-metaguard-mst-002.pdf'),
(10008, 2002, 'EN ISO 20345:2011 S5', 'Personal Protective Equipment - Safety Footwear 200J Toe & Midsole', '2024-03-01', '2029-02-28', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-metaguard-mst-002.pdf'),
(10009, 2003, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-max-safety-s5-steel-toe-mst-003.pdf'),
(10010, 2003, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-max-safety-s5-steel-toe-mst-003.pdf'),
(10011, 2003, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-max-safety-s5-steel-toe-mst-003.pdf'),
(10012, 2003, 'EN ISO 20345:2011 S5', 'Personal Protective Equipment - Safety Footwear 200J Toe & Midsole', '2024-03-01', '2029-02-28', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-max-safety-s5-steel-toe-mst-003.pdf'),
(10013, 2004, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-safety-s5-black-mst-004.pdf'),
(10014, 2004, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-safety-s5-black-mst-004.pdf'),
(10015, 2004, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-safety-s5-black-mst-004.pdf'),
(10016, 2004, 'EN ISO 20345:2011 S5', 'Personal Protective Equipment - Safety Footwear 200J Toe & Midsole', '2024-03-01', '2029-02-28', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-safety-s5-black-mst-004.pdf'),
(10017, 2005, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-metaguard-black-mst-005.pdf'),
(10018, 2005, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-metaguard-black-mst-005.pdf'),
(10019, 2005, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-metaguard-black-mst-005.pdf'),
(10020, 2005, 'EN ISO 20345:2011 S5', 'Personal Protective Equipment - Safety Footwear 200J Toe & Midsole', '2024-03-01', '2029-02-28', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-metaguard-black-mst-005.pdf'),
(10021, 2006, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-safety-s4-black-mst-006.pdf'),
(10022, 2006, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-safety-s4-black-mst-006.pdf'),
(10023, 2006, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-safety-s4-black-mst-006.pdf'),
(10024, 2006, 'EN ISO 20345:2011 S5', 'Personal Protective Equipment - Safety Footwear 200J Toe & Midsole', '2024-03-01', '2029-02-28', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-safety-s4-black-mst-006.pdf'),
(10025, 2007, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-safety-s5-mst-007.pdf'),
(10026, 2007, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-safety-s5-mst-007.pdf'),
(10027, 2007, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-safety-s5-mst-007.pdf'),
(10028, 2007, 'EN ISO 20345:2011 S5', 'Personal Protective Equipment - Safety Footwear 200J Toe & Midsole', '2024-03-01', '2029-02-28', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-safety-s5-mst-007.pdf'),
(10029, 2008, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-eco-3-hijau-mst-008.pdf'),
(10030, 2008, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-eco-3-hijau-mst-008.pdf'),
(10031, 2008, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-eco-3-hijau-mst-008.pdf'),
(10032, 2009, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-eco-3-hitam-mst-009.pdf'),
(10033, 2009, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-eco-3-hitam-mst-009.pdf'),
(10034, 2009, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-eco-3-hitam-mst-009.pdf'),
(10035, 2010, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-eco-3-kuning-mst-010.pdf'),
(10036, 2010, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-eco-3-kuning-mst-010.pdf'),
(10037, 2010, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-eco-3-kuning-mst-010.pdf'),
(10038, 2011, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-eco-3-orange-mst-011.pdf'),
(10039, 2011, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-eco-3-orange-mst-011.pdf'),
(10040, 2011, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-eco-3-orange-mst-011.pdf'),
(10041, 2012, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-gp-hitam-mst-012.pdf'),
(10042, 2012, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-gp-hitam-mst-012.pdf'),
(10043, 2012, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-gp-hitam-mst-012.pdf'),
(10044, 2013, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-1-kuning-mst-013.pdf'),
(10045, 2013, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-1-kuning-mst-013.pdf'),
(10046, 2013, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-1-kuning-mst-013.pdf'),
(10047, 2014, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-1-hijau-mst-014.pdf'),
(10048, 2014, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-1-hijau-mst-014.pdf'),
(10049, 2014, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-1-hijau-mst-014.pdf'),
(10050, 2015, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-1-putih-mst-015.pdf'),
(10051, 2015, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-1-putih-mst-015.pdf'),
(10052, 2015, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-1-putih-mst-015.pdf'),
(10053, 2016, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-eco-5-mst-016.pdf'),
(10054, 2016, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-eco-5-mst-016.pdf'),
(10055, 2016, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-eco-5-mst-016.pdf'),
(10056, 2017, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-eco-2-full-hitam-mst-017.pdf'),
(10057, 2017, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-eco-2-full-hitam-mst-017.pdf'),
(10058, 2017, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-eco-2-full-hitam-mst-017.pdf'),
(10059, 2018, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-3-hijau-merah-mst-018.pdf'),
(10060, 2018, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-3-hijau-merah-mst-018.pdf'),
(10061, 2018, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-3-hijau-merah-mst-018.pdf'),
(10062, 2019, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-army-mst-019.pdf'),
(10063, 2019, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-army-mst-019.pdf'),
(10064, 2019, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-army-mst-019.pdf'),
(10065, 2020, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-forest-mst-020.pdf'),
(10066, 2020, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-forest-mst-020.pdf'),
(10067, 2020, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-forest-mst-020.pdf'),
(10068, 2021, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-3-hitam-kuning-mst-021.pdf'),
(10069, 2021, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-3-hitam-kuning-mst-021.pdf'),
(10070, 2021, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-3-hitam-kuning-mst-021.pdf'),
(10071, 2022, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-2-hijau-mst-022.pdf'),
(10072, 2022, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-2-hijau-mst-022.pdf'),
(10073, 2022, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-2-hijau-mst-022.pdf'),
(10074, 2023, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-terra-5-hijau-mst-023.pdf'),
(10075, 2023, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-terra-5-hijau-mst-023.pdf'),
(10076, 2023, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-terra-5-hijau-mst-023.pdf'),
(10077, 2024, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-eco-5-putih-mst-024.pdf'),
(10078, 2024, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-eco-5-putih-mst-024.pdf'),
(10079, 2024, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-eco-5-putih-mst-024.pdf'),
(10080, 2025, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-gp-hijau-mst-025.pdf'),
(10081, 2025, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-gp-hijau-mst-025.pdf'),
(10082, 2025, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-gp-hijau-mst-025.pdf'),
(10083, 2026, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-safety-s4-mst-026.pdf'),
(10084, 2026, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-safety-s4-mst-026.pdf'),
(10085, 2026, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-terra-safety-s4-mst-026.pdf'),
(10086, 2027, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-orca-mst-027.pdf'),
(10087, 2027, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-orca-mst-027.pdf'),
(10088, 2027, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-orca-mst-027.pdf'),
(10089, 2028, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-chef-putih-mst-028.pdf'),
(10090, 2028, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-chef-putih-mst-028.pdf'),
(10091, 2028, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-chef-putih-mst-028.pdf'),
(10092, 2029, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-chef-hitam-mst-029.pdf'),
(10093, 2029, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-chef-hitam-mst-029.pdf'),
(10094, 2029, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-chef-hitam-mst-029.pdf'),
(10095, 2030, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-footbed-sol-ap-chef-mst-030.pdf'),
(10096, 2030, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-footbed-sol-ap-chef-mst-030.pdf'),
(10097, 2030, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-footbed-sol-ap-chef-mst-030.pdf'),
(10098, 2031, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-medic-biru-mst-031.pdf'),
(10099, 2031, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-medic-biru-mst-031.pdf'),
(10100, 2031, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-medic-biru-mst-031.pdf'),
(10101, 2032, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-medic-hijau-mst-032.pdf'),
(10102, 2032, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-medic-hijau-mst-032.pdf'),
(10103, 2032, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-medic-hijau-mst-032.pdf'),
(10104, 2033, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-medic-putih-mst-033.pdf'),
(10105, 2033, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-medic-putih-mst-033.pdf'),
(10106, 2033, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-medic-putih-mst-033.pdf'),
(10107, 2034, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-footbed-sol-ap-medic-biru-mst-034.pdf'),
(10108, 2034, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-footbed-sol-ap-medic-biru-mst-034.pdf'),
(10109, 2034, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-footbed-sol-ap-medic-biru-mst-034.pdf'),
(10110, 2035, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-footbed-sol-ap-medic-kuning-mst-035.pdf'),
(10111, 2035, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-footbed-sol-ap-medic-kuning-mst-035.pdf'),
(10112, 2035, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-footbed-sol-ap-medic-kuning-mst-035.pdf'),
(10113, 2036, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-medic-pink-mst-036.pdf'),
(10114, 2036, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-medic-pink-mst-036.pdf'),
(10115, 2036, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-medic-pink-mst-036.pdf'),
(10116, 2037, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-medic-hitam-mst-037.pdf'),
(10117, 2037, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-medic-hitam-mst-037.pdf'),
(10118, 2037, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-medic-hitam-mst-037.pdf'),
(10119, 2038, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-allbike-orange-mst-038.pdf'),
(10120, 2038, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-allbike-orange-mst-038.pdf'),
(10121, 2038, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-allbike-orange-mst-038.pdf'),
(10122, 2039, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-allbike-2-orange-mst-039.pdf'),
(10123, 2039, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-allbike-2-orange-mst-039.pdf'),
(10124, 2039, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-allbike-2-orange-mst-039.pdf'),
(10125, 2040, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-hobby-n-work-mst-040.pdf'),
(10126, 2040, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-hobby-n-work-mst-040.pdf'),
(10127, 2040, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-hobby-n-work-mst-040.pdf'),
(10128, 2041, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-allbike-abu-mst-041.pdf'),
(10129, 2041, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-allbike-abu-mst-041.pdf'),
(10130, 2041, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-allbike-abu-mst-041.pdf'),
(10131, 2042, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-allbike-2-hijau-mst-042.pdf'),
(10132, 2042, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-allbike-2-hijau-mst-042.pdf'),
(10133, 2042, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-allbike-2-hijau-mst-042.pdf'),
(10134, 2043, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-allbike-2-abu-mst-043.pdf'),
(10135, 2043, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-allbike-2-abu-mst-043.pdf'),
(10136, 2043, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-allbike-2-abu-mst-043.pdf'),
(10137, 2044, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-moto-1-mst-044.pdf'),
(10138, 2044, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-moto-1-mst-044.pdf'),
(10139, 2044, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-moto-1-mst-044.pdf'),
(10140, 2045, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-moto-2-mst-045.pdf'),
(10141, 2045, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-moto-2-mst-045.pdf'),
(10142, 2045, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-moto-2-mst-045.pdf'),
(10143, 2046, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-moto-3-mst-046.pdf'),
(10144, 2046, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-moto-3-mst-046.pdf'),
(10145, 2046, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-moto-3-mst-046.pdf'),
(10146, 2047, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-allbike-2-mst-047.pdf'),
(10147, 2047, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-allbike-2-mst-047.pdf'),
(10148, 2047, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-allbike-2-mst-047.pdf'),
(10149, 2048, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-allbike-hijau-mst-048.pdf'),
(10150, 2048, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-allbike-hijau-mst-048.pdf'),
(10151, 2048, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-allbike-hijau-mst-048.pdf'),
(10152, 2049, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-allbike-merah-mst-049.pdf'),
(10153, 2049, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-allbike-merah-mst-049.pdf'),
(10154, 2049, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-allbike-merah-mst-049.pdf'),
(10155, 2050, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2017-green-lime-mst-050.pdf'),
(10156, 2050, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2017-green-lime-mst-050.pdf'),
(10157, 2050, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2017-green-lime-mst-050.pdf'),
(10158, 2051, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2017-green-mst-051.pdf'),
(10159, 2051, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2017-green-mst-051.pdf'),
(10160, 2051, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2017-green-mst-051.pdf'),
(10161, 2052, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2005-roots-n-leaves-mst-052.pdf'),
(10162, 2052, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2005-roots-n-leaves-mst-052.pdf'),
(10163, 2052, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2005-roots-n-leaves-mst-052.pdf'),
(10164, 2053, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2005-hijau-mst-053.pdf'),
(10165, 2053, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2005-hijau-mst-053.pdf'),
(10166, 2053, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2005-hijau-mst-053.pdf'),
(10167, 2054, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2003-hijau-tricolour-mst-054.pdf'),
(10168, 2054, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2003-hijau-tricolour-mst-054.pdf'),
(10169, 2054, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2003-hijau-tricolour-mst-054.pdf'),
(10170, 2055, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2017-tosca-mst-055.pdf'),
(10171, 2055, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2017-tosca-mst-055.pdf'),
(10172, 2055, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2017-tosca-mst-055.pdf'),
(10173, 2056, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-ap-969-putih-cream-mst-056.pdf'),
(10174, 2056, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-ap-969-putih-cream-mst-056.pdf'),
(10175, 2056, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-ap-969-putih-cream-mst-056.pdf'),
(10176, 2057, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-xt-hijau-mst-057.pdf'),
(10177, 2057, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-xt-hijau-mst-057.pdf'),
(10178, 2057, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-xt-hijau-mst-057.pdf'),
(10179, 2058, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-9506-hijau-mst-058.pdf'),
(10180, 2058, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-9506-hijau-mst-058.pdf'),
(10181, 2058, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-9506-hijau-mst-058.pdf'),
(10182, 2059, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-ap-963-putih-mst-059.pdf'),
(10183, 2059, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-ap-963-putih-mst-059.pdf'),
(10184, 2059, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-ap-963-putih-mst-059.pdf'),
(10185, 2060, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-ap-1-hitam-mst-060.pdf'),
(10186, 2060, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-ap-1-hitam-mst-060.pdf'),
(10187, 2060, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-ap-1-hitam-mst-060.pdf'),
(10188, 2061, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-ap-1-putih-mst-061.pdf'),
(10189, 2061, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-ap-1-putih-mst-061.pdf'),
(10190, 2061, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-ap-1-putih-mst-061.pdf'),
(10191, 2062, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-9303-mst-062.pdf'),
(10192, 2062, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-9303-mst-062.pdf'),
(10193, 2062, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-9303-mst-062.pdf'),
(10194, 2063, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-ap-977-hitam-mst-063.pdf'),
(10195, 2063, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-ap-977-hitam-mst-063.pdf'),
(10196, 2063, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-ap-977-hitam-mst-063.pdf'),
(10197, 2064, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-ap-2011-hijau-mst-064.pdf'),
(10198, 2064, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-ap-2011-hijau-mst-064.pdf'),
(10199, 2064, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-ap-2011-hijau-mst-064.pdf'),
(10200, 2065, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2018-ultraflex-biru-mst-065.pdf'),
(10201, 2065, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2018-ultraflex-biru-mst-065.pdf'),
(10202, 2065, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2018-ultraflex-biru-mst-065.pdf'),
(10203, 2066, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-ap-3-black-mst-066.pdf'),
(10204, 2066, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-ap-3-black-mst-066.pdf'),
(10205, 2066, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-ap-3-black-mst-066.pdf'),
(10206, 2067, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-9905-hitam-mst-067.pdf'),
(10207, 2067, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-9905-hitam-mst-067.pdf'),
(10208, 2067, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-9905-hitam-mst-067.pdf'),
(10209, 2068, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-ap-963-cream-mst-068.pdf'),
(10210, 2068, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-ap-963-cream-mst-068.pdf'),
(10211, 2068, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-ap-963-cream-mst-068.pdf'),
(10212, 2069, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-ap-967-hitam-mst-069.pdf'),
(10213, 2069, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-ap-967-hitam-mst-069.pdf'),
(10214, 2069, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-ap-967-hitam-mst-069.pdf'),
(10215, 2070, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2015-ultimate-abu-mst-070.pdf'),
(10216, 2070, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2015-ultimate-abu-mst-070.pdf'),
(10217, 2070, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2015-ultimate-abu-mst-070.pdf'),
(10218, 2071, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2015-ultimate-hitam-mst-071.pdf'),
(10219, 2071, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2015-ultimate-hitam-mst-071.pdf'),
(10220, 2071, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2015-ultimate-hitam-mst-071.pdf'),
(10221, 2072, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2015-ultimate-hijau-mst-072.pdf'),
(10222, 2072, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2015-ultimate-hijau-mst-072.pdf'),
(10223, 2072, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2015-ultimate-hijau-mst-072.pdf'),
(10224, 2073, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2015-ultimate-orange-mst-073.pdf'),
(10225, 2073, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2015-ultimate-orange-mst-073.pdf'),
(10226, 2073, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2015-ultimate-orange-mst-073.pdf'),
(10227, 2074, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2018-ultraflex-abu-mst-074.pdf'),
(10228, 2074, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2018-ultraflex-abu-mst-074.pdf'),
(10229, 2074, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2018-ultraflex-abu-mst-074.pdf'),
(10230, 2075, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2018-ultraflex-hijau-mst-075.pdf'),
(10231, 2075, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2018-ultraflex-hijau-mst-075.pdf'),
(10232, 2075, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2018-ultraflex-hijau-mst-075.pdf'),
(10233, 2076, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2007-mst-076.pdf'),
(10234, 2076, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2007-mst-076.pdf'),
(10235, 2076, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2007-mst-076.pdf'),
(10236, 2077, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2006-mst-077.pdf'),
(10237, 2077, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2006-mst-077.pdf'),
(10238, 2077, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2006-mst-077.pdf'),
(10239, 2078, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-2012-merah-stabilo-mst-078.pdf'),
(10240, 2078, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-2012-merah-stabilo-mst-078.pdf'),
(10241, 2078, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-2012-merah-stabilo-mst-078.pdf'),
(10242, 2079, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-2012-hijau-stabilo-mst-079.pdf'),
(10243, 2079, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-2012-hijau-stabilo-mst-079.pdf'),
(10244, 2079, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-2012-hijau-stabilo-mst-079.pdf'),
(10245, 2080, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-2012-ungu-stabilo-mst-080.pdf'),
(10246, 2080, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-2012-ungu-stabilo-mst-080.pdf'),
(10247, 2080, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-2012-ungu-stabilo-mst-080.pdf'),
(10248, 2081, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-safari-elephant-mst-081.pdf'),
(10249, 2081, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-safari-elephant-mst-081.pdf'),
(10250, 2081, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-safari-elephant-mst-081.pdf');

INSERT INTO `product_certifications` (`id`, `product_id`, `certification_name`, `certification_number`, `issued_date`, `expiry_date`, `document_url`) VALUES
(10251, 2082, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-safari-zebra-mst-082.pdf'),
(10252, 2082, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-safari-zebra-mst-082.pdf'),
(10253, 2082, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-safari-zebra-mst-082.pdf'),
(10254, 2083, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-safari-crocodile-mst-083.pdf'),
(10255, 2083, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-safari-crocodile-mst-083.pdf'),
(10256, 2083, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-safari-crocodile-mst-083.pdf'),
(10257, 2084, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-2012-lemon-polkadot-mst-084.pdf'),
(10258, 2084, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-2012-lemon-polkadot-mst-084.pdf'),
(10259, 2084, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-2012-lemon-polkadot-mst-084.pdf'),
(10260, 2085, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-2012-mixed-black-fuxia-mst-085.pdf'),
(10261, 2085, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-2012-mixed-black-fuxia-mst-085.pdf'),
(10262, 2085, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-2012-mixed-black-fuxia-mst-085.pdf'),
(10263, 2086, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-2012-blue-jeans-mst-086.pdf'),
(10264, 2086, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-2012-blue-jeans-mst-086.pdf'),
(10265, 2086, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-2012-blue-jeans-mst-086.pdf'),
(10266, 2087, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-2012-violet-circle-mst-087.pdf'),
(10267, 2087, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-2012-violet-circle-mst-087.pdf'),
(10268, 2087, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-2012-violet-circle-mst-087.pdf'),
(10269, 2088, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-2012-fuxia-stripe-mst-088.pdf'),
(10270, 2088, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-2012-fuxia-stripe-mst-088.pdf'),
(10271, 2088, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-2012-fuxia-stripe-mst-088.pdf'),
(10272, 2089, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-2012-ungu-stabilo-multi-mst-089.pdf'),
(10273, 2089, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-2012-ungu-stabilo-multi-mst-089.pdf'),
(10274, 2089, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-kids-2012-ungu-stabilo-multi-mst-089.pdf'),
(10275, 2090, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2001-hijau-mst-090.pdf'),
(10276, 2090, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2001-hijau-mst-090.pdf'),
(10277, 2090, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-2001-hijau-mst-090.pdf'),
(10278, 2091, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-clogs-ladies-pink-cream-mst-091.pdf'),
(10279, 2091, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-clogs-ladies-pink-cream-mst-091.pdf'),
(10280, 2091, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-clogs-ladies-pink-cream-mst-091.pdf'),
(10281, 2092, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-clogs-hitam-mst-092.pdf'),
(10282, 2092, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-clogs-hitam-mst-092.pdf'),
(10283, 2092, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-clogs-hitam-mst-092.pdf'),
(10284, 2093, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-clogs-coklat-mst-093.pdf'),
(10285, 2093, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-clogs-coklat-mst-093.pdf'),
(10286, 2093, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-clogs-coklat-mst-093.pdf'),
(10287, 2094, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-clogs-navy-mst-094.pdf'),
(10288, 2094, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-clogs-navy-mst-094.pdf'),
(10289, 2094, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-clogs-navy-mst-094.pdf'),
(10290, 2095, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-clogs-putih-krem-mst-095.pdf'),
(10291, 2095, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-clogs-putih-krem-mst-095.pdf'),
(10292, 2095, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-clogs-putih-krem-mst-095.pdf'),
(10293, 2096, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-clogs-putih-abu-mst-096.pdf'),
(10294, 2096, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-clogs-putih-abu-mst-096.pdf'),
(10295, 2096, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-clogs-putih-abu-mst-096.pdf'),
(10296, 2097, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-clogs-putih-merah-mst-097.pdf'),
(10297, 2097, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-clogs-putih-merah-mst-097.pdf'),
(10298, 2097, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-clogs-putih-merah-mst-097.pdf'),
(10299, 2098, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-clogs-putih-navy-mst-098.pdf'),
(10300, 2098, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-clogs-putih-navy-mst-098.pdf'),
(10301, 2098, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-clogs-putih-navy-mst-098.pdf'),
(10302, 2099, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-1001-hitam-mst-099.pdf'),
(10303, 2099, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-1001-hitam-mst-099.pdf'),
(10304, 2099, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-1001-hitam-mst-099.pdf'),
(10305, 2100, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-991-hitam-mst-100.pdf'),
(10306, 2100, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-991-hitam-mst-100.pdf'),
(10307, 2100, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-991-hitam-mst-100.pdf'),
(10308, 2101, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-989-hitam-mst-101.pdf'),
(10309, 2101, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-989-hitam-mst-101.pdf'),
(10310, 2101, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-989-hitam-mst-101.pdf'),
(10311, 2102, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-995-hitam-v1-mst-102.pdf'),
(10312, 2102, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-995-hitam-v1-mst-102.pdf'),
(10313, 2102, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-995-hitam-v1-mst-102.pdf'),
(10314, 2103, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-999-hitam-mst-103.pdf'),
(10315, 2103, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-999-hitam-mst-103.pdf'),
(10316, 2103, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-999-hitam-mst-103.pdf'),
(10317, 2104, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-995-hitam-v2-mst-104.pdf'),
(10318, 2104, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-995-hitam-v2-mst-104.pdf'),
(10319, 2104, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-boots-995-hitam-v2-mst-104.pdf'),
(10320, 2105, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-star-hitam-putih-mst-105.pdf'),
(10321, 2105, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-star-hitam-putih-mst-105.pdf'),
(10322, 2105, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-star-hitam-putih-mst-105.pdf'),
(10323, 2106, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-star-hitam-hitam-mst-106.pdf'),
(10324, 2106, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-star-hitam-hitam-mst-106.pdf'),
(10325, 2106, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/ap-boots-ap-star-hitam-hitam-mst-106.pdf'),
(10326, 2107, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-nelayan-yellow-pvc-steel-toe-cap-anti-static-mst-107.pdf'),
(10327, 2107, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-nelayan-yellow-pvc-steel-toe-cap-anti-static-mst-107.pdf'),
(10328, 2107, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-nelayan-yellow-pvc-steel-toe-cap-anti-static-mst-107.pdf'),
(10329, 2107, 'EN ISO 20345:2011 S5', 'Personal Protective Equipment - Safety Footwear 200J Toe & Midsole', '2024-03-01', '2029-02-28', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-nelayan-yellow-pvc-steel-toe-cap-anti-static-mst-107.pdf'),
(10330, 2108, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-phenom-yellow-pvc-steel-toe-cap-anti-static-mst-108.pdf'),
(10331, 2108, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-phenom-yellow-pvc-steel-toe-cap-anti-static-mst-108.pdf'),
(10332, 2108, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-phenom-yellow-pvc-steel-toe-cap-anti-static-mst-108.pdf'),
(10333, 2108, 'EN ISO 20345:2011 S5', 'Personal Protective Equipment - Safety Footwear 200J Toe & Midsole', '2024-03-01', '2029-02-28', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-phenom-yellow-pvc-steel-toe-cap-anti-static-mst-108.pdf'),
(10334, 2109, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-phenom-yellow-size-39-pvc-steel-toe-cap-anti-static-mst-109.pdf'),
(10335, 2109, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-phenom-yellow-size-39-pvc-steel-toe-cap-anti-static-mst-109.pdf'),
(10336, 2109, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-phenom-yellow-size-39-pvc-steel-toe-cap-anti-static-mst-109.pdf'),
(10337, 2109, 'EN ISO 20345:2011 S5', 'Personal Protective Equipment - Safety Footwear 200J Toe & Midsole', '2024-03-01', '2029-02-28', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-phenom-yellow-size-39-pvc-steel-toe-cap-anti-static-mst-109.pdf'),
(10338, 2110, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-strength-wb-biru-boots-air-pvc-mst-110.pdf'),
(10339, 2110, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-strength-wb-biru-boots-air-pvc-mst-110.pdf'),
(10340, 2110, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-strength-wb-biru-boots-air-pvc-mst-110.pdf'),
(10341, 2110, 'EN ISO 20345:2011 S5', 'Personal Protective Equipment - Safety Footwear 200J Toe & Midsole', '2024-03-01', '2029-02-28', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-strength-wb-biru-boots-air-pvc-mst-110.pdf'),
(10342, 2111, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-strength-wb-hijau-boots-air-pvc-mst-111.pdf'),
(10343, 2111, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-strength-wb-hijau-boots-air-pvc-mst-111.pdf'),
(10344, 2111, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-strength-wb-hijau-boots-air-pvc-mst-111.pdf'),
(10345, 2111, 'EN ISO 20345:2011 S5', 'Personal Protective Equipment - Safety Footwear 200J Toe & Midsole', '2024-03-01', '2029-02-28', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-strength-wb-hijau-boots-air-pvc-mst-111.pdf'),
(10346, 2112, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-strength-wb-hitam-boots-air-pvc-mst-112.pdf'),
(10347, 2112, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-strength-wb-hitam-boots-air-pvc-mst-112.pdf'),
(10348, 2112, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-strength-wb-hitam-boots-air-pvc-mst-112.pdf'),
(10349, 2112, 'EN ISO 20345:2011 S5', 'Personal Protective Equipment - Safety Footwear 200J Toe & Midsole', '2024-03-01', '2029-02-28', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-strength-wb-hitam-boots-air-pvc-mst-112.pdf'),
(10350, 2113, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-strength-wb-kuning-boots-air-pvc-mst-113.pdf'),
(10351, 2113, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-strength-wb-kuning-boots-air-pvc-mst-113.pdf'),
(10352, 2113, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-strength-wb-kuning-boots-air-pvc-mst-113.pdf'),
(10353, 2113, 'EN ISO 20345:2011 S5', 'Personal Protective Equipment - Safety Footwear 200J Toe & Midsole', '2024-03-01', '2029-02-28', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-strength-wb-kuning-boots-air-pvc-mst-113.pdf'),
(10354, 2114, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-strength-wb-orange-boots-air-pvc-mst-114.pdf'),
(10355, 2114, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-strength-wb-orange-boots-air-pvc-mst-114.pdf'),
(10356, 2114, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-strength-wb-orange-boots-air-pvc-mst-114.pdf'),
(10357, 2114, 'EN ISO 20345:2011 S5', 'Personal Protective Equipment - Safety Footwear 200J Toe & Midsole', '2024-03-01', '2029-02-28', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-strength-wb-orange-boots-air-pvc-mst-114.pdf'),
(10358, 2115, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-tinggi-safety-ergos-kuning-steel-toe-pvc-mst-115.pdf'),
(10359, 2115, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-tinggi-safety-ergos-kuning-steel-toe-pvc-mst-115.pdf'),
(10360, 2115, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-tinggi-safety-ergos-kuning-steel-toe-pvc-mst-115.pdf'),
(10361, 2115, 'EN ISO 20345:2011 S5', 'Personal Protective Equipment - Safety Footwear 200J Toe & Midsole', '2024-03-01', '2029-02-28', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-tinggi-safety-ergos-kuning-steel-toe-pvc-mst-115.pdf'),
(10362, 2116, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-pvc-steel-toe-cap-anti-static-mst-116.pdf'),
(10363, 2116, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-pvc-steel-toe-cap-anti-static-mst-116.pdf'),
(10364, 2116, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-pvc-steel-toe-cap-anti-static-mst-116.pdf'),
(10365, 2116, 'EN ISO 20345:2011 S5', 'Personal Protective Equipment - Safety Footwear 200J Toe & Midsole', '2024-03-01', '2029-02-28', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-pvc-steel-toe-cap-anti-static-mst-116.pdf'),
(10366, 2117, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-size-38-pvc-steel-toe-cap-anti-static-mst-117.pdf'),
(10367, 2117, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-size-38-pvc-steel-toe-cap-anti-static-mst-117.pdf'),
(10368, 2117, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-size-38-pvc-steel-toe-cap-anti-static-mst-117.pdf'),
(10369, 2117, 'EN ISO 20345:2011 S5', 'Personal Protective Equipment - Safety Footwear 200J Toe & Midsole', '2024-03-01', '2029-02-28', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-size-38-pvc-steel-toe-cap-anti-static-mst-117.pdf'),
(10370, 2118, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-size-39-pvc-steel-toe-cap-anti-static-mst-118.pdf'),
(10371, 2118, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-size-39-pvc-steel-toe-cap-anti-static-mst-118.pdf'),
(10372, 2118, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-size-39-pvc-steel-toe-cap-anti-static-mst-118.pdf'),
(10373, 2118, 'EN ISO 20345:2011 S5', 'Personal Protective Equipment - Safety Footwear 200J Toe & Midsole', '2024-03-01', '2029-02-28', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-size-39-pvc-steel-toe-cap-anti-static-mst-118.pdf'),
(10374, 2119, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-size-40-pvc-steel-toe-cap-anti-static-mst-119.pdf'),
(10375, 2119, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-size-40-pvc-steel-toe-cap-anti-static-mst-119.pdf'),
(10376, 2119, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-size-40-pvc-steel-toe-cap-anti-static-mst-119.pdf'),
(10377, 2119, 'EN ISO 20345:2011 S5', 'Personal Protective Equipment - Safety Footwear 200J Toe & Midsole', '2024-03-01', '2029-02-28', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-size-40-pvc-steel-toe-cap-anti-static-mst-119.pdf'),
(10378, 2120, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-size-41-pvc-steel-toe-cap-anti-static-mst-120.pdf'),
(10379, 2120, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-size-41-pvc-steel-toe-cap-anti-static-mst-120.pdf'),
(10380, 2120, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-size-41-pvc-steel-toe-cap-anti-static-mst-120.pdf'),
(10381, 2120, 'EN ISO 20345:2011 S5', 'Personal Protective Equipment - Safety Footwear 200J Toe & Midsole', '2024-03-01', '2029-02-28', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-size-41-pvc-steel-toe-cap-anti-static-mst-120.pdf'),
(10382, 2121, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-size-43-pvc-steel-toe-cap-anti-static-mst-121.pdf'),
(10383, 2121, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-size-43-pvc-steel-toe-cap-anti-static-mst-121.pdf'),
(10384, 2121, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-size-43-pvc-steel-toe-cap-anti-static-mst-121.pdf'),
(10385, 2121, 'EN ISO 20345:2011 S5', 'Personal Protective Equipment - Safety Footwear 200J Toe & Midsole', '2024-03-01', '2029-02-28', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-size-43-pvc-steel-toe-cap-anti-static-mst-121.pdf'),
(10386, 2122, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-size-44-pvc-steel-toe-cap-anti-static-mst-122.pdf'),
(10387, 2122, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-size-44-pvc-steel-toe-cap-anti-static-mst-122.pdf'),
(10388, 2122, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-size-44-pvc-steel-toe-cap-anti-static-mst-122.pdf'),
(10389, 2122, 'EN ISO 20345:2011 S5', 'Personal Protective Equipment - Safety Footwear 200J Toe & Midsole', '2024-03-01', '2029-02-28', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-ultimate-yellow-size-44-pvc-steel-toe-cap-anti-static-mst-122.pdf'),
(10390, 2123, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-tinggi-petrova-classic-hitam-boots-pvc-lentur-lokal-mst-123.pdf'),
(10391, 2123, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-tinggi-petrova-classic-hitam-boots-pvc-lentur-lokal-mst-123.pdf'),
(10392, 2123, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-tinggi-petrova-classic-hitam-boots-pvc-lentur-lokal-mst-123.pdf'),
(10393, 2123, 'EN ISO 20345:2011 S5', 'Personal Protective Equipment - Safety Footwear 200J Toe & Midsole', '2024-03-01', '2029-02-28', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-tinggi-petrova-classic-hitam-boots-pvc-lentur-lokal-mst-123.pdf'),
(10394, 2124, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-tinggi-petrova-pro-green-boots-karet-lentur-lokal-anti-slip-air-ringan-perkebunan-mst-124.pdf'),
(10395, 2124, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-tinggi-petrova-pro-green-boots-karet-lentur-lokal-anti-slip-air-ringan-perkebunan-mst-124.pdf'),
(10396, 2124, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-tinggi-petrova-pro-green-boots-karet-lentur-lokal-anti-slip-air-ringan-perkebunan-mst-124.pdf'),
(10397, 2124, 'EN ISO 20345:2011 S5', 'Personal Protective Equipment - Safety Footwear 200J Toe & Midsole', '2024-03-01', '2029-02-28', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-tinggi-petrova-pro-green-boots-karet-lentur-lokal-anti-slip-air-ringan-perkebunan-mst-124.pdf'),
(10398, 2125, 'SNI 0111:2009', 'Standard Nasional Indonesia - Sepatu Boot Cetak Polimer', '2024-01-15', '2029-01-14', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-tinggi-safety-strength-kuning-steel-toe-pvc-mst-125.pdf'),
(10399, 2125, 'ISO 9001:2015', 'Quality Management Systems Certified Facility', '2023-06-10', '2028-06-09', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-tinggi-safety-strength-kuning-steel-toe-pvc-mst-125.pdf'),
(10400, 2125, 'GPSR EU 2023/988', 'European Union General Product Safety Regulation Compliant', '2024-12-13', '2029-12-12', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-tinggi-safety-strength-kuning-steel-toe-pvc-mst-125.pdf'),
(10401, 2125, 'EN ISO 20345:2011 S5', 'Personal Protective Equipment - Safety Footwear 200J Toe & Midsole', '2024-03-01', '2029-02-28', 'https://catalog.hotstrading.com/compliance/petrova-petrova-sepatu-boots-tinggi-safety-strength-kuning-steel-toe-pvc-mst-125.pdf');

-- -------------------------------------------------------------
-- 9. ALIBABA EXPORT LISTINGS MODULE (125 rows)
-- -------------------------------------------------------------
INSERT INTO `alibaba_export_listings` (
  `id`, `product_id`, `sku`, `alibaba_product_title`, `category_group`, `target_continent`,
  `target_country`, `target_industry_angle`, `primary_keyword_1`, `primary_keyword_2`,
  `primary_keyword_3`, `longtail_keywords`, `base_price_idr`, `fob_price_usd`, `exchange_rate_used`,
  `pairs_per_carton`, `carton_price_usd`, `carton_price_idr`, `carton_dimensions_cm`,
  `cbm_per_carton`, `gross_weight_kg_per_carton`, `capacity_20ft_cartons`, `capacity_40ft_hc_cartons`,
  `prompt_slot_1_hero`, `prompt_slot_2_side`, `prompt_slot_3_tread`, `prompt_slot_4_contextual`,
  `image_slot_1`, `image_slot_2`, `image_slot_3`, `image_slot_4`, `image_slot_5`, `image_slot_6`,
  `export_status`, `last_error_message`, `created_at`, `updated_at`
) VALUES
(
  10001, 2001, 'MST-001', 'AP Boots AP MAX Coklat Hitam Waterproof PVC Heavy Industry & Mining S Industrial Boots SNI',
  'Heavy Industry & Mining Safety', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  235818, 13.54, 16250.00,
  10, 135.40, 2358180,
  '58 x 42 x 38', 0.0960, 22.50,
  360, 850,
  'Professional studio photography of AP Boots AP MAX Coklat Hitam, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP MAX Coklat Hitam, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP MAX Coklat Hitam, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP MAX Coklat Hitam in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC/hero_AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC/side_AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP MAX Coklat Hitam - Sepatu Safety PVC - 39/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP MAX Coklat Hitam - Sepatu Safety PVC - 39/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10002, 2002, 'MST-002', 'AP Boots AP METAGUARD Waterproof PVC Heavy Industry & Mining S Industrial Boots SNI',
  'Heavy Industry & Mining Safety', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  225300, 12.94, 16250.00,
  10, 129.40, 2253000,
  '58 x 42 x 38', 0.0960, 22.50,
  360, 850,
  'Professional studio photography of AP Boots AP METAGUARD, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP METAGUARD, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP METAGUARD, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP METAGUARD in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_METAGUARD_Black_Sepatu_Boot_PVC/hero_AP_Boots_METAGUARD_Black_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_METAGUARD_Black_Sepatu_Boot_PVC/side_AP_Boots_METAGUARD_Black_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots METAGUARD Black - Sepatu Boot PVC Shoes - 39/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots METAGUARD Black - Sepatu Boot PVC Shoes - 39/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10003, 2003, 'MST-003', 'AP Boots AP MAX Safety S5 Steel Toe Waterproof PVC Heavy Industry & Mining S Industrial Boots SNI',
  'Heavy Industry & Mining Safety', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  223899, 12.86, 16250.00,
  10, 128.60, 2238990,
  '58 x 42 x 38', 0.0960, 22.50,
  360, 850,
  'Professional studio photography of AP Boots AP MAX Safety S5 Steel Toe, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP MAX Safety S5 Steel Toe, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP MAX Safety S5 Steel Toe, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP MAX Safety S5 Steel Toe in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC/hero_AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC/side_AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP MAX Coklat Hitam - Sepatu Safety PVC - 39/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP MAX Coklat Hitam - Sepatu Safety PVC - 39/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10004, 2004, 'MST-004', 'AP Boots AP Safety S5 BLACK Waterproof PVC Heavy Industry & Mining S Industrial Boots SNI',
  'Heavy Industry & Mining Safety', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  223875, 12.86, 16250.00,
  10, 128.60, 2238750,
  '58 x 42 x 38', 0.0960, 22.50,
  360, 850,
  'Professional studio photography of AP Boots AP Safety S5 BLACK, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Safety S5 BLACK, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Safety S5 BLACK, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Safety S5 BLACK in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_Safety_S5_BLACK_Sepatu_Boot_PVC/hero_AP_Boots_Safety_S5_BLACK_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_Safety_S5_BLACK_Sepatu_Boot_PVC/side_AP_Boots_Safety_S5_BLACK_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S5 BLACK - Sepatu Boot PVC Shoes Karet - 39/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S5 BLACK - Sepatu Boot PVC Shoes Karet - 39/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10005, 2005, 'MST-005', 'AP Boots AP METAGUARD Black Waterproof PVC Heavy Industry & Mining S Industrial Boots SNI',
  'Heavy Industry & Mining Safety', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  225300, 12.94, 16250.00,
  10, 129.40, 2253000,
  '58 x 42 x 38', 0.0960, 22.50,
  360, 850,
  'Professional studio photography of AP Boots AP METAGUARD Black, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP METAGUARD Black, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP METAGUARD Black, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP METAGUARD Black in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_METAGUARD_Black_Sepatu_Boot_PVC/hero_AP_Boots_METAGUARD_Black_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_METAGUARD_Black_Sepatu_Boot_PVC/side_AP_Boots_METAGUARD_Black_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots METAGUARD Black - Sepatu Boot PVC Shoes - 39/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots METAGUARD Black - Sepatu Boot PVC Shoes - 39/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10006, 2006, 'MST-006', 'AP Boots AP Safety S4 Black Waterproof PVC Heavy Industry & Mining S Industrial Boots SNI',
  'Heavy Industry & Mining Safety', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  205174, 11.78, 16250.00,
  10, 117.80, 2051740,
  '58 x 42 x 38', 0.0960, 22.50,
  360, 850,
  'Professional studio photography of AP Boots AP Safety S4 Black, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Safety S4 Black, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Safety S4 Black, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Safety S4 Black in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_Safety_S4_Black_Sepatu_Boot_PVC/hero_AP_Boots_Safety_S4_Black_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_Safety_S4_Black_Sepatu_Boot_PVC/side_AP_Boots_Safety_S4_Black_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S4 Black - Sepatu Boot PVC - 39/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S4 Black - Sepatu Boot PVC - 39/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10007, 2007, 'MST-007', 'AP Boots AP Safety S5 Waterproof PVC Heavy Industry & Mining S Industrial Boots SNI',
  'Heavy Industry & Mining Safety', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  223875, 12.86, 16250.00,
  10, 128.60, 2238750,
  '58 x 42 x 38', 0.0960, 22.50,
  360, 850,
  'Professional studio photography of AP Boots AP Safety S5, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Safety S5, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Safety S5, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Safety S5 in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_Safety_S5_BLACK_Sepatu_Boot_PVC/hero_AP_Boots_Safety_S5_BLACK_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_Safety_S5_BLACK_Sepatu_Boot_PVC/side_AP_Boots_Safety_S5_BLACK_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S5 BLACK - Sepatu Boot PVC Shoes Karet - 39/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots Safety S5 BLACK - Sepatu Boot PVC Shoes Karet - 39/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10008, 2008, 'MST-008', 'AP Boots AP TERRA ECO 3 Hijau Waterproof PVC Agriculture & Forestry Industrial Boots SNI',
  'Agriculture & Forestry', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  73575, 4.23, 16250.00,
  12, 50.76, 882900,
  '58 x 42 x 38', 0.0960, 17.50,
  300, 708,
  'Professional studio photography of AP Boots AP TERRA ECO 3 Hijau, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP TERRA ECO 3 Hijau, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP TERRA ECO 3 Hijau, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP TERRA ECO 3 Hijau in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_3_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_3_Hijau_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_3_Hijau_Sepatu_Boot_PVC/side_AP_Boots_TERRA_ECO_3_Hijau_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Hijau - Sepatu Boot PVC Karet Shoes - 38/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Hijau - Sepatu Boot PVC Karet Shoes - 38/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10009, 2009, 'MST-009', 'AP Boots AP TERRA ECO 3 Hitam Waterproof PVC Agriculture & Forestry Industrial Boots SNI',
  'Agriculture & Forestry', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  60468, 3.47, 16250.00,
  12, 41.64, 725616,
  '58 x 42 x 38', 0.0960, 17.50,
  300, 708,
  'Professional studio photography of AP Boots AP TERRA ECO 3 Hitam, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP TERRA ECO 3 Hitam, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP TERRA ECO 3 Hitam, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP TERRA ECO 3 Hitam in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC/side_AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10010, 2010, 'MST-010', 'AP Boots AP TERRA ECO 3 Kuning Waterproof PVC Agriculture & Forestry Industrial Boots SNI',
  'Agriculture & Forestry', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  80550, 4.63, 16250.00,
  12, 55.56, 966600,
  '58 x 42 x 38', 0.0960, 17.50,
  300, 708,
  'Professional studio photography of AP Boots AP TERRA ECO 3 Kuning, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP TERRA ECO 3 Kuning, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP TERRA ECO 3 Kuning, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP TERRA ECO 3 Kuning in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_3_Kuning_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_3_Kuning_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_3_Kuning_Sepatu_Boot_PVC/side_AP_Boots_TERRA_ECO_3_Kuning_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Kuning - Sepatu Boot PVC Karet Shoes - 38/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Kuning - Sepatu Boot PVC Karet Shoes - 38/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10011, 2011, 'MST-011', 'AP Boots AP TERRA ECO 3 Orange Waterproof PVC Agriculture & Forestry Industrial Boots SNI',
  'Agriculture & Forestry', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  85549, 4.91, 16250.00,
  12, 58.92, 1026588,
  '58 x 42 x 38', 0.0960, 17.50,
  300, 708,
  'Professional studio photography of AP Boots AP TERRA ECO 3 Orange, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP TERRA ECO 3 Orange, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP TERRA ECO 3 Orange, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP TERRA ECO 3 Orange in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_3_Orange_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_3_Orange_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_3_Orange_Sepatu_Boot_PVC/side_AP_Boots_TERRA_ECO_3_Orange_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Orange - Sepatu Boot PVC Karet Shoes - 39/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 3 Orange - Sepatu Boot PVC Karet Shoes - 39/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10012, 2012, 'MST-012', 'AP Boots AP TERRA GP Hitam Waterproof PVC Agriculture & Forestry Industrial Boots SNI',
  'Agriculture & Forestry', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  47175, 2.71, 16250.00,
  12, 32.52, 566100,
  '58 x 42 x 38', 0.0960, 17.50,
  300, 708,
  'Professional studio photography of AP Boots AP TERRA GP Hitam, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP TERRA GP Hitam, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP TERRA GP Hitam, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP TERRA GP Hitam in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_GP_Hitam_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_GP_Hitam_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_GP_Hitam_Sepatu_Boot_PVC/side_AP_Boots_TERRA_GP_Hitam_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA GP Hitam - Sepatu Boot PVC Shoes Karet Kerja - 38/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA GP Hitam - Sepatu Boot PVC Shoes Karet Kerja - 38/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10013, 2013, 'MST-013', 'AP Boots AP TERRA 1 Kuning Waterproof PVC Agriculture & Forestry Industrial Boots SNI',
  'Agriculture & Forestry', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  103050, 5.92, 16250.00,
  12, 71.04, 1236600,
  '58 x 42 x 38', 0.0960, 17.50,
  300, 708,
  'Professional studio photography of AP Boots AP TERRA 1 Kuning, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP TERRA 1 Kuning, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP TERRA 1 Kuning, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP TERRA 1 Kuning in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_TERRA_3_HITAM_KUNING_Sepatu_boots_PVC/hero_AP_Boots_AP_TERRA_3_HITAM_KUNING_Sepatu_boots_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_TERRA_3_HITAM_KUNING_Sepatu_boots_PVC/side_AP_Boots_AP_TERRA_3_HITAM_KUNING_Sepatu_boots_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Kuning - Sepatu Boot PVC Shoes Karet - 38/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Kuning - Sepatu Boot PVC Shoes Karet - 38/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10014, 2014, 'MST-014', 'AP Boots AP TERRA 1 Hijau Waterproof PVC Agriculture & Forestry Industrial Boots SNI',
  'Agriculture & Forestry', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  95249, 5.47, 16250.00,
  12, 65.64, 1142988,
  '58 x 42 x 38', 0.0960, 17.50,
  300, 708,
  'Professional studio photography of AP Boots AP TERRA 1 Hijau, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP TERRA 1 Hijau, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP TERRA 1 Hijau, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP TERRA 1 Hijau in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC/side_AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Hijau - Sepatu Boot PVC Shoes Karet - 38/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Hijau - Sepatu Boot PVC Shoes Karet - 38/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10015, 2015, 'MST-015', 'AP Boots AP TERRA 1 Putih Waterproof PVC Agriculture & Forestry Industrial Boots SNI',
  'Agriculture & Forestry', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  108675, 6.24, 16250.00,
  12, 74.88, 1304100,
  '58 x 42 x 38', 0.0960, 17.50,
  300, 708,
  'Professional studio photography of AP Boots AP TERRA 1 Putih, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP TERRA 1 Putih, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP TERRA 1 Putih, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP TERRA 1 Putih in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_1_Putih_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_1_Putih_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_1_Putih_Sepatu_Boot_PVC/side_AP_Boots_TERRA_1_Putih_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Putih - Sepatu Boot PVC Shoes Karet - 38/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Putih - Sepatu Boot PVC Shoes Karet - 38/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10016, 2016, 'MST-016', 'AP Boots AP TERRA ECO 5 Waterproof PVC Agriculture & Forestry Industrial Boots SNI',
  'Agriculture & Forestry', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  70800, 4.07, 16250.00,
  12, 48.84, 849600,
  '58 x 42 x 38', 0.0960, 17.50,
  300, 708,
  'Professional studio photography of AP Boots AP TERRA ECO 5, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP TERRA ECO 5, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP TERRA ECO 5, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP TERRA ECO 5 in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC/side_AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10017, 2017, 'MST-017', 'AP Boots AP TERRA ECO 2 Full Hitam Waterproof PVC Agriculture & Forestry Industrial Boots SNI',
  'Agriculture & Forestry', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  60468, 3.47, 16250.00,
  12, 41.64, 725616,
  '58 x 42 x 38', 0.0960, 17.50,
  300, 708,
  'Professional studio photography of AP Boots AP TERRA ECO 2 Full Hitam, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP TERRA ECO 2 Full Hitam, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP TERRA ECO 2 Full Hitam, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP TERRA ECO 2 Full Hitam in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC/side_AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10018, 2018, 'MST-018', 'AP Boots AP TERRA 3 Hijau Merah Waterproof PVC Agriculture & Forestry Industrial Boots SNI',
  'Agriculture & Forestry', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  94174, 5.41, 16250.00,
  12, 64.92, 1130088,
  '58 x 42 x 38', 0.0960, 17.50,
  300, 708,
  'Professional studio photography of AP Boots AP TERRA 3 Hijau Merah, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP TERRA 3 Hijau Merah, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP TERRA 3 Hijau Merah, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP TERRA 3 Hijau Merah in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_3_Hijau_Merah_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_3_Hijau_Merah_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_3_Hijau_Merah_Sepatu_Boot_PVC/side_AP_Boots_TERRA_3_Hijau_Merah_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 3 Hijau Merah - Sepatu Boot PVC Shoes Karet - 38/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 3 Hijau Merah - Sepatu Boot PVC Shoes Karet - 38/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10019, 2019, 'MST-019', 'AP Boots AP TERRA ARMY Waterproof PVC Agriculture & Forestry Industrial Boots SNI',
  'Agriculture & Forestry', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  128175, 7.36, 16250.00,
  12, 88.32, 1538100,
  '58 x 42 x 38', 0.0960, 17.50,
  300, 708,
  'Professional studio photography of AP Boots AP TERRA ARMY, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP TERRA ARMY, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP TERRA ARMY, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP TERRA ARMY in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_TERRA_ARMY_Sepatu_Boot_PVC/hero_AP_Boots_AP_TERRA_ARMY_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_TERRA_ARMY_Sepatu_Boot_PVC/side_AP_Boots_AP_TERRA_ARMY_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA ARMY - Sepatu Boot PVC Karet Shoes - 40/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA ARMY - Sepatu Boot PVC Karet Shoes - 40/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10020, 2020, 'MST-020', 'AP Boots AP TERRA FOREST Waterproof PVC Agriculture & Forestry Industrial Boots SNI',
  'Agriculture & Forestry', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  128175, 7.36, 16250.00,
  12, 88.32, 1538100,
  '58 x 42 x 38', 0.0960, 17.50,
  300, 708,
  'Professional studio photography of AP Boots AP TERRA FOREST, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP TERRA FOREST, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP TERRA FOREST, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP TERRA FOREST in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_TERRA_FOREST_Sepatu_Boot_PVC/hero_AP_Boots_AP_TERRA_FOREST_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_TERRA_FOREST_Sepatu_Boot_PVC/side_AP_Boots_AP_TERRA_FOREST_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA FOREST - Sepatu Boot PVC Karet Shoes - 40/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots AP TERRA FOREST - Sepatu Boot PVC Karet Shoes - 40/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10021, 2021, 'MST-021', 'AP Boots AP TERRA 3 HITAM KUNING Waterproof PVC Agriculture & Forestry Industrial Boots SNI',
  'Agriculture & Forestry', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  93049, 5.34, 16250.00,
  12, 64.08, 1116588,
  '58 x 42 x 38', 0.0960, 17.50,
  300, 708,
  'Professional studio photography of AP Boots AP TERRA 3 HITAM KUNING, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP TERRA 3 HITAM KUNING, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP TERRA 3 HITAM KUNING, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP TERRA 3 HITAM KUNING in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_TERRA_3_HITAM_KUNING_Sepatu_boots_PVC/hero_AP_Boots_AP_TERRA_3_HITAM_KUNING_Sepatu_boots_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_TERRA_3_HITAM_KUNING_Sepatu_boots_PVC/side_AP_Boots_AP_TERRA_3_HITAM_KUNING_Sepatu_boots_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Kuning - Sepatu Boot PVC Shoes Karet - 38/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Kuning - Sepatu Boot PVC Shoes Karet - 38/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10022, 2022, 'MST-022', 'AP Boots AP TERRA 2 HIJAU Waterproof PVC Agriculture & Forestry Industrial Boots SNI',
  'Agriculture & Forestry', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  95249, 5.47, 16250.00,
  12, 65.64, 1142988,
  '58 x 42 x 38', 0.0960, 17.50,
  300, 708,
  'Professional studio photography of AP Boots AP TERRA 2 HIJAU, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP TERRA 2 HIJAU, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP TERRA 2 HIJAU, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP TERRA 2 HIJAU in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC/side_AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Hijau - Sepatu Boot PVC Shoes Karet - 38/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Hijau - Sepatu Boot PVC Shoes Karet - 38/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10023, 2023, 'MST-023', 'AP Boots Ap Boots TERRA 5 HIJAU Waterproof PVC Agriculture & Forestry Industrial Boots SNI',
  'Agriculture & Forestry', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  95249, 5.47, 16250.00,
  12, 65.64, 1142988,
  '58 x 42 x 38', 0.0960, 17.50,
  300, 708,
  'Professional studio photography of AP Boots Ap Boots TERRA 5 HIJAU, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots Ap Boots TERRA 5 HIJAU, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots Ap Boots TERRA 5 HIJAU, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots Ap Boots TERRA 5 HIJAU in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC/side_AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Hijau - Sepatu Boot PVC Shoes Karet - 38/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA 1 Hijau - Sepatu Boot PVC Shoes Karet - 38/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10024, 2024, 'MST-024', 'AP Boots AP TERRA ECO 5 PUTIH Waterproof PVC Agriculture & Forestry Industrial Boots SNI',
  'Agriculture & Forestry', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  73800, 4.24, 16250.00,
  12, 50.88, 885600,
  '58 x 42 x 38', 0.0960, 17.50,
  300, 708,
  'Professional studio photography of AP Boots AP TERRA ECO 5 PUTIH, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP TERRA ECO 5 PUTIH, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP TERRA ECO 5 PUTIH, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP TERRA ECO 5 PUTIH in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_5_PUTIH_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_5_PUTIH_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_ECO_5_PUTIH_Sepatu_Boot_PVC/side_AP_Boots_TERRA_ECO_5_PUTIH_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA ECO 2 Full Hitam - Sepatu Boot PVC Karet Shoes - 25/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10025, 2025, 'MST-025', 'AP Boots AP TERRA GP Hijau Waterproof PVC Agriculture & Forestry Industrial Boots SNI',
  'Agriculture & Forestry', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  55800, 3.2, 16250.00,
  12, 38.40, 669600,
  '58 x 42 x 38', 0.0960, 17.50,
  300, 708,
  'Professional studio photography of AP Boots AP TERRA GP Hijau, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP TERRA GP Hijau, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP TERRA GP Hijau, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP TERRA GP Hijau in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_GP_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_GP_Hijau_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_TERRA_GP_Hijau_Sepatu_Boot_PVC/side_AP_Boots_TERRA_GP_Hijau_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA GP Hijau - Sepatu Boot PVC Karet Shoes Kerja - 38/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots TERRA GP Hijau - Sepatu Boot PVC Karet Shoes Kerja - 38/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10026, 2026, 'MST-026', 'AP Boots AP Terra Safety S4 Waterproof PVC Agriculture & Forestry Industrial Boots SNI',
  'Agriculture & Forestry', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  205174, 11.78, 16250.00,
  12, 141.36, 2462088,
  '58 x 42 x 38', 0.0960, 17.50,
  300, 708,
  'Professional studio photography of AP Boots AP Terra Safety S4, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Terra Safety S4, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Terra Safety S4, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Terra Safety S4 in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_Terra_Safety_S4_Kuning_Sepatu_Boot_Safety_PVC/hero_AP_Boots_Terra_Safety_S4_Kuning_Sepatu_Boot_Safety_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_Terra_Safety_S4_Kuning_Sepatu_Boot_Safety_PVC/side_AP_Boots_Terra_Safety_S4_Kuning_Sepatu_Boot_Safety_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10027, 2027, 'MST-027', 'AP Boots AP Boots ORCA Waterproof PVC Commercial Marine & Cold  Industrial Boots SNI',
  'Commercial Marine & Cold Storage', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  77343, 4.44, 16250.00,
  12, 53.28, 928116,
  '58 x 42 x 38', 0.0960, 19.50,
  300, 708,
  'Professional studio photography of AP Boots AP Boots ORCA, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots ORCA, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots ORCA, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots ORCA in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_ORCA_Sepatu_Boot_PVC/hero_AP_Boots_ORCA_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_ORCA_Sepatu_Boot_PVC/side_AP_Boots_ORCA_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/photobank/03_Orca_Series/APB-024_ap_boots_orca_realistic_photograph_01.webp', 'https://catalog.hotstrading.com/assets/photobank/03_Orca_Series/APB-024_ap_boots_orca_realistic_photograph_02.webp',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10028, 2028, 'MST-028', 'AP Boots AP Chef Putih Waterproof PVC Food Processing & HORECA Industrial Boots SNI',
  'Food Processing & HORECA', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  154108, 8.85, 16250.00,
  12, 106.20, 1849296,
  '58 x 42 x 38', 0.0960, 11.50,
  300, 708,
  'Professional studio photography of AP Boots AP Chef Putih, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Chef Putih, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Chef Putih, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Chef Putih in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_Chef_Putih_Sepatu_Slip_On_Dapur/hero_AP_Boots_AP_Chef_Putih_Sepatu_Slip_On_Dapur.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_Chef_Putih_Sepatu_Slip_On_Dapur/side_AP_Boots_AP_Chef_Putih_Sepatu_Slip_On_Dapur.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP Chef Putih - Sepatu Slip On Dapur Flat Shoes - 38/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP Chef Putih - Sepatu Slip On Dapur Flat Shoes - 38/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10029, 2029, 'MST-029', 'AP Boots AP Chef Hitam Waterproof PVC Food Processing & HORECA Industrial Boots SNI',
  'Food Processing & HORECA', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  155025, 8.9, 16250.00,
  12, 106.80, 1860300,
  '58 x 42 x 38', 0.0960, 11.50,
  300, 708,
  'Professional studio photography of AP Boots AP Chef Hitam, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Chef Hitam, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Chef Hitam, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Chef Hitam in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_Chef_Hitam_Sepatu_Slip_On_Dapur/hero_AP_Boots_AP_Chef_Hitam_Sepatu_Slip_On_Dapur.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_Chef_Hitam_Sepatu_Slip_On_Dapur/side_AP_Boots_AP_Chef_Hitam_Sepatu_Slip_On_Dapur.webp',
  'https://catalog.hotstrading.com/assets/photobank/04_Chef_Series/SHP_003_AP_Boots_AP_Chef_Hitam_Se_slot_1_hero.webp', 'https://catalog.hotstrading.com/assets/photobank/04_Chef_Series/SHP_003_AP_Boots_AP_Chef_Hitam_Se_slot_2_side.webp',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10030, 2030, 'MST-030', 'AP Boots Footbed Sol AP CHEF Waterproof PVC Food Processing & HORECA Industrial Boots SNI',
  'Food Processing & HORECA', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  98775, 5.67, 16250.00,
  12, 68.04, 1185300,
  '58 x 42 x 38', 0.0960, 11.50,
  300, 708,
  'Professional studio photography of AP Boots Footbed Sol AP CHEF, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots Footbed Sol AP CHEF, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots Footbed Sol AP CHEF, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots Footbed Sol AP CHEF in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_Footbed_Sol_AP_CHEF_Ortholite/hero_AP_Boots_Footbed_Sol_AP_CHEF_Ortholite.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_Footbed_Sol_AP_CHEF_Ortholite/side_AP_Boots_Footbed_Sol_AP_CHEF_Ortholite.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed Sol AP CHEF - Ortholite - 38/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed Sol AP CHEF - Ortholite - 38/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10031, 2031, 'MST-031', 'AP Boots AP MEDIC Biru Waterproof PVC Healthcare & Cleanroom Hy Industrial Boots SNI',
  'Healthcare & Cleanroom Hygiene', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  198750, 11.42, 16250.00,
  12, 137.04, 2385000,
  '58 x 42 x 38', 0.0960, 9.50,
  300, 708,
  'Professional studio photography of AP Boots AP MEDIC Biru, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP MEDIC Biru, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP MEDIC Biru, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP MEDIC Biru in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD/side_AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Biru - Sepatu Medis APD - 36/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Biru - Sepatu Medis APD - 36/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10032, 2032, 'MST-032', 'AP Boots AP MEDIC Hijau Waterproof PVC Healthcare & Cleanroom Hy Industrial Boots SNI',
  'Healthcare & Cleanroom Hygiene', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  203250, 11.67, 16250.00,
  12, 140.04, 2439000,
  '58 x 42 x 38', 0.0960, 9.50,
  300, 708,
  'Professional studio photography of AP Boots AP MEDIC Hijau, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP MEDIC Hijau, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP MEDIC Hijau, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP MEDIC Hijau in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Hijau_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Hijau_Sepatu_Medis_APD.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Hijau_Sepatu_Medis_APD/side_AP_Boots_AP_MEDIC_Hijau_Sepatu_Medis_APD.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hijau - Sepatu Medis APD - 36/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hijau - Sepatu Medis APD - 36/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10033, 2033, 'MST-033', 'AP Boots AP MEDIC Putih Waterproof PVC Healthcare & Cleanroom Hy Industrial Boots SNI',
  'Healthcare & Cleanroom Hygiene', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  194655, 11.18, 16250.00,
  12, 134.16, 2335860,
  '58 x 42 x 38', 0.0960, 9.50,
  300, 708,
  'Professional studio photography of AP Boots AP MEDIC Putih, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP MEDIC Putih, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP MEDIC Putih, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP MEDIC Putih in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Putih_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Putih_Sepatu_Medis_APD.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Putih_Sepatu_Medis_APD/side_AP_Boots_AP_MEDIC_Putih_Sepatu_Medis_APD.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Putih - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Putih - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10034, 2034, 'MST-034', 'AP Boots Footbed SOL AP Medic Biru Waterproof PVC Healthcare & Cleanroom Hy Industrial Boots SNI',
  'Healthcare & Cleanroom Hygiene', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  157500, 9.05, 16250.00,
  12, 108.60, 1890000,
  '58 x 42 x 38', 0.0960, 9.50,
  300, 708,
  'Professional studio photography of AP Boots Footbed SOL AP Medic Biru, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots Footbed SOL AP Medic Biru, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots Footbed SOL AP Medic Biru, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots Footbed SOL AP Medic Biru in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD/side_AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Biru - Ortholite - 37/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Biru - Ortholite - 37/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10035, 2035, 'MST-035', 'AP Boots Footbed SOL AP Medic Kuning Waterproof PVC Healthcare & Cleanroom Hy Industrial Boots SNI',
  'Healthcare & Cleanroom Hygiene', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  117750, 6.76, 16250.00,
  12, 81.12, 1413000,
  '58 x 42 x 38', 0.0960, 9.50,
  300, 708,
  'Professional studio photography of AP Boots Footbed SOL AP Medic Kuning, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots Footbed SOL AP Medic Kuning, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots Footbed SOL AP Medic Kuning, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots Footbed SOL AP Medic Kuning in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD/side_AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Kuning - Ortholite - 36/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots Footbed SOL AP Medic Kuning - Ortholite - 36/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10036, 2036, 'MST-036', 'AP Boots AP MEDIC Pink Waterproof PVC Healthcare & Cleanroom Hy Industrial Boots SNI',
  'Healthcare & Cleanroom Hygiene', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  214249, 12.31, 16250.00,
  12, 147.72, 2570988,
  '58 x 42 x 38', 0.0960, 9.50,
  300, 708,
  'Professional studio photography of AP Boots AP MEDIC Pink, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP MEDIC Pink, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP MEDIC Pink, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP MEDIC Pink in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Pink_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Pink_Sepatu_Medis_APD.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Pink_Sepatu_Medis_APD/side_AP_Boots_AP_MEDIC_Pink_Sepatu_Medis_APD.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Pink - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Pink - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10037, 2037, 'MST-037', 'AP Boots AP MEDIC Hitam Waterproof PVC Healthcare & Cleanroom Hy Industrial Boots SNI',
  'Healthcare & Cleanroom Hygiene', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  209250, 12.02, 16250.00,
  12, 144.24, 2511000,
  '58 x 42 x 38', 0.0960, 9.50,
  300, 708,
  'Professional studio photography of AP Boots AP MEDIC Hitam, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP MEDIC Hitam, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP MEDIC Hitam, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP MEDIC Hitam in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Hitam_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Hitam_Sepatu_Medis_APD.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_MEDIC_Hitam_Sepatu_Medis_APD/side_AP_Boots_AP_MEDIC_Hitam_Sepatu_Medis_APD.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10038, 2038, 'MST-038', 'AP Boots AP ALLBIKE Orange Waterproof PVC Commuter & Courier Logist Industrial Boots SNI',
  'Commuter & Courier Logistics', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  49612, 2.85, 16250.00,
  12, 34.20, 595344,
  '58 x 42 x 38', 0.0960, 12.50,
  300, 708,
  'Professional studio photography of AP Boots AP ALLBIKE Orange, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP ALLBIKE Orange, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP ALLBIKE Orange, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP ALLBIKE Orange in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_ORANGE_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_ORANGE_Sepatu_Bike_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_ORANGE_Sepatu_Bike_PVC/side_AP_Boots_ALLBIKE_2_ORANGE_Sepatu_Bike_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ORANGE - Sepatu Bike PVC Outdoor Sepeda - 39/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ORANGE - Sepatu Bike PVC Outdoor Sepeda - 39/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10039, 2039, 'MST-039', 'AP Boots AP ALLBIKE 2 ORANGE Waterproof PVC Commuter & Courier Logist Industrial Boots SNI',
  'Commuter & Courier Logistics', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  49612, 2.85, 16250.00,
  12, 34.20, 595344,
  '58 x 42 x 38', 0.0960, 12.50,
  300, 708,
  'Professional studio photography of AP Boots AP ALLBIKE 2 ORANGE, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP ALLBIKE 2 ORANGE, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP ALLBIKE 2 ORANGE, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP ALLBIKE 2 ORANGE in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_ORANGE_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_ORANGE_Sepatu_Bike_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_ORANGE_Sepatu_Bike_PVC/side_AP_Boots_ALLBIKE_2_ORANGE_Sepatu_Bike_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ORANGE - Sepatu Bike PVC Outdoor Sepeda - 39/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ORANGE - Sepatu Bike PVC Outdoor Sepeda - 39/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10040, 2040, 'MST-040', 'AP Boots AP Boots Hobby N Work Waterproof PVC Commuter & Courier Logist Industrial Boots SNI',
  'Commuter & Courier Logistics', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  73050, 4.2, 16250.00,
  12, 50.40, 876600,
  '58 x 42 x 38', 0.0960, 12.50,
  300, 708,
  'Professional studio photography of AP Boots AP Boots Hobby N Work, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots Hobby N Work, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots Hobby N Work, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots Hobby N Work in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_Hobby_N_Work_Sepatu_Boot_PVC/hero_AP_Boots_Hobby_N_Work_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_Hobby_N_Work_Sepatu_Boot_PVC/side_AP_Boots_Hobby_N_Work_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/photobank/06_Biker_Casual/APB-031_ap_boots_hobby_n_work_01.webp', 'https://catalog.hotstrading.com/assets/photobank/06_Biker_Casual/APB-031_ap_boots_hobby_n_work_02.webp',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10041, 2041, 'MST-041', 'AP Boots AP ALLBIKE Abu Waterproof PVC Commuter & Courier Logist Industrial Boots SNI',
  'Commuter & Courier Logistics', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  49612, 2.85, 16250.00,
  12, 34.20, 595344,
  '58 x 42 x 38', 0.0960, 12.50,
  300, 708,
  'Professional studio photography of AP Boots AP ALLBIKE Abu, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP ALLBIKE Abu, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP ALLBIKE Abu, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP ALLBIKE Abu in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC/side_AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ABU - Sepatu Bike PVC - 39, Abu-abu/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ABU - Sepatu Bike PVC - 39, Abu-abu/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10042, 2042, 'MST-042', 'AP Boots AP ALLBIKE 2 HIJAU Waterproof PVC Commuter & Courier Logist Industrial Boots SNI',
  'Commuter & Courier Logistics', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  46425, 2.67, 16250.00,
  12, 32.04, 557100,
  '58 x 42 x 38', 0.0960, 12.50,
  300, 708,
  'Professional studio photography of AP Boots AP ALLBIKE 2 HIJAU, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP ALLBIKE 2 HIJAU, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP ALLBIKE 2 HIJAU, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP ALLBIKE 2 HIJAU in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_HIJAU_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_HIJAU_Sepatu_Bike_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_HIJAU_Sepatu_Bike_PVC/side_AP_Boots_ALLBIKE_2_HIJAU_Sepatu_Bike_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 HIJAU - Sepatu Bike PVC - 39, Hijau/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 HIJAU - Sepatu Bike PVC - 39, Hijau/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10043, 2043, 'MST-043', 'AP Boots AP ALLBIKE 2 ABU Waterproof PVC Commuter & Courier Logist Industrial Boots SNI',
  'Commuter & Courier Logistics', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  49612, 2.85, 16250.00,
  12, 34.20, 595344,
  '58 x 42 x 38', 0.0960, 12.50,
  300, 708,
  'Professional studio photography of AP Boots AP ALLBIKE 2 ABU, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP ALLBIKE 2 ABU, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP ALLBIKE 2 ABU, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP ALLBIKE 2 ABU in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC/side_AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ABU - Sepatu Bike PVC - 39, Abu-abu/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 ABU - Sepatu Bike PVC - 39, Abu-abu/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10044, 2044, 'MST-044', 'AP Boots AP Boots MOTO 1 Waterproof PVC Commuter & Courier Logist Industrial Boots SNI',
  'Commuter & Courier Logistics', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  101325, 5.82, 16250.00,
  12, 69.84, 1215900,
  '58 x 42 x 38', 0.0960, 12.50,
  300, 708,
  'Professional studio photography of AP Boots AP Boots MOTO 1, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots MOTO 1, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots MOTO 1, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots MOTO 1 in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_MOTO_1_Sepatu_Boot_PVC/hero_AP_Boots_MOTO_1_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_MOTO_1_Sepatu_Boot_PVC/side_AP_Boots_MOTO_1_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/photobank/06_Biker_Casual/SHP_016_AP_Boots_MOTO_1_Sepatu_Bo_slot_1_hero.webp', 'https://catalog.hotstrading.com/assets/photobank/06_Biker_Casual/SHP_016_AP_Boots_MOTO_1_Sepatu_Bo_slot_2_side.webp',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10045, 2045, 'MST-045', 'AP Boots AP Boots MOTO 2 Waterproof PVC Commuter & Courier Logist Industrial Boots SNI',
  'Commuter & Courier Logistics', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  101325, 5.82, 16250.00,
  12, 69.84, 1215900,
  '58 x 42 x 38', 0.0960, 12.50,
  300, 708,
  'Professional studio photography of AP Boots AP Boots MOTO 2, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots MOTO 2, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots MOTO 2, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots MOTO 2 in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_MOTO_1_Sepatu_Boot_PVC/hero_AP_Boots_MOTO_1_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_MOTO_1_Sepatu_Boot_PVC/side_AP_Boots_MOTO_1_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/photobank/06_Biker_Casual/SHP_009_AP_Boots_MOTO_2_Sepatu_Bo_slot_1_hero.webp', 'https://catalog.hotstrading.com/assets/photobank/06_Biker_Casual/SHP_009_AP_Boots_MOTO_2_Sepatu_Bo_slot_2_side.webp',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10046, 2046, 'MST-046', 'AP Boots AP Boots MOTO 3 Waterproof PVC Commuter & Courier Logist Industrial Boots SNI',
  'Commuter & Courier Logistics', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  101325, 5.82, 16250.00,
  12, 69.84, 1215900,
  '58 x 42 x 38', 0.0960, 12.50,
  300, 708,
  'Professional studio photography of AP Boots AP Boots MOTO 3, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots MOTO 3, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots MOTO 3, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots MOTO 3 in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_MOTO_1_Sepatu_Boot_PVC/hero_AP_Boots_MOTO_1_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_MOTO_1_Sepatu_Boot_PVC/side_AP_Boots_MOTO_1_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/photobank/06_Biker_Casual/SHP_018_AP_Boots_MOTO_3_Sepatu_Bo_slot_1_hero.webp', 'https://catalog.hotstrading.com/assets/photobank/06_Biker_Casual/SHP_018_AP_Boots_MOTO_3_Sepatu_Bo_slot_2_side.webp',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10047, 2047, 'MST-047', 'AP Boots AP ALLBIKE 2 Waterproof PVC Commuter & Courier Logist Industrial Boots SNI',
  'Commuter & Courier Logistics', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  44175, 2.54, 16250.00,
  12, 30.48, 530100,
  '58 x 42 x 38', 0.0960, 12.50,
  300, 708,
  'Professional studio photography of AP Boots AP ALLBIKE 2, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP ALLBIKE 2, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP ALLBIKE 2, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP ALLBIKE 2 in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC/side_AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 - Sepatu Bike PVC/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 - Sepatu Bike PVC/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10048, 2048, 'MST-048', 'AP Boots AP ALLBIKE Hijau Waterproof PVC Commuter & Courier Logist Industrial Boots SNI',
  'Commuter & Courier Logistics', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  46425, 2.67, 16250.00,
  12, 32.04, 557100,
  '58 x 42 x 38', 0.0960, 12.50,
  300, 708,
  'Professional studio photography of AP Boots AP ALLBIKE Hijau, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP ALLBIKE Hijau, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP ALLBIKE Hijau, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP ALLBIKE Hijau in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_HIJAU_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_HIJAU_Sepatu_Bike_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_HIJAU_Sepatu_Bike_PVC/side_AP_Boots_ALLBIKE_2_HIJAU_Sepatu_Bike_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 HIJAU - Sepatu Bike PVC - 39, Hijau/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE 2 HIJAU - Sepatu Bike PVC - 39, Hijau/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10049, 2049, 'MST-049', 'AP Boots AP ALLBIKE Merah Waterproof PVC Commuter & Courier Logist Industrial Boots SNI',
  'Commuter & Courier Logistics', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  46425, 2.67, 16250.00,
  12, 32.04, 557100,
  '58 x 42 x 38', 0.0960, 12.50,
  300, 708,
  'Professional studio photography of AP Boots AP ALLBIKE Merah, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP ALLBIKE Merah, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP ALLBIKE Merah, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP ALLBIKE Merah in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_MERAH_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_MERAH_Sepatu_Bike_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_ALLBIKE_2_MERAH_Sepatu_Bike_PVC/side_AP_Boots_ALLBIKE_2_MERAH_Sepatu_Bike_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Merah - Sepatu Bike PVC Outdoor Sepeda - 38/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/08_AP_Biker_Casual_Shoes/AP Boots ALLBIKE Merah - Sepatu Bike PVC Outdoor Sepeda - 38/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10050, 2050, 'MST-050', 'AP Boots AP Boots 2017 GREEN LIME Waterproof PVC Sanitation & Monsoon Util Industrial Boots SNI',
  'Sanitation & Monsoon Utilities', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  88537, 5.09, 16250.00,
  12, 61.08, 1062444,
  '58 x 42 x 38', 0.0960, 18.00,
  300, 708,
  'Professional studio photography of AP Boots AP Boots 2017 GREEN LIME, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots 2017 GREEN LIME, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots 2017 GREEN LIME, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots 2017 GREEN LIME in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2017_GREEN_LIME_Sepatu_Boot_PVC/hero_AP_Boots_2017_GREEN_LIME_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2017_GREEN_LIME_Sepatu_Boot_PVC/side_AP_Boots_2017_GREEN_LIME_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 GREEN LIME - Sepatu Boot PVC Karet Shoes - 37/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 GREEN LIME - Sepatu Boot PVC Karet Shoes - 37/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
);

INSERT INTO `alibaba_export_listings` (
  `id`, `product_id`, `sku`, `alibaba_product_title`, `category_group`, `target_continent`,
  `target_country`, `target_industry_angle`, `primary_keyword_1`, `primary_keyword_2`,
  `primary_keyword_3`, `longtail_keywords`, `base_price_idr`, `fob_price_usd`, `exchange_rate_used`,
  `pairs_per_carton`, `carton_price_usd`, `carton_price_idr`, `carton_dimensions_cm`,
  `cbm_per_carton`, `gross_weight_kg_per_carton`, `capacity_20ft_cartons`, `capacity_40ft_hc_cartons`,
  `prompt_slot_1_hero`, `prompt_slot_2_side`, `prompt_slot_3_tread`, `prompt_slot_4_contextual`,
  `image_slot_1`, `image_slot_2`, `image_slot_3`, `image_slot_4`, `image_slot_5`, `image_slot_6`,
  `export_status`, `last_error_message`, `created_at`, `updated_at`
) VALUES
(
  10051, 2051, 'MST-051', 'AP Boots AP Boots 2017 Green Waterproof PVC Sanitation & Monsoon Util Industrial Boots SNI',
  'Sanitation & Monsoon Utilities', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  88537, 5.09, 16250.00,
  12, 61.08, 1062444,
  '58 x 42 x 38', 0.0960, 18.00,
  300, 708,
  'Professional studio photography of AP Boots AP Boots 2017 Green, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots 2017 Green, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots 2017 Green, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots 2017 Green in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2017_GREEN_LIME_Sepatu_Boot_PVC/hero_AP_Boots_2017_GREEN_LIME_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2017_GREEN_LIME_Sepatu_Boot_PVC/side_AP_Boots_2017_GREEN_LIME_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/photobank/07_Classic_Boots/APB-002_ap_boots_2017_green_product.webp', 'https://catalog.hotstrading.com/assets/photobank/07_Classic_Boots/SHP_006_AP_Boots_2017_Green_Sepat_slot_1_hero.webp',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10052, 2052, 'MST-052', 'AP Boots AP Boots 2005 ROOTS N LEAVES Waterproof PVC Sanitation & Monsoon Util Industrial Boots SNI',
  'Sanitation & Monsoon Utilities', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  67631, 3.88, 16250.00,
  12, 46.56, 811572,
  '58 x 42 x 38', 0.0960, 18.00,
  300, 708,
  'Professional studio photography of AP Boots AP Boots 2005 ROOTS N LEAVES, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots 2005 ROOTS N LEAVES, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots 2005 ROOTS N LEAVES, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots 2005 ROOTS N LEAVES in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2005_ROOTS_N_LEAVES_Sepatu_Boot_PVC/hero_AP_Boots_2005_ROOTS_N_LEAVES_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2005_ROOTS_N_LEAVES_Sepatu_Boot_PVC/side_AP_Boots_2005_ROOTS_N_LEAVES_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2005 ROOTS N LEAVES - Sepatu Boot PVC Karet Wanita Wanita Sho/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2005 ROOTS N LEAVES - Sepatu Boot PVC Karet Wanita Wanita Sho/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10053, 2053, 'MST-053', 'AP Boots AP Boots 2005 Hijau Waterproof PVC Sanitation & Monsoon Util Industrial Boots SNI',
  'Sanitation & Monsoon Utilities', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  53287, 3.06, 16250.00,
  12, 36.72, 639444,
  '58 x 42 x 38', 0.0960, 18.00,
  300, 708,
  'Professional studio photography of AP Boots AP Boots 2005 Hijau, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots 2005 Hijau, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots 2005 Hijau, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots 2005 Hijau in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2005_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_2005_Hijau_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2005_Hijau_Sepatu_Boot_PVC/side_AP_Boots_2005_Hijau_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/photobank/07_Classic_Boots/APB-005_ap_boots_2005_hijau.webp', 'https://catalog.hotstrading.com/assets/photobank/07_Classic_Boots/SHP_014_AP_Boots_2005_Hijau_Sepat_slot_1_hero.webp',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10054, 2054, 'MST-054', 'AP Boots AP Boots 2003 Hijau TRICOLOUR Waterproof PVC Sanitation & Monsoon Util Industrial Boots SNI',
  'Sanitation & Monsoon Utilities', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  111374, 6.4, 16250.00,
  12, 76.80, 1336488,
  '58 x 42 x 38', 0.0960, 18.00,
  300, 708,
  'Professional studio photography of AP Boots AP Boots 2003 Hijau TRICOLOUR, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots 2003 Hijau TRICOLOUR, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots 2003 Hijau TRICOLOUR, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots 2003 Hijau TRICOLOUR in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2003_Hijau_TRICOLOUR_Sepatu_Boot_PVC/hero_AP_Boots_2003_Hijau_TRICOLOUR_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2003_Hijau_TRICOLOUR_Sepatu_Boot_PVC/side_AP_Boots_2003_Hijau_TRICOLOUR_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/photobank/07_Classic_Boots/APB-006_ap_boots_2003_hijau_tricolour.webp', 'https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2003 Hijau TRICOLOUR - Sepatu Boot PVC Karet Shoes - 37/01_main_1600x1600.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10055, 2055, 'MST-055', 'AP Boots AP Boots 2017 Tosca Waterproof PVC Sanitation & Monsoon Util Industrial Boots SNI',
  'Sanitation & Monsoon Utilities', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  88037, 5.06, 16250.00,
  12, 60.72, 1056444,
  '58 x 42 x 38', 0.0960, 18.00,
  300, 708,
  'Professional studio photography of AP Boots AP Boots 2017 Tosca, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots 2017 Tosca, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots 2017 Tosca, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots 2017 Tosca in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2017_Tosca_Sepatu_Boot_PVC/hero_AP_Boots_2017_Tosca_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2017_Tosca_Sepatu_Boot_PVC/side_AP_Boots_2017_Tosca_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 Tosca - Sepatu Boot PVC - 37/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2017 Tosca - Sepatu Boot PVC - 37/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10056, 2056, 'MST-056', 'AP Boots AP Boots AP 969 Putih Cream Waterproof PVC Fashion Waterproof Footwe Industrial Boots SNI',
  'Fashion Waterproof Footwear', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  33324, 1.91, 16250.00,
  12, 22.92, 399888,
  '58 x 42 x 38', 0.0960, 11.50,
  300, 708,
  'Professional studio photography of AP Boots AP Boots AP 969 Putih Cream, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots AP 969 Putih Cream, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots AP 969 Putih Cream, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots AP 969 Putih Cream in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_969_Putih_Cream_Sepatu_Bola_PVC/hero_AP_Boots_AP_969_Putih_Cream_Sepatu_Bola_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_969_Putih_Cream_Sepatu_Bola_PVC/side_AP_Boots_AP_969_Putih_Cream_Sepatu_Bola_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP 969 Putih Cream - Sepatu Bola PVC - 37/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP 969 Putih Cream - Sepatu Bola PVC - 37/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10057, 2057, 'MST-057', 'AP Boots AP Boots XT Hijau Waterproof PVC Sanitation & Monsoon Util Industrial Boots SNI',
  'Sanitation & Monsoon Utilities', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  108675, 6.24, 16250.00,
  12, 74.88, 1304100,
  '58 x 42 x 38', 0.0960, 18.00,
  300, 708,
  'Professional studio photography of AP Boots AP Boots XT Hijau, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots XT Hijau, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots XT Hijau, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots XT Hijau in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_XT_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_XT_Hijau_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_XT_Hijau_Sepatu_Boot_PVC/side_AP_Boots_XT_Hijau_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_XT_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_XT_Hijau_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_XT_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_XT_Hijau_Sepatu_Boot_PVC.webp',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10058, 2058, 'MST-058', 'AP Boots AP Boots 9506 Hijau Waterproof PVC Sanitation & Monsoon Util Industrial Boots SNI',
  'Sanitation & Monsoon Utilities', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  110883, 6.37, 16250.00,
  12, 76.44, 1330596,
  '58 x 42 x 38', 0.0960, 18.00,
  300, 708,
  'Professional studio photography of AP Boots AP Boots 9506 Hijau, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots 9506 Hijau, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots 9506 Hijau, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots 9506 Hijau in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_9506_Sepatu_Boot_PVC/hero_AP_Boots_9506_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_9506_Sepatu_Boot_PVC/side_AP_Boots_9506_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 9506 Hijau - Sepatu Boot PVC Karet Shoes - 38/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 9506 Hijau - Sepatu Boot PVC Karet Shoes - 38/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10059, 2059, 'MST-059', 'AP Boots AP Boots AP 963 Putih Waterproof PVC Fashion Waterproof Footwe Industrial Boots SNI',
  'Fashion Waterproof Footwear', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  28593, 1.64, 16250.00,
  12, 19.68, 343116,
  '58 x 42 x 38', 0.0960, 11.50,
  300, 708,
  'Professional studio photography of AP Boots AP Boots AP 963 Putih, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots AP 963 Putih, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots AP 963 Putih, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots AP 963 Putih in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_963_Putih_Sepatu_Bola_PVC/hero_AP_Boots_AP_963_Putih_Sepatu_Bola_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_963_Putih_Sepatu_Bola_PVC/side_AP_Boots_AP_963_Putih_Sepatu_Bola_PVC.webp',
  'https://catalog.hotstrading.com/assets/photobank/10_Kasual_Sneakers/SHP_011_AP_Boots_AP_963_Putih_Sep_slot_1_hero.webp', 'https://catalog.hotstrading.com/assets/photobank/10_Kasual_Sneakers/SHP_011_AP_Boots_AP_963_Putih_Sep_slot_2_side.webp',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10060, 2060, 'MST-060', 'AP Boots AP Boots AP 1 Hitam Waterproof PVC Sanitation & Monsoon Util Industrial Boots SNI',
  'Sanitation & Monsoon Utilities', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  63750, 3.66, 16250.00,
  12, 43.92, 765000,
  '58 x 42 x 38', 0.0960, 18.00,
  300, 708,
  'Professional studio photography of AP Boots AP Boots AP 1 Hitam, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots AP 1 Hitam, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots AP 1 Hitam, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots AP 1 Hitam in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_1001_HITAM_Sandal_Selop/hero_Ap_Boots_1001_HITAM_Sandal_Selop.webp', 'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_1001_HITAM_Sandal_Selop/side_Ap_Boots_1001_HITAM_Sandal_Selop.webp',
  'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_1001_HITAM_Sandal_Selop/hero_Ap_Boots_1001_HITAM_Sandal_Selop.webp', 'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_1001_HITAM_Sandal_Selop/hero_Ap_Boots_1001_HITAM_Sandal_Selop.webp',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10061, 2061, 'MST-061', 'AP Boots AP Boots AP 1 Putih Waterproof PVC Sanitation & Monsoon Util Industrial Boots SNI',
  'Sanitation & Monsoon Utilities', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  63750, 3.66, 16250.00,
  12, 43.92, 765000,
  '58 x 42 x 38', 0.0960, 18.00,
  300, 708,
  'Professional studio photography of AP Boots AP Boots AP 1 Putih, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots AP 1 Putih, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots AP 1 Putih, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots AP 1 Putih in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_1_Putih_Sepatu_Boots_PVC/hero_AP_Boots_AP_1_Putih_Sepatu_Boots_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_1_Putih_Sepatu_Boots_PVC/side_AP_Boots_AP_1_Putih_Sepatu_Boots_PVC.webp',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_1_Putih_Sepatu_Boots_PVC/hero_AP_Boots_AP_1_Putih_Sepatu_Boots_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_1_Putih_Sepatu_Boots_PVC/hero_AP_Boots_AP_1_Putih_Sepatu_Boots_PVC.webp',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10062, 2062, 'MST-062', 'AP Boots AP Boots 9303 Waterproof PVC Sanitation & Monsoon Util Industrial Boots SNI',
  'Sanitation & Monsoon Utilities', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  98662, 5.67, 16250.00,
  12, 68.04, 1183944,
  '58 x 42 x 38', 0.0960, 18.00,
  300, 708,
  'Professional studio photography of AP Boots AP Boots 9303, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots 9303, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots 9303, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots 9303 in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_9303_Sepatu_Boot_PVC/hero_AP_Boots_9303_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_9303_Sepatu_Boot_PVC/side_AP_Boots_9303_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/photobank/07_Classic_Boots/APB-034_ap_boots_9303_rear_view_01.webp', 'https://catalog.hotstrading.com/assets/photobank/07_Classic_Boots/APB-034_ap_boots_9303_rear_view_02.webp',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10063, 2063, 'MST-063', 'AP Boots AP Boots AP 977 Hitam Waterproof PVC Fashion Waterproof Footwe Industrial Boots SNI',
  'Fashion Waterproof Footwear', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  42393, 2.43, 16250.00,
  12, 29.16, 508716,
  '58 x 42 x 38', 0.0960, 11.50,
  300, 708,
  'Professional studio photography of AP Boots AP Boots AP 977 Hitam, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots AP 977 Hitam, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots AP 977 Hitam, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots AP 977 Hitam in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_977_Hitam_Sepatu_Pantofel_PVC/hero_AP_Boots_AP_977_Hitam_Sepatu_Pantofel_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_977_Hitam_Sepatu_Pantofel_PVC/side_AP_Boots_AP_977_Hitam_Sepatu_Pantofel_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP 977 Hitam - Sepatu Pantofel PVC Flat Shoes - 37/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP 977 Hitam - Sepatu Pantofel PVC Flat Shoes - 37/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10064, 2064, 'MST-064', 'AP Boots AP Boots AP 2011 Hijau Waterproof PVC Sanitation & Monsoon Util Industrial Boots SNI',
  'Sanitation & Monsoon Utilities', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  67631, 3.88, 16250.00,
  12, 46.56, 811572,
  '58 x 42 x 38', 0.0960, 18.00,
  300, 708,
  'Professional studio photography of AP Boots AP Boots AP 2011 Hijau, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots AP 2011 Hijau, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots AP 2011 Hijau, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots AP 2011 Hijau in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_2011_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_AP_2011_Hijau_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_2011_Hijau_Sepatu_Boot_PVC/side_AP_Boots_AP_2011_Hijau_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/photobank/07_Classic_Boots/SHP_017_AP_Boots_AP_2011_Hijau_Se_slot_1_hero.webp', 'https://catalog.hotstrading.com/assets/photobank/07_Classic_Boots/SHP_017_AP_Boots_AP_2011_Hijau_Se_slot_2_side.webp',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10065, 2065, 'MST-065', 'AP Boots AP Boots 2018 Ultraflex Biru Waterproof PVC Sanitation & Monsoon Util Industrial Boots SNI',
  'Sanitation & Monsoon Utilities', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  140674, 8.08, 16250.00,
  12, 96.96, 1688088,
  '58 x 42 x 38', 0.0960, 18.00,
  300, 708,
  'Professional studio photography of AP Boots AP Boots 2018 Ultraflex Biru, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots 2018 Ultraflex Biru, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots 2018 Ultraflex Biru, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots 2018 Ultraflex Biru in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2018_Ultraflex_Biru_Sepatu_Boot_PVC/hero_AP_Boots_2018_Ultraflex_Biru_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2018_Ultraflex_Biru_Sepatu_Boot_PVC/side_AP_Boots_2018_Ultraflex_Biru_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Biru - Sepatu Boot PVC - 39/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Biru - Sepatu Boot PVC - 39/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10066, 2066, 'MST-066', 'AP Boots Ap Boots AP 3 BLACK Waterproof PVC Sanitation & Monsoon Util Industrial Boots SNI',
  'Sanitation & Monsoon Utilities', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  63750, 3.66, 16250.00,
  12, 43.92, 765000,
  '58 x 42 x 38', 0.0960, 18.00,
  300, 708,
  'Professional studio photography of AP Boots Ap Boots AP 3 BLACK, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots Ap Boots AP 3 BLACK, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots Ap Boots AP 3 BLACK, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots Ap Boots AP 3 BLACK in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_AP_3_BLACK_Sepatu_Boots_PVC/hero_Ap_Boots_AP_3_BLACK_Sepatu_Boots_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_AP_3_BLACK_Sepatu_Boots_PVC/side_Ap_Boots_AP_3_BLACK_Sepatu_Boots_PVC.webp',
  'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_AP_3_BLACK_Sepatu_Boots_PVC/hero_Ap_Boots_AP_3_BLACK_Sepatu_Boots_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_AP_3_BLACK_Sepatu_Boots_PVC/hero_Ap_Boots_AP_3_BLACK_Sepatu_Boots_PVC.webp',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10067, 2067, 'MST-067', 'AP Boots Ap Boots 9905 HITAM Waterproof PVC Sanitation & Monsoon Util Industrial Boots SNI',
  'Sanitation & Monsoon Utilities', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  87049, 5.0, 16250.00,
  12, 60.00, 1044588,
  '58 x 42 x 38', 0.0960, 18.00,
  300, 708,
  'Professional studio photography of AP Boots Ap Boots 9905 HITAM, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots Ap Boots 9905 HITAM, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots Ap Boots 9905 HITAM, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots Ap Boots 9905 HITAM in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_9905_HITAM_Sepatu_Boots_PVC/hero_Ap_Boots_9905_HITAM_Sepatu_Boots_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_9905_HITAM_Sepatu_Boots_PVC/side_Ap_Boots_9905_HITAM_Sepatu_Boots_PVC.webp',
  'https://catalog.hotstrading.com/assets/photobank/11_General_Lifestyle_Boots/SHP_008_Ap_Boots_9905_HITAM_Sepat_slot_1_hero.webp', 'https://catalog.hotstrading.com/assets/photobank/11_General_Lifestyle_Boots/SHP_008_Ap_Boots_9905_HITAM_Sepat_slot_2_side.webp',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10068, 2068, 'MST-068', 'AP Boots AP Boots AP 963 Cream Waterproof PVC Fashion Waterproof Footwe Industrial Boots SNI',
  'Fashion Waterproof Footwear', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  28875, 1.66, 16250.00,
  12, 19.92, 346500,
  '58 x 42 x 38', 0.0960, 11.50,
  300, 708,
  'Professional studio photography of AP Boots AP Boots AP 963 Cream, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots AP 963 Cream, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots AP 963 Cream, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots AP 963 Cream in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_963_Cream_Sepatu_Bola_PVC/hero_AP_Boots_AP_963_Cream_Sepatu_Bola_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_963_Cream_Sepatu_Bola_PVC/side_AP_Boots_AP_963_Cream_Sepatu_Bola_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/11_AP_Specialty_Sports/AP Boots AP 963 Cream - Sepatu Bola PVC - 37/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/11_AP_Specialty_Sports/AP Boots AP 963 Cream - Sepatu Bola PVC - 37/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10069, 2069, 'MST-069', 'AP Boots AP Boots AP 967 Hitam Waterproof PVC Fashion Waterproof Footwe Industrial Boots SNI',
  'Fashion Waterproof Footwear', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  29925, 1.72, 16250.00,
  12, 20.64, 359100,
  '58 x 42 x 38', 0.0960, 11.50,
  300, 708,
  'Professional studio photography of AP Boots AP Boots AP 967 Hitam, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots AP 967 Hitam, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots AP 967 Hitam, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots AP 967 Hitam in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_967_Hitam_Sepatu_Bola_PVC/hero_AP_Boots_AP_967_Hitam_Sepatu_Bola_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_967_Hitam_Sepatu_Bola_PVC/side_AP_Boots_AP_967_Hitam_Sepatu_Bola_PVC.webp',
  'https://catalog.hotstrading.com/assets/photobank/10_Kasual_Sneakers/SHP_020_AP_Boots_AP_967_Hitam_Sep_slot_1_hero.webp', 'https://catalog.hotstrading.com/assets/photobank/10_Kasual_Sneakers/SHP_020_AP_Boots_AP_967_Hitam_Sep_slot_2_side.webp',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10070, 2070, 'MST-070', 'AP Boots AP Boots 2015 Ultimate Abu Waterproof PVC Sanitation & Monsoon Util Industrial Boots SNI',
  'Sanitation & Monsoon Utilities', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  122249, 7.02, 16250.00,
  12, 84.24, 1466988,
  '58 x 42 x 38', 0.0960, 18.00,
  300, 708,
  'Professional studio photography of AP Boots AP Boots 2015 Ultimate Abu, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots 2015 Ultimate Abu, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots 2015 Ultimate Abu, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots 2015 Ultimate Abu in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2015_Ultimate_Abu_Sepatu_Boot_PVC/hero_AP_Boots_2015_Ultimate_Abu_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2015_Ultimate_Abu_Sepatu_Boot_PVC/side_AP_Boots_2015_Ultimate_Abu_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Abu - Sepatu Boot PVC Shoes Karet/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Abu - Sepatu Boot PVC Shoes Karet/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10071, 2071, 'MST-071', 'AP Boots AP Boots 2015 Ultimate Hitam Waterproof PVC Sanitation & Monsoon Util Industrial Boots SNI',
  'Sanitation & Monsoon Utilities', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  126849, 7.29, 16250.00,
  12, 87.48, 1522188,
  '58 x 42 x 38', 0.0960, 18.00,
  300, 708,
  'Professional studio photography of AP Boots AP Boots 2015 Ultimate Hitam, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots 2015 Ultimate Hitam, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots 2015 Ultimate Hitam, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots 2015 Ultimate Hitam in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2015_Ultimate_Hitam_Sepatu_PVC/hero_AP_Boots_2015_Ultimate_Hitam_Sepatu_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2015_Ultimate_Hitam_Sepatu_PVC/side_AP_Boots_2015_Ultimate_Hitam_Sepatu_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Hitam - Sepatu PVC Shoes Karet/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Hitam - Sepatu PVC Shoes Karet/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10072, 2072, 'MST-072', 'AP Boots AP Boots 2015 Ultimate Hijau Waterproof PVC Sanitation & Monsoon Util Industrial Boots SNI',
  'Sanitation & Monsoon Utilities', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  126849, 7.29, 16250.00,
  12, 87.48, 1522188,
  '58 x 42 x 38', 0.0960, 18.00,
  300, 708,
  'Professional studio photography of AP Boots AP Boots 2015 Ultimate Hijau, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots 2015 Ultimate Hijau, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots 2015 Ultimate Hijau, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots 2015 Ultimate Hijau in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2015_Ultimate_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_2015_Ultimate_Hijau_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2015_Ultimate_Hijau_Sepatu_Boot_PVC/side_AP_Boots_2015_Ultimate_Hijau_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Hijau - Sepatu Boot PVC/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Hijau - Sepatu Boot PVC/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10073, 2073, 'MST-073', 'AP Boots AP Boots 2015 Ultimate Orange Waterproof PVC Sanitation & Monsoon Util Industrial Boots SNI',
  'Sanitation & Monsoon Utilities', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  126849, 7.29, 16250.00,
  12, 87.48, 1522188,
  '58 x 42 x 38', 0.0960, 18.00,
  300, 708,
  'Professional studio photography of AP Boots AP Boots 2015 Ultimate Orange, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots 2015 Ultimate Orange, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots 2015 Ultimate Orange, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots 2015 Ultimate Orange in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2015_Ultimate_Orange_Sepatu_Boot_PVC/hero_AP_Boots_2015_Ultimate_Orange_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2015_Ultimate_Orange_Sepatu_Boot_PVC/side_AP_Boots_2015_Ultimate_Orange_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Orange - Sepatu Boot PVC Shoes Karet/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2015 Ultimate Orange - Sepatu Boot PVC Shoes Karet/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10074, 2074, 'MST-074', 'AP Boots AP Boots 2018 Ultraflex Abu Waterproof PVC Sanitation & Monsoon Util Industrial Boots SNI',
  'Sanitation & Monsoon Utilities', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  140674, 8.08, 16250.00,
  12, 96.96, 1688088,
  '58 x 42 x 38', 0.0960, 18.00,
  300, 708,
  'Professional studio photography of AP Boots AP Boots 2018 Ultraflex Abu, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots 2018 Ultraflex Abu, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots 2018 Ultraflex Abu, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots 2018 Ultraflex Abu in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2018_Ultraflex_Abu_Sepatu_Boot_PVC/hero_AP_Boots_2018_Ultraflex_Abu_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2018_Ultraflex_Abu_Sepatu_Boot_PVC/side_AP_Boots_2018_Ultraflex_Abu_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Abu - Sepatu Boot PVC/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Abu - Sepatu Boot PVC/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10075, 2075, 'MST-075', 'AP Boots AP Boots 2018 Ultraflex Hijau Waterproof PVC Sanitation & Monsoon Util Industrial Boots SNI',
  'Sanitation & Monsoon Utilities', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  140674, 8.08, 16250.00,
  12, 96.96, 1688088,
  '58 x 42 x 38', 0.0960, 18.00,
  300, 708,
  'Professional studio photography of AP Boots AP Boots 2018 Ultraflex Hijau, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots 2018 Ultraflex Hijau, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots 2018 Ultraflex Hijau, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots 2018 Ultraflex Hijau in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2018_Ultraflex_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_2018_Ultraflex_Hijau_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2018_Ultraflex_Hijau_Sepatu_Boot_PVC/side_AP_Boots_2018_Ultraflex_Hijau_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Hijau - Sepatu Boot PVC - 39/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2018 Ultraflex Hijau - Sepatu Boot PVC - 39/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10076, 2076, 'MST-076', 'AP Boots AP Boots 2007 Waterproof PVC Sanitation & Monsoon Util Industrial Boots SNI',
  'Sanitation & Monsoon Utilities', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  74074, 4.25, 16250.00,
  12, 51.00, 888888,
  '58 x 42 x 38', 0.0960, 18.00,
  300, 708,
  'Professional studio photography of AP Boots AP Boots 2007, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots 2007, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots 2007, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots 2007 in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2007_Sepatu_Boot_PVC/hero_AP_Boots_2007_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2007_Sepatu_Boot_PVC/side_AP_Boots_2007_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2007 - Sepatu Boot Hijau PVC Karet Shoes/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/04_AP_Boots_Green_Series/AP Boots 2007 - Sepatu Boot Hijau PVC Karet Shoes/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10077, 2077, 'MST-077', 'AP Boots AP Boots 2006 Waterproof PVC Sanitation & Monsoon Util Industrial Boots SNI',
  'Sanitation & Monsoon Utilities', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  123499, 7.09, 16250.00,
  12, 85.08, 1481988,
  '58 x 42 x 38', 0.0960, 18.00,
  300, 708,
  'Professional studio photography of AP Boots AP Boots 2006, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP Boots 2006, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP Boots 2006, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP Boots 2006 in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2006_Sepatu_Boot_PVC/hero_AP_Boots_2006_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_2006_Sepatu_Boot_PVC/side_AP_Boots_2006_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/12_AP_General_Boots/AP Boots 2006 - Sepatu Boot PVC/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/12_AP_General_Boots/AP Boots 2006 - Sepatu Boot PVC/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10078, 2078, 'MST-078', 'AP Boots AP KIDS 2012 MERAH STABILO Waterproof PVC Children Outdoor & Monsoo Industrial Boots SNI',
  'Children Outdoor & Monsoon', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  51424, 2.95, 16250.00,
  12, 35.40, 617088,
  '58 x 42 x 38', 0.0960, 8.50,
  300, 708,
  'Professional studio photography of AP Boots AP KIDS 2012 MERAH STABILO, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP KIDS 2012 MERAH STABILO, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP KIDS 2012 MERAH STABILO, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP KIDS 2012 MERAH STABILO in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_MERAH_STABILO_MULTI_SIZE_BESAR_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_MERAH_STABILO_MULTI_SIZE_BESAR_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_MERAH_STABILO_MULTI_SIZE_BESAR_Sepatu_Boot_PVC/side_AP_Boots_AP_KIDS_2012_MERAH_STABILO_MULTI_SIZE_BESAR_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 MERAH STABILO MULTI SIZE BESAR - Sepatu Boot PVC/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 MERAH STABILO MULTI SIZE BESAR - Sepatu Boot PVC/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10079, 2079, 'MST-079', 'AP Boots AP KIDS 2012 HIJAU STABILO Waterproof PVC Children Outdoor & Monsoo Industrial Boots SNI',
  'Children Outdoor & Monsoon', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  51424, 2.95, 16250.00,
  12, 35.40, 617088,
  '58 x 42 x 38', 0.0960, 8.50,
  300, 708,
  'Professional studio photography of AP Boots AP KIDS 2012 HIJAU STABILO, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP KIDS 2012 HIJAU STABILO, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP KIDS 2012 HIJAU STABILO, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP KIDS 2012 HIJAU STABILO in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_MERAH_STABILO_MULTI_SIZE_BESAR_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_MERAH_STABILO_MULTI_SIZE_BESAR_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_MERAH_STABILO_MULTI_SIZE_BESAR_Sepatu_Boot_PVC/side_AP_Boots_AP_KIDS_2012_MERAH_STABILO_MULTI_SIZE_BESAR_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 HIJAU STABILO MULTI SIZE BESAR - Sepatu Boot PVC/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 HIJAU STABILO MULTI SIZE BESAR - Sepatu Boot PVC/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10080, 2080, 'MST-080', 'AP Boots AP KIDS 2012 UNGU STABILO Waterproof PVC Children Outdoor & Monsoo Industrial Boots SNI',
  'Children Outdoor & Monsoon', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  51424, 2.95, 16250.00,
  12, 35.40, 617088,
  '58 x 42 x 38', 0.0960, 8.50,
  300, 708,
  'Professional studio photography of AP Boots AP KIDS 2012 UNGU STABILO, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP KIDS 2012 UNGU STABILO, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP KIDS 2012 UNGU STABILO, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP KIDS 2012 UNGU STABILO in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_UNGU_STABILO_MULTI_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_UNGU_STABILO_MULTI_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_UNGU_STABILO_MULTI_Sepatu_Boot_PVC/side_AP_Boots_AP_KIDS_2012_UNGU_STABILO_MULTI_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 UNGU STABILO MULTI - Sepatu Boot PVC Anak Kaki F/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 UNGU STABILO MULTI - Sepatu Boot PVC Anak Kaki F/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10081, 2081, 'MST-081', 'AP Boots AP KIDS SAFARI ELEPHANT Waterproof PVC Children Outdoor & Monsoo Industrial Boots SNI',
  'Children Outdoor & Monsoon', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  44674, 2.57, 16250.00,
  12, 30.84, 536088,
  '58 x 42 x 38', 0.0960, 8.50,
  300, 708,
  'Professional studio photography of AP Boots AP KIDS SAFARI ELEPHANT, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP KIDS SAFARI ELEPHANT, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP KIDS SAFARI ELEPHANT, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP KIDS SAFARI ELEPHANT in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_SAFARI_ELEPHANT_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_SAFARI_ELEPHANT_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_SAFARI_ELEPHANT_Sepatu_Boot_PVC/side_AP_Boots_AP_KIDS_SAFARI_ELEPHANT_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI ELEPHANT - Sepatu Boot PVC Anak Motif - 24/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI ELEPHANT - Sepatu Boot PVC Anak Motif - 24/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10082, 2082, 'MST-082', 'AP Boots AP KIDS SAFARI ZEBRA Waterproof PVC Children Outdoor & Monsoo Industrial Boots SNI',
  'Children Outdoor & Monsoon', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  44674, 2.57, 16250.00,
  12, 30.84, 536088,
  '58 x 42 x 38', 0.0960, 8.50,
  300, 708,
  'Professional studio photography of AP Boots AP KIDS SAFARI ZEBRA, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP KIDS SAFARI ZEBRA, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP KIDS SAFARI ZEBRA, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP KIDS SAFARI ZEBRA in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_SAFARI_ZEBRA_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_SAFARI_ZEBRA_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_SAFARI_ZEBRA_Sepatu_Boot_PVC/side_AP_Boots_AP_KIDS_SAFARI_ZEBRA_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI ZEBRA - Sepatu Boot PVC - 2223/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI ZEBRA - Sepatu Boot PVC - 2223/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10083, 2083, 'MST-083', 'AP Boots AP KIDS SAFARI CROCODILE Waterproof PVC Children Outdoor & Monsoo Industrial Boots SNI',
  'Children Outdoor & Monsoon', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  44674, 2.57, 16250.00,
  12, 30.84, 536088,
  '58 x 42 x 38', 0.0960, 8.50,
  300, 708,
  'Professional studio photography of AP Boots AP KIDS SAFARI CROCODILE, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP KIDS SAFARI CROCODILE, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP KIDS SAFARI CROCODILE, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP KIDS SAFARI CROCODILE in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_SAFARI_CROCODILE_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_SAFARI_CROCODILE_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_SAFARI_CROCODILE_Sepatu_Boot_PVC/side_AP_Boots_AP_KIDS_SAFARI_CROCODILE_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI CROCODILE - Sepatu Boot PVC Anak - 2223/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS SAFARI CROCODILE - Sepatu Boot PVC Anak - 2223/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10084, 2084, 'MST-084', 'AP Boots AP KIDS 2012 LEMON POLKADOT Waterproof PVC Children Outdoor & Monsoo Industrial Boots SNI',
  'Children Outdoor & Monsoon', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  49068, 2.82, 16250.00,
  12, 33.84, 588816,
  '58 x 42 x 38', 0.0960, 8.50,
  300, 708,
  'Professional studio photography of AP Boots AP KIDS 2012 LEMON POLKADOT, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP KIDS 2012 LEMON POLKADOT, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP KIDS 2012 LEMON POLKADOT, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP KIDS 2012 LEMON POLKADOT in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_LEMON_POLKADOT_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_LEMON_POLKADOT_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_LEMON_POLKADOT_Sepatu_Boot_PVC/side_AP_Boots_AP_KIDS_2012_LEMON_POLKADOT_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 LEMON POLKADOT - Sepatu Boot PVC - 15/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 LEMON POLKADOT - Sepatu Boot PVC - 15/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10085, 2085, 'MST-085', 'AP Boots AP KIDS 2012 MIXED BLACK FUXIA Waterproof PVC Children Outdoor & Monsoo Industrial Boots SNI',
  'Children Outdoor & Monsoon', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  51424, 2.95, 16250.00,
  12, 35.40, 617088,
  '58 x 42 x 38', 0.0960, 8.50,
  300, 708,
  'Professional studio photography of AP Boots AP KIDS 2012 MIXED BLACK FUXIA, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP KIDS 2012 MIXED BLACK FUXIA, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP KIDS 2012 MIXED BLACK FUXIA, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP KIDS 2012 MIXED BLACK FUXIA in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_MIXED_BLACK_FUXIA_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_MIXED_BLACK_FUXIA_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_MIXED_BLACK_FUXIA_Sepatu_Boot_PVC/side_AP_Boots_AP_KIDS_2012_MIXED_BLACK_FUXIA_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP KIDS 2012 MIXED BLACK FUXIA - Sepatu Boot PVC - 15/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP KIDS 2012 MIXED BLACK FUXIA - Sepatu Boot PVC - 15/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10086, 2086, 'MST-086', 'AP Boots AP KIDS 2012 BLUE JEANS Waterproof PVC Children Outdoor & Monsoo Industrial Boots SNI',
  'Children Outdoor & Monsoon', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  51424, 2.95, 16250.00,
  12, 35.40, 617088,
  '58 x 42 x 38', 0.0960, 8.50,
  300, 708,
  'Professional studio photography of AP Boots AP KIDS 2012 BLUE JEANS, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP KIDS 2012 BLUE JEANS, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP KIDS 2012 BLUE JEANS, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP KIDS 2012 BLUE JEANS in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_BLUE_JEANS_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_BLUE_JEANS_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_BLUE_JEANS_Sepatu_Boot_PVC/side_AP_Boots_AP_KIDS_2012_BLUE_JEANS_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 BLUE JEANS - Sepatu Boot PVC Anak Motif - 15/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 BLUE JEANS - Sepatu Boot PVC Anak Motif - 15/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10087, 2087, 'MST-087', 'AP Boots AP KIDS 2012 VIOLET CIRCLE Waterproof PVC Children Outdoor & Monsoo Industrial Boots SNI',
  'Children Outdoor & Monsoon', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  46425, 2.67, 16250.00,
  12, 32.04, 557100,
  '58 x 42 x 38', 0.0960, 8.50,
  300, 708,
  'Professional studio photography of AP Boots AP KIDS 2012 VIOLET CIRCLE, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP KIDS 2012 VIOLET CIRCLE, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP KIDS 2012 VIOLET CIRCLE, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP KIDS 2012 VIOLET CIRCLE in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_BLUE_JEANS_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_BLUE_JEANS_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_BLUE_JEANS_Sepatu_Boot_PVC/side_AP_Boots_AP_KIDS_2012_BLUE_JEANS_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 VIOLET CIRCLE- Sepatu Boot PVC Anak Motif - 15/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 VIOLET CIRCLE- Sepatu Boot PVC Anak Motif - 15/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10088, 2088, 'MST-088', 'AP Boots AP KIDS 2012 FUXIA STRIPE Waterproof PVC Children Outdoor & Monsoo Industrial Boots SNI',
  'Children Outdoor & Monsoon', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  51424, 2.95, 16250.00,
  12, 35.40, 617088,
  '58 x 42 x 38', 0.0960, 8.50,
  300, 708,
  'Professional studio photography of AP Boots AP KIDS 2012 FUXIA STRIPE, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP KIDS 2012 FUXIA STRIPE, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP KIDS 2012 FUXIA STRIPE, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP KIDS 2012 FUXIA STRIPE in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_MIXED_BLACK_FUXIA_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_MIXED_BLACK_FUXIA_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_MIXED_BLACK_FUXIA_Sepatu_Boot_PVC/side_AP_Boots_AP_KIDS_2012_MIXED_BLACK_FUXIA_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 FUXIA STRIPE - Sepatu Boot PVC Anak Kaki Motif F/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 FUXIA STRIPE - Sepatu Boot PVC Anak Kaki Motif F/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10089, 2089, 'MST-089', 'AP Boots AP KIDS 2012 UNGU STABILO MULTI Waterproof PVC Children Outdoor & Monsoo Industrial Boots SNI',
  'Children Outdoor & Monsoon', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  51424, 2.95, 16250.00,
  12, 35.40, 617088,
  '58 x 42 x 38', 0.0960, 8.50,
  300, 708,
  'Professional studio photography of AP Boots AP KIDS 2012 UNGU STABILO MULTI, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP KIDS 2012 UNGU STABILO MULTI, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP KIDS 2012 UNGU STABILO MULTI, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP KIDS 2012 UNGU STABILO MULTI in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_UNGU_STABILO_MULTI_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_UNGU_STABILO_MULTI_Sepatu_Boot_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_KIDS_2012_UNGU_STABILO_MULTI_Sepatu_Boot_PVC/side_AP_Boots_AP_KIDS_2012_UNGU_STABILO_MULTI_Sepatu_Boot_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 UNGU STABILO MULTI - Sepatu Boot PVC Anak Kaki F/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/AP Boots AP KIDS 2012 UNGU STABILO MULTI - Sepatu Boot PVC Anak Kaki F/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10090, 2090, 'MST-090', 'AP Boots AP BOOTS 2001 HIJAU Waterproof PVC Children Outdoor & Monsoo Industrial Boots SNI',
  'Children Outdoor & Monsoon', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  54618, 3.14, 16250.00,
  12, 37.68, 655416,
  '58 x 42 x 38', 0.0960, 8.50,
  300, 708,
  'Professional studio photography of AP Boots AP BOOTS 2001 HIJAU, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP BOOTS 2001 HIJAU, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP BOOTS 2001 HIJAU, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP BOOTS 2001 HIJAU in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Sepatu_Boot_Anak_AP_BOOTS_2001_HIJAU_Sepatu_Boot_Karet/hero_Sepatu_Boot_Anak_AP_BOOTS_2001_HIJAU_Sepatu_Boot_Karet.webp', 'https://catalog.hotstrading.com/assets/shopee/Sepatu_Boot_Anak_AP_BOOTS_2001_HIJAU_Sepatu_Boot_Karet/side_Sepatu_Boot_Anak_AP_BOOTS_2001_HIJAU_Sepatu_Boot_Karet.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/Sepatu Boot Anak AP BOOTS 2001 HIJAU - Sepatu Boot Karet Kids Kaki Fas/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/09_AP_Kids_Boots/Sepatu Boot Anak AP BOOTS 2001 HIJAU - Sepatu Boot Karet Kids Kaki Fas/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10091, 2091, 'MST-091', 'AP Boots AP CLOGS Ladies Pink Cream Waterproof PVC Casual, Leisure & Wet Are Industrial Boots SNI',
  'Casual, Leisure & Wet Areas', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  40549, 2.33, 16250.00,
  24, 55.92, 973176,
  '58 x 42 x 38', 0.1100, 10.50,
  300, 708,
  'Professional studio photography of AP Boots AP CLOGS Ladies Pink Cream, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP CLOGS Ladies Pink Cream, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP CLOGS Ladies Pink Cream, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP CLOGS Ladies Pink Cream in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Ladies_Pink_Cream_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Ladies_Pink_Cream_Sepatu_Slip_On_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Ladies_Pink_Cream_Sepatu_Slip_On_PVC/side_AP_Boots_AP_CLOGS_Ladies_Pink_Cream_Sepatu_Slip_On_PVC.webp',
  'https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/05fa8e07f4eb4a65afc0f3812c560d7c~tplv-aphluv4xwc-white-pad-v1:1600:1600.jpeg', 'https://p16-images-sign-sg.tokopedia-static.net/tos-alisg-i-aphluv4xwc-sg/2d14b687e8df45879ff970299d47dda6~tplv-aphluv4xwc-resize-jpeg:1600:1600.jpeg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10092, 2092, 'MST-092', 'AP Boots AP CLOGS Hitam Waterproof PVC Casual, Leisure & Wet Are Industrial Boots SNI',
  'Casual, Leisure & Wet Areas', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  50550, 2.9, 16250.00,
  24, 69.60, 1213200,
  '58 x 42 x 38', 0.1100, 10.50,
  300, 708,
  'Professional studio photography of AP Boots AP CLOGS Hitam, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP CLOGS Hitam, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP CLOGS Hitam, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP CLOGS Hitam in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Hitam_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Hitam_Sepatu_Slip_On_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Hitam_Sepatu_Slip_On_PVC/side_AP_Boots_AP_CLOGS_Hitam_Sepatu_Slip_On_PVC.webp',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Hitam_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Hitam_Sepatu_Slip_On_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Hitam_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Hitam_Sepatu_Slip_On_PVC.webp',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10093, 2093, 'MST-093', 'AP Boots AP CLOGS COKLAT Waterproof PVC Casual, Leisure & Wet Are Industrial Boots SNI',
  'Casual, Leisure & Wet Areas', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  50550, 2.9, 16250.00,
  24, 69.60, 1213200,
  '58 x 42 x 38', 0.1100, 10.50,
  300, 708,
  'Professional studio photography of AP Boots AP CLOGS COKLAT, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP CLOGS COKLAT, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP CLOGS COKLAT, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP CLOGS COKLAT in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_COKLAT_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_COKLAT_Sepatu_Slip_On_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_COKLAT_Sepatu_Slip_On_PVC/side_AP_Boots_AP_CLOGS_COKLAT_Sepatu_Slip_On_PVC.webp',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_COKLAT_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_COKLAT_Sepatu_Slip_On_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_COKLAT_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_COKLAT_Sepatu_Slip_On_PVC.webp',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10094, 2094, 'MST-094', 'AP Boots AP CLOGS Navy Waterproof PVC Casual, Leisure & Wet Are Industrial Boots SNI',
  'Casual, Leisure & Wet Areas', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  50550, 2.9, 16250.00,
  24, 69.60, 1213200,
  '58 x 42 x 38', 0.1100, 10.50,
  300, 708,
  'Professional studio photography of AP Boots AP CLOGS Navy, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP CLOGS Navy, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP CLOGS Navy, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP CLOGS Navy in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC/side_AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC.webp',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC.webp',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10095, 2095, 'MST-095', 'AP Boots AP CLOGS Putih Krem Waterproof PVC Casual, Leisure & Wet Are Industrial Boots SNI',
  'Casual, Leisure & Wet Areas', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  35550, 2.04, 16250.00,
  24, 48.96, 853200,
  '58 x 42 x 38', 0.1100, 10.50,
  300, 708,
  'Professional studio photography of AP Boots AP CLOGS Putih Krem, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP CLOGS Putih Krem, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP CLOGS Putih Krem, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP CLOGS Putih Krem in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Putih_Krem_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Putih_Krem_Sepatu_Slip_On_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Putih_Krem_Sepatu_Slip_On_PVC/side_AP_Boots_AP_CLOGS_Putih_Krem_Sepatu_Slip_On_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Krem - Sepatu Slip On PVC - 37/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Krem - Sepatu Slip On PVC - 37/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10096, 2096, 'MST-096', 'AP Boots AP CLOGS Putih Abu Waterproof PVC Casual, Leisure & Wet Are Industrial Boots SNI',
  'Casual, Leisure & Wet Areas', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  40549, 2.33, 16250.00,
  24, 55.92, 973176,
  '58 x 42 x 38', 0.1100, 10.50,
  300, 708,
  'Professional studio photography of AP Boots AP CLOGS Putih Abu, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP CLOGS Putih Abu, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP CLOGS Putih Abu, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP CLOGS Putih Abu in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Putih_Abu_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Putih_Abu_Sepatu_Slip_On_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Putih_Abu_Sepatu_Slip_On_PVC/side_AP_Boots_AP_CLOGS_Putih_Abu_Sepatu_Slip_On_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Abu - Sepatu Slip On PVC - 37/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Abu - Sepatu Slip On PVC - 37/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10097, 2097, 'MST-097', 'AP Boots AP CLOGS Putih Merah Waterproof PVC Casual, Leisure & Wet Are Industrial Boots SNI',
  'Casual, Leisure & Wet Areas', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  35550, 2.04, 16250.00,
  24, 48.96, 853200,
  '58 x 42 x 38', 0.1100, 10.50,
  300, 708,
  'Professional studio photography of AP Boots AP CLOGS Putih Merah, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP CLOGS Putih Merah, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP CLOGS Putih Merah, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP CLOGS Putih Merah in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Putih_Merah_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Putih_Merah_Sepatu_Slip_On_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Putih_Merah_Sepatu_Slip_On_PVC/side_AP_Boots_AP_CLOGS_Putih_Merah_Sepatu_Slip_On_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Merah - Sepatu Slip On PVC - 37/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Merah - Sepatu Slip On PVC - 37/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10098, 2098, 'MST-098', 'AP Boots AP CLOGS Putih Navy Waterproof PVC Casual, Leisure & Wet Are Industrial Boots SNI',
  'Casual, Leisure & Wet Areas', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  35550, 2.04, 16250.00,
  24, 48.96, 853200,
  '58 x 42 x 38', 0.1100, 10.50,
  300, 708,
  'Professional studio photography of AP Boots AP CLOGS Putih Navy, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP CLOGS Putih Navy, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP CLOGS Putih Navy, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP CLOGS Putih Navy in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC/side_AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Navy - Sepatu Slip On PVC - 37/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP CLOGS Putih Navy - Sepatu Slip On PVC - 37/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10099, 2099, 'MST-099', 'AP Boots Ap Boots 1001 HITAM Waterproof PVC Casual, Leisure & Wet Are Industrial Boots SNI',
  'Casual, Leisure & Wet Areas', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  28255, 1.62, 16250.00,
  24, 38.88, 678120,
  '58 x 42 x 38', 0.1100, 10.50,
  300, 708,
  'Professional studio photography of AP Boots Ap Boots 1001 HITAM, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots Ap Boots 1001 HITAM, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots Ap Boots 1001 HITAM, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots Ap Boots 1001 HITAM in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_1001_HITAM_Sandal_Selop/hero_Ap_Boots_1001_HITAM_Sandal_Selop.webp', 'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_1001_HITAM_Sandal_Selop/side_Ap_Boots_1001_HITAM_Sandal_Selop.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 1001 HITAM - Sandal Selop Karet Sendal Pria Pria - 38/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 1001 HITAM - Sandal Selop Karet Sendal Pria Pria - 38/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10100, 2100, 'MST-100', 'AP Boots Ap Boots 991 Hitam Waterproof PVC Casual, Leisure & Wet Are Industrial Boots SNI',
  'Casual, Leisure & Wet Areas', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  27699, 1.59, 16250.00,
  24, 38.16, 664776,
  '58 x 42 x 38', 0.1100, 10.50,
  300, 708,
  'Professional studio photography of AP Boots Ap Boots 991 Hitam, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots Ap Boots 991 Hitam, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots Ap Boots 991 Hitam, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots Ap Boots 991 Hitam in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_991_Hitam_Sandal_Selop/hero_Ap_Boots_991_Hitam_Sandal_Selop.webp', 'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_991_Hitam_Sandal_Selop/side_Ap_Boots_991_Hitam_Sandal_Selop.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 991 Hitam - Sandal Selop Karet Sendal Pria/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 991 Hitam - Sandal Selop Karet Sendal Pria/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
);

INSERT INTO `alibaba_export_listings` (
  `id`, `product_id`, `sku`, `alibaba_product_title`, `category_group`, `target_continent`,
  `target_country`, `target_industry_angle`, `primary_keyword_1`, `primary_keyword_2`,
  `primary_keyword_3`, `longtail_keywords`, `base_price_idr`, `fob_price_usd`, `exchange_rate_used`,
  `pairs_per_carton`, `carton_price_usd`, `carton_price_idr`, `carton_dimensions_cm`,
  `cbm_per_carton`, `gross_weight_kg_per_carton`, `capacity_20ft_cartons`, `capacity_40ft_hc_cartons`,
  `prompt_slot_1_hero`, `prompt_slot_2_side`, `prompt_slot_3_tread`, `prompt_slot_4_contextual`,
  `image_slot_1`, `image_slot_2`, `image_slot_3`, `image_slot_4`, `image_slot_5`, `image_slot_6`,
  `export_status`, `last_error_message`, `created_at`, `updated_at`
) VALUES
(
  10101, 2101, 'MST-101', 'AP Boots Ap Boots 989 Hitam Waterproof PVC Casual, Leisure & Wet Are Industrial Boots SNI',
  'Casual, Leisure & Wet Areas', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  27699, 1.59, 16250.00,
  24, 38.16, 664776,
  '58 x 42 x 38', 0.1100, 10.50,
  300, 708,
  'Professional studio photography of AP Boots Ap Boots 989 Hitam, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots Ap Boots 989 Hitam, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots Ap Boots 989 Hitam, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots Ap Boots 989 Hitam in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_989_Hitam_Sandal_Selop/hero_Ap_Boots_989_Hitam_Sandal_Selop.webp', 'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_989_Hitam_Sandal_Selop/side_Ap_Boots_989_Hitam_Sandal_Selop.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 989 Hitam - Sandal Selop Karet Sendal Pria/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 989 Hitam - Sandal Selop Karet Sendal Pria/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10102, 2102, 'MST-102', 'AP Boots Ap Boots 995 Hitam (V1) Waterproof PVC Casual, Leisure & Wet Are Industrial Boots SNI',
  'Casual, Leisure & Wet Areas', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  27699, 1.59, 16250.00,
  24, 38.16, 664776,
  '58 x 42 x 38', 0.1100, 10.50,
  300, 708,
  'Professional studio photography of AP Boots Ap Boots 995 Hitam (V1), 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots Ap Boots 995 Hitam (V1), clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots Ap Boots 995 Hitam (V1), showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots Ap Boots 995 Hitam (V1) in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_995_Hitam_Sandal_Selop/hero_Ap_Boots_995_Hitam_Sandal_Selop.webp', 'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_995_Hitam_Sandal_Selop/side_Ap_Boots_995_Hitam_Sandal_Selop.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 995 Hitam - Sandal Selop Karet/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 995 Hitam - Sandal Selop Karet/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10103, 2103, 'MST-103', 'AP Boots Ap Boots 999 Hitam Waterproof PVC Casual, Leisure & Wet Are Industrial Boots SNI',
  'Casual, Leisure & Wet Areas', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  33075, 1.9, 16250.00,
  24, 45.60, 793800,
  '58 x 42 x 38', 0.1100, 10.50,
  300, 708,
  'Professional studio photography of AP Boots Ap Boots 999 Hitam, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots Ap Boots 999 Hitam, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots Ap Boots 999 Hitam, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots Ap Boots 999 Hitam in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_999_Hitam_Sandal_Selop/hero_Ap_Boots_999_Hitam_Sandal_Selop.webp', 'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_999_Hitam_Sandal_Selop/side_Ap_Boots_999_Hitam_Sandal_Selop.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 999 Hitam - Sandal Selop Sendal/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 999 Hitam - Sandal Selop Sendal/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10104, 2104, 'MST-104', 'AP Boots Ap Boots 995 Hitam (V2) Waterproof PVC Casual, Leisure & Wet Are Industrial Boots SNI',
  'Casual, Leisure & Wet Areas', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  27699, 1.59, 16250.00,
  24, 38.16, 664776,
  '58 x 42 x 38', 0.1100, 10.50,
  300, 708,
  'Professional studio photography of AP Boots Ap Boots 995 Hitam (V2), 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots Ap Boots 995 Hitam (V2), clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots Ap Boots 995 Hitam (V2), showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots Ap Boots 995 Hitam (V2) in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_995_Hitam_Sandal_Selop/hero_Ap_Boots_995_Hitam_Sandal_Selop.webp', 'https://catalog.hotstrading.com/assets/shopee/Ap_Boots_995_Hitam_Sandal_Selop/side_Ap_Boots_995_Hitam_Sandal_Selop.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 995 Hitam - Sandal Selop Karet/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/Ap Boots 995 Hitam - Sandal Selop Karet/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10105, 2105, 'MST-105', 'AP Boots AP STAR Hitam Putih Waterproof PVC Fashion Waterproof Footwe Industrial Boots SNI',
  'Fashion Waterproof Footwear', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  37924, 2.18, 16250.00,
  12, 26.16, 455088,
  '58 x 42 x 38', 0.0960, 11.50,
  300, 708,
  'Professional studio photography of AP Boots AP STAR Hitam Putih, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP STAR Hitam Putih, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP STAR Hitam Putih, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP STAR Hitam Putih in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_STAR_Hitam_Putih_Sepatu_Kets_PVC/hero_AP_Boots_AP_STAR_Hitam_Putih_Sepatu_Kets_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_STAR_Hitam_Putih_Sepatu_Kets_PVC/side_AP_Boots_AP_STAR_Hitam_Putih_Sepatu_Kets_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/07_AP_Kasual_Sneakers/AP Boots AP STAR Hitam Putih - Sepatu Kets PVC Casual Shoes Sneakers -/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/07_AP_Kasual_Sneakers/AP Boots AP STAR Hitam Putih - Sepatu Kets PVC Casual Shoes Sneakers -/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10106, 2106, 'MST-106', 'AP Boots AP STAR Hitam Hitam Waterproof PVC Fashion Waterproof Footwe Industrial Boots SNI',
  'Fashion Waterproof Footwear', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'AP Boots Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  53175, 3.05, 16250.00,
  12, 36.60, 638100,
  '58 x 42 x 38', 0.0960, 11.50,
  300, 708,
  'Professional studio photography of AP Boots AP STAR Hitam Hitam, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of AP Boots AP STAR Hitam Hitam, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of AP Boots AP STAR Hitam Hitam, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of AP Boots AP STAR Hitam Hitam in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_STAR_Hitam_Hitam_Sepatu_Kets_PVC/hero_AP_Boots_AP_STAR_Hitam_Hitam_Sepatu_Kets_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_STAR_Hitam_Hitam_Sepatu_Kets_PVC/side_AP_Boots_AP_STAR_Hitam_Hitam_Sepatu_Kets_PVC.webp',
  'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_STAR_Hitam_Hitam_Sepatu_Kets_PVC/hero_AP_Boots_AP_STAR_Hitam_Hitam_Sepatu_Kets_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/AP_Boots_AP_STAR_Hitam_Hitam_Sepatu_Kets_PVC/hero_AP_Boots_AP_STAR_Hitam_Hitam_Sepatu_Kets_PVC.webp',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10107, 2107, 'MST-107', 'Petrova Petrova Sepatu Boots Nelayan Yellow PVC Steel Toe Cap Anti Static Waterproof PVC Heavy Industry & Mining S Industrial Bo',
  'Heavy Industry & Mining Safety', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'Petrova Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  179250, 10.3, 16250.00,
  10, 103.00, 1792500,
  '58 x 42 x 38', 0.0960, 23.50,
  360, 850,
  'Professional studio photography of Petrova Petrova Sepatu Boots Nelayan Yellow PVC Steel Toe Cap Anti Static, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of Petrova Petrova Sepatu Boots Nelayan Yellow PVC Steel Toe Cap Anti Static, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of Petrova Petrova Sepatu Boots Nelayan Yellow PVC Steel Toe Cap Anti Static, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of Petrova Petrova Sepatu Boots Nelayan Yellow PVC Steel Toe Cap Anti Static in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Nelayan_Yellow_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Nelayan_Yellow_PVC_Steel_Toe_Cap_Anti_Static.webp', 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Nelayan_Yellow_PVC_Steel_Toe_Cap_Anti_Static/side_Petrova_Sepatu_Boots_Nelayan_Yellow_PVC_Steel_Toe_Cap_Anti_Static.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10108, 2108, 'MST-108', 'Petrova Petrova Sepatu Boots Phenom Yellow PVC Steel Toe Cap Anti Static Waterproof PVC Heavy Industry & Mining S Industrial Boo',
  'Heavy Industry & Mining Safety', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'Petrova Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  132750, 7.62, 16250.00,
  10, 76.20, 1327500,
  '58 x 42 x 38', 0.0960, 23.50,
  360, 850,
  'Professional studio photography of Petrova Petrova Sepatu Boots Phenom Yellow PVC Steel Toe Cap Anti Static, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of Petrova Petrova Sepatu Boots Phenom Yellow PVC Steel Toe Cap Anti Static, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of Petrova Petrova Sepatu Boots Phenom Yellow PVC Steel Toe Cap Anti Static, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of Petrova Petrova Sepatu Boots Phenom Yellow PVC Steel Toe Cap Anti Static in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Phenom_Yellow_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Phenom_Yellow_PVC_Steel_Toe_Cap_Anti_Static.webp', 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Phenom_Yellow_PVC_Steel_Toe_Cap_Anti_Static/side_Petrova_Sepatu_Boots_Phenom_Yellow_PVC_Steel_Toe_Cap_Anti_Static.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10109, 2109, 'MST-109', 'Petrova Petrova Sepatu Boots Phenom Yellow Size 39 PVC Steel Toe Cap Anti Static Waterproof PVC Heavy Industry & Mining S Indust',
  'Heavy Industry & Mining Safety', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'Petrova Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  132750, 7.62, 16250.00,
  10, 76.20, 1327500,
  '58 x 42 x 38', 0.0960, 23.50,
  360, 850,
  'Professional studio photography of Petrova Petrova Sepatu Boots Phenom Yellow Size 39 PVC Steel Toe Cap Anti Static, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of Petrova Petrova Sepatu Boots Phenom Yellow Size 39 PVC Steel Toe Cap Anti Static, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of Petrova Petrova Sepatu Boots Phenom Yellow Size 39 PVC Steel Toe Cap Anti Static, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of Petrova Petrova Sepatu Boots Phenom Yellow Size 39 PVC Steel Toe Cap Anti Static in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Phenom_Yellow_Size_39_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Phenom_Yellow_Size_39_PVC_Steel_Toe_Cap_Anti_Static.webp', 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Phenom_Yellow_Size_39_PVC_Steel_Toe_Cap_Anti_Static/side_Petrova_Sepatu_Boots_Phenom_Yellow_Size_39_PVC_Steel_Toe_Cap_Anti_Static.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP MAX Coklat Hitam - Sepatu Safety PVC - 39/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP MAX Coklat Hitam - Sepatu Safety PVC - 39/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10110, 2110, 'MST-110', 'Petrova Petrova Sepatu Boots Strength WB Biru Boots Air PVC Waterproof PVC Heavy Industry & Mining S Industrial Boots SNI',
  'Heavy Industry & Mining Safety', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'Petrova Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  82500, 4.74, 16250.00,
  10, 47.40, 825000,
  '58 x 42 x 38', 0.0960, 23.50,
  360, 850,
  'Professional studio photography of Petrova Petrova Sepatu Boots Strength WB Biru Boots Air PVC, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of Petrova Petrova Sepatu Boots Strength WB Biru Boots Air PVC, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of Petrova Petrova Sepatu Boots Strength WB Biru Boots Air PVC, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of Petrova Petrova Sepatu Boots Strength WB Biru Boots Air PVC in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_Biru_Boots_Air_PVC/hero_Petrova_Sepatu_Boots_Strength_WB_Biru_Boots_Air_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_Biru_Boots_Air_PVC/side_Petrova_Sepatu_Boots_Strength_WB_Biru_Boots_Air_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10111, 2111, 'MST-111', 'Petrova Petrova Sepatu Boots Strength WB Hijau Boots Air PVC Waterproof PVC Heavy Industry & Mining S Industrial Boots SNI',
  'Heavy Industry & Mining Safety', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'Petrova Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  82500, 4.74, 16250.00,
  10, 47.40, 825000,
  '58 x 42 x 38', 0.0960, 23.50,
  360, 850,
  'Professional studio photography of Petrova Petrova Sepatu Boots Strength WB Hijau Boots Air PVC, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of Petrova Petrova Sepatu Boots Strength WB Hijau Boots Air PVC, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of Petrova Petrova Sepatu Boots Strength WB Hijau Boots Air PVC, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of Petrova Petrova Sepatu Boots Strength WB Hijau Boots Air PVC in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_Hijau_Boots_Air_PVC/hero_Petrova_Sepatu_Boots_Strength_WB_Hijau_Boots_Air_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_Hijau_Boots_Air_PVC/side_Petrova_Sepatu_Boots_Strength_WB_Hijau_Boots_Air_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10112, 2112, 'MST-112', 'Petrova Petrova Sepatu Boots Strength WB Hitam Boots Air PVC Waterproof PVC Heavy Industry & Mining S Industrial Boots SNI',
  'Heavy Industry & Mining Safety', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'Petrova Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  58125, 3.34, 16250.00,
  10, 33.40, 581250,
  '58 x 42 x 38', 0.0960, 23.50,
  360, 850,
  'Professional studio photography of Petrova Petrova Sepatu Boots Strength WB Hitam Boots Air PVC, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of Petrova Petrova Sepatu Boots Strength WB Hitam Boots Air PVC, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of Petrova Petrova Sepatu Boots Strength WB Hitam Boots Air PVC, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of Petrova Petrova Sepatu Boots Strength WB Hitam Boots Air PVC in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_Hitam_Boots_Air_PVC/hero_Petrova_Sepatu_Boots_Strength_WB_Hitam_Boots_Air_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_Hitam_Boots_Air_PVC/side_Petrova_Sepatu_Boots_Strength_WB_Hitam_Boots_Air_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10113, 2113, 'MST-113', 'Petrova Petrova Sepatu Boots Strength WB Kuning Boots Air PVC Waterproof PVC Heavy Industry & Mining S Industrial Boots SNI',
  'Heavy Industry & Mining Safety', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'Petrova Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  71250, 4.09, 16250.00,
  10, 40.90, 712500,
  '58 x 42 x 38', 0.0960, 23.50,
  360, 850,
  'Professional studio photography of Petrova Petrova Sepatu Boots Strength WB Kuning Boots Air PVC, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of Petrova Petrova Sepatu Boots Strength WB Kuning Boots Air PVC, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of Petrova Petrova Sepatu Boots Strength WB Kuning Boots Air PVC, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of Petrova Petrova Sepatu Boots Strength WB Kuning Boots Air PVC in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_Kuning_Boots_Air_PVC/hero_Petrova_Sepatu_Boots_Strength_WB_Kuning_Boots_Air_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_Kuning_Boots_Air_PVC/side_Petrova_Sepatu_Boots_Strength_WB_Kuning_Boots_Air_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10114, 2114, 'MST-114', 'Petrova Petrova Sepatu Boots Strength WB orange Boots Air PVC Waterproof PVC Heavy Industry & Mining S Industrial Boots SNI',
  'Heavy Industry & Mining Safety', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'Petrova Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  82500, 4.74, 16250.00,
  10, 47.40, 825000,
  '58 x 42 x 38', 0.0960, 23.50,
  360, 850,
  'Professional studio photography of Petrova Petrova Sepatu Boots Strength WB orange Boots Air PVC, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of Petrova Petrova Sepatu Boots Strength WB orange Boots Air PVC, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of Petrova Petrova Sepatu Boots Strength WB orange Boots Air PVC, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of Petrova Petrova Sepatu Boots Strength WB orange Boots Air PVC in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_orange_Boots_Air_PVC/hero_Petrova_Sepatu_Boots_Strength_WB_orange_Boots_Air_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_orange_Boots_Air_PVC/side_Petrova_Sepatu_Boots_Strength_WB_orange_Boots_Air_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10115, 2115, 'MST-115', 'Petrova Petrova Sepatu Boots Tinggi Safety ERGOS kuning Steel Toe PVC Waterproof PVC Heavy Industry & Mining S Industrial Boots ',
  'Heavy Industry & Mining Safety', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'Petrova Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  125250, 7.19, 16250.00,
  10, 71.90, 1252500,
  '58 x 42 x 38', 0.0960, 23.50,
  360, 850,
  'Professional studio photography of Petrova Petrova Sepatu Boots Tinggi Safety ERGOS kuning Steel Toe PVC, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of Petrova Petrova Sepatu Boots Tinggi Safety ERGOS kuning Steel Toe PVC, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of Petrova Petrova Sepatu Boots Tinggi Safety ERGOS kuning Steel Toe PVC, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of Petrova Petrova Sepatu Boots Tinggi Safety ERGOS kuning Steel Toe PVC in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Tinggi_Safety_ERGOS_kuning_Steel_Toe_PVC/hero_Petrova_Sepatu_Boots_Tinggi_Safety_ERGOS_kuning_Steel_Toe_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Tinggi_Safety_ERGOS_kuning_Steel_Toe_PVC/side_Petrova_Sepatu_Boots_Tinggi_Safety_ERGOS_kuning_Steel_Toe_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10116, 2116, 'MST-116', 'Petrova Petrova Sepatu Boots Ultimate Yellow PVC Steel Toe Cap Anti Static Waterproof PVC Heavy Industry & Mining S Industrial B',
  'Heavy Industry & Mining Safety', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'Petrova Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  162375, 9.33, 16250.00,
  10, 93.30, 1623750,
  '58 x 42 x 38', 0.0960, 23.50,
  360, 850,
  'Professional studio photography of Petrova Petrova Sepatu Boots Ultimate Yellow PVC Steel Toe Cap Anti Static, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of Petrova Petrova Sepatu Boots Ultimate Yellow PVC Steel Toe Cap Anti Static, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of Petrova Petrova Sepatu Boots Ultimate Yellow PVC Steel Toe Cap Anti Static, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of Petrova Petrova Sepatu Boots Ultimate Yellow PVC Steel Toe Cap Anti Static in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_PVC_Steel_Toe_Cap_Anti_Static.webp', 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_PVC_Steel_Toe_Cap_Anti_Static/side_Petrova_Sepatu_Boots_Ultimate_Yellow_PVC_Steel_Toe_Cap_Anti_Static.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10117, 2117, 'MST-117', 'Petrova Petrova Sepatu Boots Ultimate Yellow Size 38 PVC Steel Toe Cap Anti Static Waterproof PVC Heavy Industry & Mining S Indu',
  'Heavy Industry & Mining Safety', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'Petrova Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  162375, 9.33, 16250.00,
  10, 93.30, 1623750,
  '58 x 42 x 38', 0.0960, 23.50,
  360, 850,
  'Professional studio photography of Petrova Petrova Sepatu Boots Ultimate Yellow Size 38 PVC Steel Toe Cap Anti Static, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of Petrova Petrova Sepatu Boots Ultimate Yellow Size 38 PVC Steel Toe Cap Anti Static, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of Petrova Petrova Sepatu Boots Ultimate Yellow Size 38 PVC Steel Toe Cap Anti Static, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of Petrova Petrova Sepatu Boots Ultimate Yellow Size 38 PVC Steel Toe Cap Anti Static in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_38_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_38_PVC_Steel_Toe_Cap_Anti_Static.webp', 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_38_PVC_Steel_Toe_Cap_Anti_Static/side_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_38_PVC_Steel_Toe_Cap_Anti_Static.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10118, 2118, 'MST-118', 'Petrova Petrova Sepatu Boots Ultimate Yellow Size 39 PVC Steel Toe Cap Anti Static Waterproof PVC Heavy Industry & Mining S Indu',
  'Heavy Industry & Mining Safety', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'Petrova Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  162375, 9.33, 16250.00,
  10, 93.30, 1623750,
  '58 x 42 x 38', 0.0960, 23.50,
  360, 850,
  'Professional studio photography of Petrova Petrova Sepatu Boots Ultimate Yellow Size 39 PVC Steel Toe Cap Anti Static, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of Petrova Petrova Sepatu Boots Ultimate Yellow Size 39 PVC Steel Toe Cap Anti Static, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of Petrova Petrova Sepatu Boots Ultimate Yellow Size 39 PVC Steel Toe Cap Anti Static, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of Petrova Petrova Sepatu Boots Ultimate Yellow Size 39 PVC Steel Toe Cap Anti Static in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_39_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_39_PVC_Steel_Toe_Cap_Anti_Static.webp', 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_39_PVC_Steel_Toe_Cap_Anti_Static/side_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_39_PVC_Steel_Toe_Cap_Anti_Static.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP MAX Coklat Hitam - Sepatu Safety PVC - 39/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/05_AP_Boots_Black_White_Series/AP Boots AP MAX Coklat Hitam - Sepatu Safety PVC - 39/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10119, 2119, 'MST-119', 'Petrova Petrova Sepatu Boots Ultimate Yellow Size 40 PVC Steel Toe Cap Anti Static Waterproof PVC Heavy Industry & Mining S Indu',
  'Heavy Industry & Mining Safety', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'Petrova Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  162375, 9.33, 16250.00,
  10, 93.30, 1623750,
  '58 x 42 x 38', 0.0960, 23.50,
  360, 850,
  'Professional studio photography of Petrova Petrova Sepatu Boots Ultimate Yellow Size 40 PVC Steel Toe Cap Anti Static, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of Petrova Petrova Sepatu Boots Ultimate Yellow Size 40 PVC Steel Toe Cap Anti Static, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of Petrova Petrova Sepatu Boots Ultimate Yellow Size 40 PVC Steel Toe Cap Anti Static, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of Petrova Petrova Sepatu Boots Ultimate Yellow Size 40 PVC Steel Toe Cap Anti Static in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_40_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_40_PVC_Steel_Toe_Cap_Anti_Static.webp', 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_40_PVC_Steel_Toe_Cap_Anti_Static/side_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_40_PVC_Steel_Toe_Cap_Anti_Static.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10120, 2120, 'MST-120', 'Petrova Petrova Sepatu Boots Ultimate Yellow Size 41 PVC Steel Toe Cap Anti Static Waterproof PVC Heavy Industry & Mining S Indu',
  'Heavy Industry & Mining Safety', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'Petrova Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  162375, 9.33, 16250.00,
  10, 93.30, 1623750,
  '58 x 42 x 38', 0.0960, 23.50,
  360, 850,
  'Professional studio photography of Petrova Petrova Sepatu Boots Ultimate Yellow Size 41 PVC Steel Toe Cap Anti Static, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of Petrova Petrova Sepatu Boots Ultimate Yellow Size 41 PVC Steel Toe Cap Anti Static, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of Petrova Petrova Sepatu Boots Ultimate Yellow Size 41 PVC Steel Toe Cap Anti Static, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of Petrova Petrova Sepatu Boots Ultimate Yellow Size 41 PVC Steel Toe Cap Anti Static in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_41_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_41_PVC_Steel_Toe_Cap_Anti_Static.webp', 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_41_PVC_Steel_Toe_Cap_Anti_Static/side_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_41_PVC_Steel_Toe_Cap_Anti_Static.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10121, 2121, 'MST-121', 'Petrova Petrova Sepatu Boots Ultimate Yellow Size 43 PVC Steel Toe Cap Anti Static Waterproof PVC Heavy Industry & Mining S Indu',
  'Heavy Industry & Mining Safety', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'Petrova Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  162375, 9.33, 16250.00,
  10, 93.30, 1623750,
  '58 x 42 x 38', 0.0960, 23.50,
  360, 850,
  'Professional studio photography of Petrova Petrova Sepatu Boots Ultimate Yellow Size 43 PVC Steel Toe Cap Anti Static, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of Petrova Petrova Sepatu Boots Ultimate Yellow Size 43 PVC Steel Toe Cap Anti Static, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of Petrova Petrova Sepatu Boots Ultimate Yellow Size 43 PVC Steel Toe Cap Anti Static, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of Petrova Petrova Sepatu Boots Ultimate Yellow Size 43 PVC Steel Toe Cap Anti Static in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_43_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_43_PVC_Steel_Toe_Cap_Anti_Static.webp', 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_43_PVC_Steel_Toe_Cap_Anti_Static/side_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_43_PVC_Steel_Toe_Cap_Anti_Static.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10122, 2122, 'MST-122', 'Petrova Petrova Sepatu Boots Ultimate Yellow Size 44 PVC Steel Toe Cap Anti Static Waterproof PVC Heavy Industry & Mining S Indu',
  'Heavy Industry & Mining Safety', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'Petrova Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  162375, 9.33, 16250.00,
  10, 93.30, 1623750,
  '58 x 42 x 38', 0.0960, 23.50,
  360, 850,
  'Professional studio photography of Petrova Petrova Sepatu Boots Ultimate Yellow Size 44 PVC Steel Toe Cap Anti Static, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of Petrova Petrova Sepatu Boots Ultimate Yellow Size 44 PVC Steel Toe Cap Anti Static, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of Petrova Petrova Sepatu Boots Ultimate Yellow Size 44 PVC Steel Toe Cap Anti Static, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of Petrova Petrova Sepatu Boots Ultimate Yellow Size 44 PVC Steel Toe Cap Anti Static in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_44_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_44_PVC_Steel_Toe_Cap_Anti_Static.webp', 'https://catalog.hotstrading.com/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_44_PVC_Steel_Toe_Cap_Anti_Static/side_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_44_PVC_Steel_Toe_Cap_Anti_Static.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10123, 2123, 'MST-123', 'Petrova Petrova Sepatu Boots Tinggi PETROVA Classic Hitam Boots PVC Lentur Lokal Waterproof PVC Heavy Industry & Mining S Indust',
  'Heavy Industry & Mining Safety', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'Petrova Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  105000, 6.03, 16250.00,
  10, 60.30, 1050000,
  '58 x 42 x 38', 0.0960, 23.50,
  360, 850,
  'Professional studio photography of Petrova Petrova Sepatu Boots Tinggi PETROVA Classic Hitam Boots PVC Lentur Lokal, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of Petrova Petrova Sepatu Boots Tinggi PETROVA Classic Hitam Boots PVC Lentur Lokal, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of Petrova Petrova Sepatu Boots Tinggi PETROVA Classic Hitam Boots PVC Lentur Lokal, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of Petrova Petrova Sepatu Boots Tinggi PETROVA Classic Hitam Boots PVC Lentur Lokal in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Sepatu_Boots_Tinggi_PETROVA_Classic_Hitam_Boots_PVC_Lentur_Lokal/hero_Sepatu_Boots_Tinggi_PETROVA_Classic_Hitam_Boots_PVC_Lentur_Lokal.webp', 'https://catalog.hotstrading.com/assets/shopee/Sepatu_Boots_Tinggi_PETROVA_Classic_Hitam_Boots_PVC_Lentur_Lokal/side_Sepatu_Boots_Tinggi_PETROVA_Classic_Hitam_Boots_PVC_Lentur_Lokal.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10124, 2124, 'MST-124', 'Petrova Petrova Sepatu Boots Tinggi PETROVA Pro Green Boots Karet Lentur Lokal Anti Slip & Air Ringan perkebunan Waterproof PVC ',
  'Heavy Industry & Mining Safety', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'Petrova Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  67500, 3.88, 16250.00,
  10, 38.80, 675000,
  '58 x 42 x 38', 0.0960, 23.50,
  360, 850,
  'Professional studio photography of Petrova Petrova Sepatu Boots Tinggi PETROVA Pro Green Boots Karet Lentur Lokal Anti Slip & Air Ringan perkebunan, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of Petrova Petrova Sepatu Boots Tinggi PETROVA Pro Green Boots Karet Lentur Lokal Anti Slip & Air Ringan perkebunan, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of Petrova Petrova Sepatu Boots Tinggi PETROVA Pro Green Boots Karet Lentur Lokal Anti Slip & Air Ringan perkebunan, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of Petrova Petrova Sepatu Boots Tinggi PETROVA Pro Green Boots Karet Lentur Lokal Anti Slip & Air Ringan perkebunan in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Sepatu_Boots_Tinggi_PETROVA_Pro_Green_Boots_Karet_Lentur_Lokal_Anti_Slip_&_Air_Ringan_perkebunan/hero_Sepatu_Boots_Tinggi_PETROVA_Pro_Green_Boots_Karet_Lentur_Lokal_Anti_Slip_&_Air_Ringan_perkebunan.webp', 'https://catalog.hotstrading.com/assets/shopee/Sepatu_Boots_Tinggi_PETROVA_Pro_Green_Boots_Karet_Lentur_Lokal_Anti_Slip_&_Air_Ringan_perkebunan/side_Sepatu_Boots_Tinggi_PETROVA_Pro_Green_Boots_Karet_Lentur_Lokal_Anti_Slip_&_Air_Ringan_perkebunan.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/01_AP_Terra_Series/AP Boots Terra Safety S4 - Sepatu Boot Safety PVC Shoes Kerja/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
),
(
  10125, 2125, 'MST-125', 'Petrova Petrova Sepatu Boots Tinggi Safety  STRENGTH kuning Steel Toe PVC Waterproof PVC Heavy Industry & Mining S Industrial Bo',
  'Heavy Industry & Mining Safety', 'Europe', 'Germany', 'Heavy Industrial & Civil Construction',
  'Petrova Safety Boots', 'Waterproof PVC Work Boots', 'Industrial Footwear Wholesale',
  '["pvc boots supplier", "indonesia boots exporter", "fob factory boots"]',
  120750, 6.94, 16250.00,
  10, 69.40, 1207500,
  '58 x 42 x 38', 0.0960, 23.50,
  360, 850,
  'Professional studio photography of Petrova Petrova Sepatu Boots Tinggi Safety  STRENGTH kuning Steel Toe PVC, 3/4 upright dynamic perspective, pure seamless white background RGB (255,255,255), sharp studio softbox lighting, 8k resolution, e-commerce catalog ready.', 'Crisp 90-degree lateral profile view of Petrova Petrova Sepatu Boots Tinggi Safety  STRENGTH kuning Steel Toe PVC, clean white seamless studio background, crisp silhouette showing shaft height and contour.', 'Close-up macro shot of the bottom outsole of Petrova Petrova Sepatu Boots Tinggi Safety  STRENGTH kuning Steel Toe PVC, showcasing cleated mud-release lug pattern, slip-resistant siping, pure white background.', 'Commercial B2B contextual photograph of Petrova Petrova Sepatu Boots Tinggi Safety  STRENGTH kuning Steel Toe PVC in heavy industrial construction site in Europe, cinematic realistic lighting.',
  'https://catalog.hotstrading.com/assets/shopee/Sepatu_Boots_Tinggi_Safety_Petrova_STRENGTH_kuning_Steel_Toe_PVC/hero_Sepatu_Boots_Tinggi_Safety_Petrova_STRENGTH_kuning_Steel_Toe_PVC.webp', 'https://catalog.hotstrading.com/assets/shopee/Sepatu_Boots_Tinggi_Safety_Petrova_STRENGTH_kuning_Steel_Toe_PVC/side_Sepatu_Boots_Tinggi_Safety_Petrova_STRENGTH_kuning_Steel_Toe_PVC.webp',
  'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/01_main_1600x1600.jpg', 'https://catalog.hotstrading.com/assets/tokopedia/03_AP_Chef_Medical_Series/AP Boots AP MEDIC Hitam - Sepatu Medis APD Safety Shoes - 36/02_gallery.jpg',
  NULL, NULL, 'READY_FOR_UPLOAD', NULL, NOW(), NOW()
);

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;

-- =============================================================
-- INJECTION SCRIPT COMPLETE! ALL 125 PRODUCTS READY ON LIVE DB
-- =============================================================