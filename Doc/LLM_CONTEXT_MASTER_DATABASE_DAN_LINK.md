# Master Context: Peta Database, Skema, Aset & Link Sistem (HOTS Trading / AP Boots)

> **Tujuan Dokumen:** Ringkasan konteks terpadu (*single-file context pack*) seluruh database SQLite, file SQL dump/injeksi, ekspor Excel/JSON, folder foto lokal, endpoint API lokal, dan URL produksi untuk langsung dimasukkan ke LLM lain (ChatGPT, Claude, Gemini, dll.) atau sebagai referensi cepat pengembangan.  
> **Workspace Utama:** [`d:\Work\Hots\Product Input`](file:///d:/Work/Hots/Product%20Input)  
> **Entitas Hukum:** Manufaktur: **PT Waru Gunung Industri** | Eksportir / Distributor Global: **PT Indo Sukses Semesta (HOTS Trading)**  
> **Total Master Produk:** **125 Master SKU** (106 AP Boots Official + 19 Petrova Heavy Duty Safety, **0 Duplikat**)

---

## 1. Peta Database SQLite Lokal

### A. [`Database/alibaba_master.db`](file:///d:/Work/Hots/Product%20Input/Database/alibaba_master.db) *(13.97 MB — Database Operasional Utama)*
Dipakai oleh server lokal [`App/alibaba_manager_app.py`](file:///d:/Work/Hots/Product%20Input/App/alibaba_manager_app.py) (`localhost:8888`) dan Chrome Extension Bridge [`App/extension_bridge.py`](file:///d:/Work/Hots/Product%20Input/App/extension_bridge.py).

| Tabel / View | Baris | Fungsi & Kolom Kunci |
| :--- | :---: | :--- |
| **`master_products`** | **125** | Master tunggal bebas duplikat (`MST-001`–`MST-125`). Kolom kunci: `id`, `master_sku`, `original_sku`, `barcode_ean13`, `brand`, `model_name`, `english_title`, `category_id`, `category_name`, `category_group`, `hs_code`, `color`, `sizes_available`, `material_upper`, `material_outsole`, `shaft_height_cm`, `weight_per_pair_g`, `steel_toe_cap`, `anti_puncture_midsole`, `slip_resistance_rating`, `certification_standards`, `price_shopee_idr`, `price_tokopedia_idr`, `price_blibli_idr`, `price_lazada_idr`, `price_retail_avg_idr`, `price_wholesale_idr`, `price_fob_usd`, `moq_pairs`, `pairs_per_carton`, `carton_volume_cbm`, `carton_gross_weight_kg`, `container_20ft_capacity_pairs`, `container_40ft_hq_capacity_pairs`, `description_id`, `description_en`, `seo_keywords`, `primary_image_url`, `total_reference_images`. |
| **`product_reference_images`** | **2.034** | Registri multi-sumber berlabel: `product_id`, `master_sku`, `source_flag` (`PHOTOBANK`, `SHOPEE`, `TOKOPEDIA_LOCAL`, `TOKOPEDIA`, `BLIBLI`, `LAZADA`), `flag_label`, `flag_color`, `image_title`, `image_type`, `image_url`, `is_primary`. |
| **`product_marketplace_crossref`** | **125** | Pemetaan ID lintas platform: `master_sku`, `original_sku`, `barcode_ean13`, `shopee_folder`, `shopee_sku`, `tokopedia_id`, `blibli_id`, `lazada_id`, `alibaba_matrix_sku`, `hots_system_sku`. |
| **`products`** | **802** | Tabel listing Alibaba Manager (`id`, `sku`, `model_number`, `alibaba_product_id`, `product_title`, `category`, `category_group`, `keywords`, `image_1..6`, `description_html`, `price_usd`, `price_idr`, `tier1_price..tier4_price`, `moq1..moq3`, `gross_weight_kg`, `pkg_length/width/height`, `status`, `source`, `is_flagship`, `flagship_rank`). Mencakup 125 baris tersinkronisasi (`source='MASTER_FINAL'`). |
| **`marketplace_raw`** | **491** | Data mentah hasil *scraping* Tokopedia, Shopee, Blibli, Lazada (`source`, `source_id`, `product_name`, `price_idr`, `sold_count`, `rating_score`, `source_url`, `image_1..6`, `duplicate_images_removed`). |
| **`alibaba_matrix_800`** | **810** | Matriks ekspansi SEO B2B (10 *industry angle* × 80+ negara tujuan ekspor): `unique_sku_code`, `base_sku`, `target_industry_angle`, `alibaba_product_title`, `primary_keyword_1..3`, `longtail_keywords`, `price_tier1..3_usd`, `tailored_html_description`. |
| **`alibaba_keywords`** | **810** | Kamus keyword B2B per SKU & angle (`unique_sku_code`, `primary_keyword_1..3`, `longtail_keywords`). |
| **`alibaba_upload_reports`** | **15** | Log audit laporan gagal/sukses upload bulk Alibaba (`failed_reason`, `error_category`, `resolved_img1..6`, `status`). |
| **`v_master_products_full`** *(VIEW)* | **125** | Gabungan siap query antara `master_products` + `product_marketplace_crossref` (41 kolom). |

### B. [`FINAL/master_products_consolidated.db`](file:///d:/Work/Hots/Product%20Input/FINAL/master_products_consolidated.db) *(1.46 MB)*
Database SQLite bersih khusus konsolidasi master final (`master_products` 125 baris, `product_reference_images` 2.034 baris, `product_marketplace_crossref` 125 baris).

### C. [`Database/padi_umkm_master.db`](file:///d:/Work/Hots/Product%20Input/Database/padi_umkm_master.db) *(139 KB)*
Database untuk platform BUMN/B2B **PaDi UMKM**:
* Tabel **`padi_products`** (**76 baris**, 39 kolom): `batch_num`, `nama_produk`, `deskripsi_produk`, `kategori_kode`, `berat_produk_gr`, `dimensi_panjang/lebar/tinggi_cm`, `pembelian_minimum`, `pdn`, `jenis_tkdn`, `nilai_tkdn`, `foto_produk_1..5`, `harga_satuan`, `ppn`, `kode_sku`, `status`.

---

## 2. Peta File SQL Dump & Skrip Injeksi (MySQL / MariaDB)

| File SQL | Ukuran | Target Database / Kegunaan |
| :--- | :---: | :--- |
| [`FINAL/inject_catalog_hotstrading.sql`](file:///d:/Work/Hots/Product%20Input/FINAL/inject_catalog_hotstrading.sql)<br>*(mirror: [`Database/inject_catalog_hotstrading.sql`](file:///d:/Work/Hots/Product%20Input/Database/inject_catalog_hotstrading.sql))* | 909 KB | **Skrip Injeksi Produksi `catalog.hotstrading.com`** (`hotj4796_hotstrading`, MariaDB 10.11+). Idempoten (`ID 2001–2125`, `MST-001`–`MST-125`). Mengisi 8 tabel: `categories`, `manufacturers`, `products`, `product_specifications`, `product_use_cases`, `product_regions`, `product_certifications`, `alibaba_export_listings`. |
| [`FINAL/master_products_database.sql`](file:///d:/Work/Hots/Product%20Input/FINAL/master_products_database.sql)<br>*(mirror: [`Database/master_products_database.sql`](file:///d:/Work/Hots/Product%20Input/Database/master_products_database.sql))* | 1.93 MB | Dump SQL universal (kompatibel MySQL, MariaDB, PostgreSQL, SQLite) berisi tabel `master_categories`, `master_products`, `product_marketplace_crossref`, `product_reference_images`, dan view `v_master_products_full`. |
| [`Database/hotj4796_hotstrading (4).sql`](file:///d:/Work/Hots/Product%20Input/Database/hotj4796_hotstrading%20(4).sql) | 113 KB | Backup schema asli database produksi website `hotstrading.com` (`hotj4796_hotstrading`). |
| [`HotsAdmin_Module/sql/database_schema.sql`](file:///d:/Work/Hots/Product%20Input/HotsAdmin_Module/sql/database_schema.sql) | 5.7 KB | Skema tabel ekstensi ekspor `alibaba_export_listings` untuk admin website PHP. |
| [`HotsAdmin_Module/sql/full_alibaba_master_dump.sql`](file:///d:/Work/Hots/Product%20Input/HotsAdmin_Module/sql/full_alibaba_master_dump.sql) | 6.98 MB | Dump penuh dataset Alibaba Master untuk modul admin PHP. |
| [`HotsAdmin_Module/sql/sample_products_seed.sql`](file:///d:/Work/Hots/Product%20Input/HotsAdmin_Module/sql/sample_products_seed.sql) | 79.8 KB | Seed awal katalog produk (`products`). |
| [`HotsAdmin_Module/sql/seed_market_rules.sql`](file:///d:/Work/Hots/Product%20Input/HotsAdmin_Module/sql/seed_market_rules.sql) | 3.0 KB | Aturan pasar & parameter ekspor untuk modul PHP. |

---

## 3. Master Export JSON, Excel (.xlsx/.xlsm) & CSV

| File | Ukuran | Isi Utama |
| :--- | :---: | :--- |
| [`FINAL/master_products_catalog.json`](file:///d:/Work/Hots/Product%20Input/FINAL/master_products_catalog.json) | 2.06 MB | JSON lengkap 125 Master SKU + 11 kategori + 2.034 referensi gambar berlabel. |
| [`FINAL/master_products_complete_detailed.xlsx`](file:///d:/Work/Hots/Product%20Input/FINAL/master_products_complete_detailed.xlsx) | 190 KB | Workbook 4 sheet: `Master Products Complete`, `Crossref & SQL Identification`, `Flagged Reference Images`, `Pricing & Container Logistics`. |
| [`FINAL/master_products_complete_detailed.xlsm`](file:///d:/Work/Hots/Product%20Input/FINAL/master_products_complete_detailed.xlsm) | 190 KB | Versi Macro-Enabled Spreadsheet untuk otomasi formula. |
| [`FINAL/master_products_complete_detailed.csv`](file:///d:/Work/Hots/Product%20Input/FINAL/master_products_complete_detailed.csv) | 655 KB | Ekspor flat CSV lengkap 125 SKU. |
| [`Output/flow_product_input_jobs.json`](file:///d:/Work/Hots/Product%20Input/Output/flow_product_input_jobs.json) | 823 KB | Antrean **424 job** prompt 4-slot Google Flow (`slot_1_hero`, `slot_2_side`, `slot_3_tread`, `slot_4_contextual`). |
| [`Output/Photobank_Siap_Upload/DAFTAR_FOTO_DAN_KATEGORI_PHOTOBANK.csv`](file:///d:/Work/Hots/Product%20Input/Output/Photobank_Siap_Upload/DAFTAR_FOTO_DAN_KATEGORI_PHOTOBANK.csv) | — | Indeks pemetaan file `.webp` ke 11 folder kategori Photobank. |
| [`Output/Alibaba_Bulk_Upload_Tokopedia_Master_2026.xlsx`](file:///d:/Work/Hots/Product%20Input/Output/Alibaba_Bulk_Upload_Tokopedia_Master_2026.xlsx) | 210 KB | Template resmi bulk upload Alibaba (57 kolom). |
| [`Output/id29233741662kjoc_368505_success.xlsx`](file:///d:/Work/Hots/Product%20Input/Output/id29233741662kjoc_368505_success.xlsx) | 14.9 KB | Laporan referensi 84 produk yang sukses terbit di Alibaba Seller Center. |

---

## 4. Peta Aset Foto Lokal & 11 Kategori Folder Resmi

* [`Output/Photobank_Siap_Upload`](file:///d:/Work/Hots/Product%20Input/Output/Photobank_Siap_Upload) — **517 file `.webp`** dalam **11 folder kategori resmi**:
  `01_Safety_Boots`, `02_Terra_Series`, `03_Orca_Series`, `04_Chef_Series`, `05_Medic_Series`, `06_Biker_Casual`, `07_Classic_Boots`, `08_Kids_Boots`, `09_Sandals_Clogs`, `10_Kasual_Sneakers`, `11_General_Lifestyle_Boots`.
* [`Shopee_Product_Assets`](file:///d:/Work/Hots/Product%20Input/Shopee_Product_Assets) — **124 folder produk** (`hero_*.webp`, `side_*.webp`, `<produk>.json`).
* [`Images_Tokopedia`](file:///d:/Work/Hots/Product%20Input/Images_Tokopedia) — **468 foto lokal** (resolusi hingga 1600×1600) dalam 12 folder seri (`01_AP_Terra_Series` s/d `12_AP_General_Boots`).

---

## 5. Peta Link Lokal, API Endpoint & URL Produksi

### A. URL Lokal & Launcher
* **Web Dashboard & Local Bridge (:8888):** `http://localhost:8888` ([`App/alibaba_manager_app.py`](file:///d:/Work/Hots/Product%20Input/App/alibaba_manager_app.py))
* **Master Catalog FINAL (:8888 / :8899):** `http://localhost:8888/final` & `http://localhost:8899` ([`FINAL/server_final.py`](file:///d:/Work/Hots/Product%20Input/FINAL/server_final.py))
* **Launcher Terpadu Chrome Extension (`aufahots@gmail.com`):** [`run_alibaba_extension_flow.bat`](file:///d:/Work/Hots/Product%20Input/run_alibaba_extension_flow.bat) → [`Chrome_Extension/`](file:///d:/Work/Hots/Product%20Input/Chrome_Extension)
* **Download SQL Produksi:** `http://localhost:8888/inject_catalog_hotstrading.sql` | `http://localhost:8888/master_products_database.sql`

### B. Endpoint API Local Bridge (`http://localhost:8888`)
* `GET /api/ext/health` — Status server, total 125 SKU, dan target profil `aufahots@gmail.com`.
* `GET /api/ext/categories` — Daftar 11 folder kategori resmi beserta jumlah SKU.
* `GET /api/ext/queue?category=&q=&status=` — Antrean 125 SKU dengan filter kategori, pencarian, dan status.
* `GET /api/ext/product/<sku>` — Detail SKU berformat blueprint (`lock: true`, `Product_Name`, `Keyword_1..3`, `MOQ`, `Price_Min`, `Price_Max`, `Photobank_Group`, `images[]`).
* `GET /api/ext/flow-jobs/<sku>` — Payload 4-slot prompt Google Flow per SKU.
* `POST /api/ext/sync-alibaba-list` — Sinkronisasi hasil *scan* `list-manage` Alibaba ke `alibaba_master.db`.
* `POST /api/ext/flow-downloaded` — Konversi & simpan otomatis unduhan Google Flow (2K/1K) ke `Output/Photobank_Siap_Upload/<Kategori>/`.
* `POST /api/ext/status` — Pembaruan status produk & `alibaba_product_id`.
* **Static Assets Offline:** `/assets/photobank/...`, `/assets/shopee/...` (`/shopee-assets/...`), `/assets/tokopedia/...` (`/tokopedia-assets/...`).

### C. URL Eksternal & Produksi
* **Website Katalog B2B Live:** `https://catalog.hotstrading.com` *(DB: `hotj4796_hotstrading`)*
* **Admin Photobank Web:** `https://admin.hotstrading.com/photo-bank`
* **Google Flow Project (`aufahots@gmail.com`):** `https://flow.google.com/project/5a88c3fd-477c-4eed-a126-f812ccfb079c`
* **Alibaba Photobank:** `https://photobank.alibaba.com/?spm=a2747.$spmCode.0.0.486254bez2VZ2Y`
* **Alibaba Product List Manage:** `https://i.alibaba.com/products/list-manage?spm=a2700.post-success.0.0.290f3e5fVEhelJ#/product/all`
* **Alibaba Add New Product:** `https://i.alibaba.com/products/publish-plan`

---

## 6. Quick Context Prompt (Siap Copy-Paste ke LLM Lain)

```text
Konteks Proyek: Sistem Katalog & Otomasi B2B Footwear Indonesia (AP Boots & Petrova).
Entitas: Manufaktur PT Waru Gunung Industri | Eksportir PT Indo Sukses Semesta (HOTS Trading).
Master Data (0 Duplikat): 125 SKU (106 AP Boots + 19 Petrova) tersimpan di:
- SQLite Utama: Database/alibaba_master.db (tabel: master_products [125], product_reference_images [2034], product_marketplace_crossref [125], products [802], marketplace_raw [491], alibaba_matrix_800 [810], view v_master_products_full)
- SQLite Master Bersih: FINAL/master_products_consolidated.db
- SQLite PaDi UMKM: Database/padi_umkm_master.db (padi_products [76])
- SQL Injeksi Produksi (catalog.hotstrading.com / MariaDB hotj4796_hotstrading): FINAL/inject_catalog_hotstrading.sql (ID 2001-2125, 8 tabel: categories, manufacturers, products, product_specifications, product_use_cases, product_regions, product_certifications, alibaba_export_listings)
- SQL Universal: FINAL/master_products_database.sql
- JSON/Excel: FINAL/master_products_catalog.json, FINAL/master_products_complete_detailed.xlsx, Output/flow_product_input_jobs.json (424 jobs)
Aset Gambar Lokal: Output/Photobank_Siap_Upload/ (517 .webp dalam 11 folder kategori), Shopee_Product_Assets/ (124 folder), Images_Tokopedia/ (468 foto).
Local Server Bridge: http://localhost:8888 (App/alibaba_manager_app.py + App/extension_bridge.py) dengan endpoint /api/ext/health, /api/ext/categories, /api/ext/queue, /api/ext/product/<sku>, /api/ext/flow-jobs/<sku>, /api/ext/sync-alibaba-list, /api/ext/flow-downloaded, serta static /assets/photobank/, /assets/shopee/, /assets/tokopedia/.
Integrasi Browser (Chrome_Extension MV3 di profil aufahots@gmail.com):
- Google Flow Agent: https://flow.google.com/project/5a88c3fd-477c-4eed-a126-f812ccfb079c (Hero wajib 2K, slot lain 2K fallback 1K)
- Alibaba Photobank: https://photobank.alibaba.com/?spm=a2747.$spmCode.0.0.486254bez2VZ2Y
- Alibaba List & Publish: https://i.alibaba.com/products/list-manage#/product/all & https://i.alibaba.com/products/publish-plan
- Live Catalog: https://catalog.hotstrading.com
```

---

## 7. Data Lengkap 125 Master SKU (`master_products` + `crossref` + `alibaba_master.db`)

| Master SKU | Orig SKU | Brand | Model Name | Photobank Group | EAN-13 | HS Code | Sizes | Retail (IDR) | FOB (USD) | MOQ | Foto | Primary Image Path | Alibaba ID / Status |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | ---: | ---: | ---: | ---: | :--- | :--- |
| `MST-001` | `APB-016` | AP Boots | AP MAX Coklat Hitam | `01_Safety_Boots` | `8997234000017` | `6401.10.00` | EU 39 - 44 | Rp 314,425 | $13.54 | 10 | 23 | `/assets/shopee/AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC/hero_AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC.webp` | 1600000001 (APPROVED) |
| `MST-002` | `APB-025` | AP Boots | AP METAGUARD | `01_Safety_Boots` | `8997234000024` | `6401.10.00` | EU 39 - 44 | Rp 300,400 | $12.94 | 10 | 12 | `/assets/shopee/AP_Boots_METAGUARD_Black_Sepatu_Boot_PVC/hero_AP_Boots_METAGUARD_Black_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-003` | `APB-026` | AP Boots | AP MAX Safety S5 Steel Toe | `01_Safety_Boots` | `8997234000031` | `6401.10.00` | EU 38 - 45 | Rp 298,533 | $12.86 | 10 | 27 | `/assets/shopee/AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC/hero_AP_Boots_AP_MAX_Coklat_Hitam_Sepatu_Safety_PVC.webp` | APPROVED |
| `MST-004` | `APB-073` | AP Boots | AP Safety S5 BLACK | `01_Safety_Boots` | `8997234000048` | `6401.10.00` | EU 39 - 44 | Rp 298,500 | $12.86 | 10 | 19 | `/assets/shopee/AP_Boots_Safety_S5_BLACK_Sepatu_Boot_PVC/hero_AP_Boots_Safety_S5_BLACK_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-005` | `APB-074` | AP Boots | AP METAGUARD Black | `01_Safety_Boots` | `8997234000055` | `6401.10.00` | EU 39 - 45 | Rp 300,400 | $12.94 | 10 | 12 | `/assets/shopee/AP_Boots_METAGUARD_Black_Sepatu_Boot_PVC/hero_AP_Boots_METAGUARD_Black_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-006` | `APB-081` | AP Boots | AP Safety S4 Black | `01_Safety_Boots` | `8997234000062` | `6401.10.00` | EU 39 - 44 | Rp 273,566 | $11.78 | 10 | 15 | `/assets/shopee/AP_Boots_Safety_S4_Black_Sepatu_Boot_PVC/hero_AP_Boots_Safety_S4_Black_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-007` | `APB-096` | AP Boots | AP Safety S5 | `01_Safety_Boots` | `8997234000079` | `6401.10.00` | EU 38 - 45 | Rp 298,500 | $12.86 | 10 | 19 | `/assets/shopee/AP_Boots_Safety_S5_BLACK_Sepatu_Boot_PVC/hero_AP_Boots_Safety_S5_BLACK_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-008` | `APB-007` | AP Boots | AP TERRA ECO 3 Hijau | `02_Terra_Series` | `8997234000086` | `6401.92.00` | EU 38 - 44 | Rp 98,100 | $4.23 | 12 | 17 | `/assets/shopee/AP_Boots_TERRA_ECO_3_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_3_Hijau_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-009` | `APB-008` | AP Boots | AP TERRA ECO 3 Hitam | `02_Terra_Series` | `8997234000093` | `6401.92.00` | EU 38 - 44 | Rp 80,625 | $3.47 | 12 | 25 | `/assets/shopee/AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-010` | `APB-009` | AP Boots | AP TERRA ECO 3 Kuning | `02_Terra_Series` | `8997234000109` | `6401.92.00` | EU 38 - 44 | Rp 107,400 | $4.63 | 12 | 15 | `/assets/shopee/AP_Boots_TERRA_ECO_3_Kuning_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_3_Kuning_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-011` | `APB-010` | AP Boots | AP TERRA ECO 3 Orange | `02_Terra_Series` | `8997234000116` | `6401.92.00` | EU 38 - 44 | Rp 114,066 | $4.91 | 12 | 17 | `/assets/shopee/AP_Boots_TERRA_ECO_3_Orange_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_3_Orange_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-012` | `APB-015` | AP Boots | AP TERRA GP Hitam | `02_Terra_Series` | `8997234000123` | `6401.92.00` | EU 38 - 45 | Rp 62,900 | $2.71 | 12 | 15 | `/assets/shopee/AP_Boots_TERRA_GP_Hitam_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_GP_Hitam_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-013` | `APB-021` | AP Boots | AP TERRA 1 Kuning | `02_Terra_Series` | `8997234000130` | `6401.92.00` | EU 38 - 43 | Rp 137,400 | $5.92 | 12 | 12 | `/assets/shopee/AP_Boots_AP_TERRA_3_HITAM_KUNING_Sepatu_boots_PVC/hero_AP_Boots_AP_TERRA_3_HITAM_KUNING_Sepatu_boots_PVC.webp` | APPROVED |
| `MST-014` | `APB-022` | AP Boots | AP TERRA 1 Hijau | `02_Terra_Series` | `8997234000147` | `6401.92.00` | EU 38 - 43 | Rp 126,999 | $5.47 | 12 | 11 | `/assets/shopee/AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-015` | `APB-023` | AP Boots | AP TERRA 1 Putih | `02_Terra_Series` | `8997234000154` | `6401.92.00` | EU 38 - 43 | Rp 144,900 | $6.24 | 12 | 12 | `/assets/shopee/AP_Boots_TERRA_1_Putih_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_1_Putih_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-016` | `APB-029` | AP Boots | AP TERRA ECO 5 | `02_Terra_Series` | `8997234000161` | `6401.92.00` | EU 38 - 44 | Rp 94,400 | $4.07 | 12 | 12 | `/assets/shopee/AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-017` | `APB-040` | AP Boots | AP TERRA ECO 2 Full Hitam | `02_Terra_Series` | `8997234000178` | `6401.92.00` | EU 39 - 43 | Rp 80,625 | $3.47 | 12 | 25 | `/assets/shopee/AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_2_Full_Hitam_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-018` | `APB-041` | AP Boots | AP TERRA 3 Hijau Merah | `02_Terra_Series` | `8997234000185` | `6401.92.00` | EU 38 - 44 | Rp 125,566 | $5.41 | 12 | 16 | `/assets/shopee/AP_Boots_TERRA_3_Hijau_Merah_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_3_Hijau_Merah_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-019` | `APB-052` | AP Boots | AP TERRA ARMY | `02_Terra_Series` | `8997234000192` | `6401.92.00` | EU 39 - 44 | Rp 170,900 | $7.36 | 12 | 12 | `/assets/shopee/AP_Boots_AP_TERRA_ARMY_Sepatu_Boot_PVC/hero_AP_Boots_AP_TERRA_ARMY_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-020` | `APB-053` | AP Boots | AP TERRA FOREST | `02_Terra_Series` | `8997234000208` | `6401.92.00` | EU 39 - 44 | Rp 170,900 | $7.36 | 12 | 12 | `/assets/shopee/AP_Boots_AP_TERRA_FOREST_Sepatu_Boot_PVC/hero_AP_Boots_AP_TERRA_FOREST_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-021` | `APB-072` | AP Boots | AP TERRA 3 HITAM KUNING | `02_Terra_Series` | `8997234000215` | `6401.92.00` | EU 38 - 44 | Rp 124,066 | $5.34 | 12 | 15 | `/assets/shopee/AP_Boots_AP_TERRA_3_HITAM_KUNING_Sepatu_boots_PVC/hero_AP_Boots_AP_TERRA_3_HITAM_KUNING_Sepatu_boots_PVC.webp` | APPROVED |
| `MST-022` | `APB-075` | AP Boots | AP TERRA 2 HIJAU | `02_Terra_Series` | `8997234000222` | `6401.92.00` | EU 38 - 43 | Rp 126,999 | $5.47 | 12 | 11 | `/assets/shopee/AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-023` | `APB-076` | AP Boots | Ap Boots TERRA 5 HIJAU | `02_Terra_Series` | `8997234000239` | `6401.92.00` | EU 39 - 44 | Rp 126,999 | $5.47 | 12 | 11 | `/assets/shopee/AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_1_Hijau_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-024` | `APB-080` | AP Boots | AP TERRA ECO 5 PUTIH | `02_Terra_Series` | `8997234000246` | `6401.92.00` | EU 38 - 43 | Rp 98,400 | $4.24 | 12 | 15 | `/assets/shopee/AP_Boots_TERRA_ECO_5_PUTIH_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_ECO_5_PUTIH_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-025` | `APB-083` | AP Boots | AP TERRA GP Hijau | `02_Terra_Series` | `8997234000253` | `6401.92.00` | EU 38 - 44 | Rp 74,400 | $3.20 | 12 | 14 | `/assets/shopee/AP_Boots_TERRA_GP_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_TERRA_GP_Hijau_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-026` | `APB-095` | AP Boots | AP Terra Safety S4 | `02_Terra_Series` | `8997234000260` | `6401.92.00` | EU 39 - 44 | Rp 273,566 | $11.78 | 12 | 15 | `/assets/shopee/AP_Boots_Terra_Safety_S4_Kuning_Sepatu_Boot_Safety_PVC/hero_AP_Boots_Terra_Safety_S4_Kuning_Sepatu_Boot_Safety_PVC.webp` | APPROVED |
| `MST-027` | `APB-024` | AP Boots | AP Boots ORCA | `03_Orca_Series` | `8997234000277` | `6401.92.00` | EU 39 - 45 | Rp 103,125 | $4.44 | 12 | 16 | `/assets/shopee/AP_Boots_ORCA_Sepatu_Boot_PVC/hero_AP_Boots_ORCA_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-028` | `APB-030` | AP Boots | AP Chef Putih | `04_Chef_Series` | `8997234000284` | `6402.99.10` | EU 36 - 44 | Rp 205,478 | $8.85 | 12 | 25 | `/assets/shopee/AP_Boots_AP_Chef_Putih_Sepatu_Slip_On_Dapur/hero_AP_Boots_AP_Chef_Putih_Sepatu_Slip_On_Dapur.webp` | APPROVED |
| `MST-029` | `APB-038` | AP Boots | AP Chef Hitam | `04_Chef_Series` | `8997234000291` | `6402.99.10` | EU 36 - 44 | Rp 206,700 | $8.90 | 12 | 28 | `/assets/shopee/AP_Boots_AP_Chef_Hitam_Sepatu_Slip_On_Dapur/hero_AP_Boots_AP_Chef_Hitam_Sepatu_Slip_On_Dapur.webp` | APPROVED |
| `MST-030` | `APB-051` | AP Boots | Footbed Sol AP CHEF | `04_Chef_Series` | `8997234000307` | `6406.90.90` | Multi-Size | Rp 131,700 | $5.67 | 12 | 25 | `/assets/shopee/AP_Boots_Footbed_Sol_AP_CHEF_Ortholite/hero_AP_Boots_Footbed_Sol_AP_CHEF_Ortholite.webp` | APPROVED |
| `MST-031` | `APB-035` | AP Boots | AP MEDIC Biru | `05_Medic_Series` | `8997234000314` | `6402.99.10` | EU 36 - 43 | Rp 265,000 | $11.42 | 12 | 37 | `/assets/shopee/AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD.webp` | APPROVED |
| `MST-032` | `APB-036` | AP Boots | AP MEDIC Hijau | `05_Medic_Series` | `8997234000321` | `6402.99.10` | EU 36 - 43 | Rp 271,000 | $11.67 | 12 | 37 | `/assets/shopee/AP_Boots_AP_MEDIC_Hijau_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Hijau_Sepatu_Medis_APD.webp` | APPROVED |
| `MST-033` | `APB-037` | AP Boots | AP MEDIC Putih | `05_Medic_Series` | `8997234000338` | `6402.99.10` | EU 36 - 43 | Rp 259,540 | $11.18 | 12 | 35 | `/assets/shopee/AP_Boots_AP_MEDIC_Putih_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Putih_Sepatu_Medis_APD.webp` | APPROVED |
| `MST-034` | `APB-060` | AP Boots | Footbed SOL AP Medic Biru | `05_Medic_Series` | `8997234000345` | `6406.90.90` | Multi-Size | Rp 210,000 | $9.05 | 12 | 37 | `/assets/shopee/AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD.webp` | APPROVED |
| `MST-035` | `APB-061` | AP Boots | Footbed SOL AP Medic Kuning | `05_Medic_Series` | `8997234000352` | `6406.90.90` | Multi-Size | Rp 157,000 | $6.76 | 12 | 33 | `/assets/shopee/AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Biru_Sepatu_Medis_APD.webp` | APPROVED |
| `MST-036` | `APB-063` | AP Boots | AP MEDIC Pink | `05_Medic_Series` | `8997234000369` | `6402.99.10` | EU 36 - 41 | Rp 285,666 | $12.31 | 12 | 33 | `/assets/shopee/AP_Boots_AP_MEDIC_Pink_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Pink_Sepatu_Medis_APD.webp` | APPROVED |
| `MST-037` | `APB-064` | AP Boots | AP MEDIC Hitam | `05_Medic_Series` | `8997234000376` | `6402.99.10` | EU 37 - 43 | Rp 279,000 | $12.02 | 12 | 32 | `/assets/shopee/AP_Boots_AP_MEDIC_Hitam_Sepatu_Medis_APD/hero_AP_Boots_AP_MEDIC_Hitam_Sepatu_Medis_APD.webp` | APPROVED |
| `MST-038` | `APB-001` | AP Boots | AP ALLBIKE Orange | `06_Biker_Casual` | `8997234000383` | `6401.92.00` | EU 38 - 43 | Rp 66,150 | $2.85 | 12 | 30 | `/assets/shopee/AP_Boots_ALLBIKE_2_ORANGE_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_ORANGE_Sepatu_Bike_PVC.webp` | APPROVED |
| `MST-039` | `APB-013` | AP Boots | AP ALLBIKE 2 ORANGE | `06_Biker_Casual` | `8997234000390` | `6401.92.00` | EU 38 - 44 | Rp 66,150 | $2.85 | 12 | 30 | `/assets/shopee/AP_Boots_ALLBIKE_2_ORANGE_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_ORANGE_Sepatu_Bike_PVC.webp` | APPROVED |
| `MST-040` | `APB-027` | AP Boots | AP Boots Hobby N Work | `06_Biker_Casual` | `8997234000406` | `6401.92.00` | EU 39 - 43 | Rp 97,400 | $4.20 | 12 | 8 | `/assets/shopee/AP_Boots_Hobby_N_Work_Sepatu_Boot_PVC/hero_AP_Boots_Hobby_N_Work_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-041` | `APB-069` | AP Boots | AP ALLBIKE Abu | `06_Biker_Casual` | `8997234000413` | `6401.92.00` | EU 38 - 43 | Rp 66,150 | $2.85 | 12 | 29 | `/assets/shopee/AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC.webp` | APPROVED |
| `MST-042` | `APB-070` | AP Boots | AP ALLBIKE 2 HIJAU | `06_Biker_Casual` | `8997234000420` | `6401.92.00` | EU 38 - 43 | Rp 61,900 | $2.67 | 12 | 32 | `/assets/shopee/AP_Boots_ALLBIKE_2_HIJAU_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_HIJAU_Sepatu_Bike_PVC.webp` | APPROVED |
| `MST-043` | `APB-071` | AP Boots | AP ALLBIKE 2 ABU | `06_Biker_Casual` | `8997234000437` | `6401.92.00` | EU 38 - 43 | Rp 66,150 | $2.85 | 12 | 29 | `/assets/shopee/AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC.webp` | APPROVED |
| `MST-044` | `APB-097` | AP Boots | AP Boots MOTO 1 | `06_Biker_Casual` | `8997234000444` | `6401.92.00` | EU 38 - 43 | Rp 135,100 | $5.82 | 12 | 20 | `/assets/shopee/AP_Boots_MOTO_1_Sepatu_Boot_PVC/hero_AP_Boots_MOTO_1_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-045` | `APB-098` | AP Boots | AP Boots MOTO 2 | `06_Biker_Casual` | `8997234000451` | `6401.92.00` | EU 38 - 44 | Rp 135,100 | $5.82 | 12 | 20 | `/assets/shopee/AP_Boots_MOTO_1_Sepatu_Boot_PVC/hero_AP_Boots_MOTO_1_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-046` | `APB-099` | AP Boots | AP Boots MOTO 3 | `06_Biker_Casual` | `8997234000468` | `6401.92.00` | EU 38 - 44 | Rp 135,100 | $5.82 | 12 | 20 | `/assets/shopee/AP_Boots_MOTO_1_Sepatu_Boot_PVC/hero_AP_Boots_MOTO_1_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-047` | `APB-104` | AP Boots | AP ALLBIKE 2 | `06_Biker_Casual` | `8997234000475` | `6401.92.00` | EU 38 - 43 | Rp 58,900 | $2.54 | 12 | 28 | `/assets/shopee/AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_ABU_Sepatu_Bike_PVC.webp` | APPROVED |
| `MST-048` | `APB-105` | AP Boots | AP ALLBIKE Hijau | `06_Biker_Casual` | `8997234000482` | `6401.92.00` | EU 38 - 43 | Rp 61,900 | $2.67 | 12 | 32 | `/assets/shopee/AP_Boots_ALLBIKE_2_HIJAU_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_HIJAU_Sepatu_Bike_PVC.webp` | APPROVED |
| `MST-049` | `APB-106` | AP Boots | AP ALLBIKE Merah | `06_Biker_Casual` | `8997234000499` | `6401.92.00` | EU 38 - 43 | Rp 61,900 | $2.67 | 12 | 30 | `/assets/shopee/AP_Boots_ALLBIKE_2_MERAH_Sepatu_Bike_PVC/hero_AP_Boots_ALLBIKE_2_MERAH_Sepatu_Bike_PVC.webp` | APPROVED |
| `MST-050` | `APB-002` | AP Boots | AP Boots 2017 GREEN LIME | `07_Classic_Boots` | `8997234000505` | `6401.92.00` | EU 38 - 43 | Rp 118,050 | $5.09 | 12 | 25 | `/assets/shopee/AP_Boots_2017_GREEN_LIME_Sepatu_Boot_PVC/hero_AP_Boots_2017_GREEN_LIME_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-051` | `APB-003` | AP Boots | AP Boots 2017 Green | `07_Classic_Boots` | `8997234000512` | `6401.92.00` | EU 38 - 43 | Rp 118,050 | $5.09 | 12 | 30 | `/assets/shopee/AP_Boots_2017_GREEN_LIME_Sepatu_Boot_PVC/hero_AP_Boots_2017_GREEN_LIME_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-052` | `APB-004` | AP Boots | AP Boots 2005 ROOTS N LEAVES | `07_Classic_Boots` | `8997234000529` | `6401.92.00` | EU 37 - 42 | Rp 90,175 | $3.88 | 12 | 20 | `/assets/shopee/AP_Boots_2005_ROOTS_N_LEAVES_Sepatu_Boot_PVC/hero_AP_Boots_2005_ROOTS_N_LEAVES_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-053` | `APB-005` | AP Boots | AP Boots 2005 Hijau | `07_Classic_Boots` | `8997234000536` | `6401.92.00` | EU 38 - 43 | Rp 71,050 | $3.06 | 12 | 25 | `/assets/shopee/AP_Boots_2005_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_2005_Hijau_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-054` | `APB-006` | AP Boots | AP Boots 2003 Hijau TRICOLOUR | `07_Classic_Boots` | `8997234000543` | `6401.92.00` | EU 38 - 43 | Rp 148,499 | $6.40 | 12 | 13 | `/assets/shopee/AP_Boots_2003_Hijau_TRICOLOUR_Sepatu_Boot_PVC/hero_AP_Boots_2003_Hijau_TRICOLOUR_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-055` | `APB-012` | AP Boots | AP Boots 2017 Tosca | `07_Classic_Boots` | `8997234000550` | `6401.92.00` | EU 38 - 43 | Rp 117,383 | $5.06 | 12 | 27 | `/assets/shopee/AP_Boots_2017_Tosca_Sepatu_Boot_PVC/hero_AP_Boots_2017_Tosca_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-056` | `APB-014` | AP Boots | AP Boots AP 969 Putih Cream | `10_Kasual_Sneakers` | `8997234000567` | `6402.19.00` | EU 38 - 43 | Rp 44,433 | $1.91 | 12 | 12 | `/assets/shopee/AP_Boots_AP_969_Putih_Cream_Sepatu_Bola_PVC/hero_AP_Boots_AP_969_Putih_Cream_Sepatu_Bola_PVC.webp` | APPROVED |
| `MST-057` | `APB-020` | AP Boots | AP Boots XT Hijau | `07_Classic_Boots` | `8997234000574` | `6401.92.00` | EU 38 - 43 | Rp 144,900 | $6.24 | 12 | 2 | `/assets/shopee/AP_Boots_XT_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_XT_Hijau_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-058` | `APB-028` | AP Boots | AP Boots 9506 Hijau | `07_Classic_Boots` | `8997234000581` | `6401.92.00` | EU 38 - 43 | Rp 147,845 | $6.37 | 12 | 12 | `/assets/shopee/AP_Boots_9506_Sepatu_Boot_PVC/hero_AP_Boots_9506_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-059` | `APB-031` | AP Boots | AP Boots AP 963 Putih | `10_Kasual_Sneakers` | `8997234000598` | `6402.19.00` | EU 38 - 43 | Rp 38,125 | $1.64 | 12 | 26 | `/assets/shopee/AP_Boots_AP_963_Putih_Sepatu_Bola_PVC/hero_AP_Boots_AP_963_Putih_Sepatu_Bola_PVC.webp` | APPROVED |
| `MST-060` | `APB-032` | AP Boots | AP Boots AP 1 Hitam | `07_Classic_Boots` | `8997234000604` | `6401.92.00` | EU 38 - 44 | Rp 85,000 | $3.66 | 12 | 2 | `/assets/shopee/Ap_Boots_1001_HITAM_Sandal_Selop/hero_Ap_Boots_1001_HITAM_Sandal_Selop.webp` | APPROVED |
| `MST-061` | `APB-033` | AP Boots | AP Boots AP 1 Putih | `07_Classic_Boots` | `8997234000611` | `6401.92.00` | EU 38 - 43 | Rp 85,000 | $3.66 | 12 | 2 | `/assets/shopee/AP_Boots_AP_1_Putih_Sepatu_Boots_PVC/hero_AP_Boots_AP_1_Putih_Sepatu_Boots_PVC.webp` | APPROVED |
| `MST-062` | `APB-034` | AP Boots | AP Boots 9303 | `07_Classic_Boots` | `8997234000628` | `6401.92.00` | EU 38 - 43 | Rp 131,550 | $5.67 | 12 | 14 | `/assets/shopee/AP_Boots_9303_Sepatu_Boot_PVC/hero_AP_Boots_9303_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-063` | `APB-039` | AP Boots | AP Boots AP 977 Hitam | `10_Kasual_Sneakers` | `8997234000635` | `6402.99.90` | EU 38 - 43 | Rp 56,525 | $2.43 | 12 | 13 | `/assets/shopee/AP_Boots_AP_977_Hitam_Sepatu_Pantofel_PVC/hero_AP_Boots_AP_977_Hitam_Sepatu_Pantofel_PVC.webp` | APPROVED |
| `MST-064` | `APB-045` | AP Boots | AP Boots AP 2011 Hijau | `07_Classic_Boots` | `8997234000642` | `6401.92.00` | EU 38 - 43 | Rp 90,175 | $3.88 | 12 | 18 | `/assets/shopee/AP_Boots_AP_2011_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_AP_2011_Hijau_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-065` | `APB-062` | AP Boots | AP Boots 2018 Ultraflex Biru | `07_Classic_Boots` | `8997234000659` | `6401.92.00` | EU 38 - 43 | Rp 187,566 | $8.08 | 12 | 16 | `/assets/shopee/AP_Boots_2018_Ultraflex_Biru_Sepatu_Boot_PVC/hero_AP_Boots_2018_Ultraflex_Biru_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-066` | `APB-077` | AP Boots | Ap Boots AP 3 BLACK | `07_Classic_Boots` | `8997234000666` | `6401.92.00` | EU 38 - 44 | Rp 85,000 | $3.66 | 12 | 2 | `/assets/shopee/Ap_Boots_AP_3_BLACK_Sepatu_Boots_PVC/hero_Ap_Boots_AP_3_BLACK_Sepatu_Boots_PVC.webp` | APPROVED |
| `MST-067` | `APB-078` | AP Boots | Ap Boots 9905 HITAM | `07_Classic_Boots` | `8997234000673` | `6401.92.00` | EU 38 - 43 | Rp 116,066 | $5.00 | 12 | 14 | `/assets/shopee/Ap_Boots_9905_HITAM_Sepatu_Boots_PVC/hero_Ap_Boots_9905_HITAM_Sepatu_Boots_PVC.webp` | APPROVED |
| `MST-068` | `APB-082` | AP Boots | AP Boots AP 963 Cream | `10_Kasual_Sneakers` | `8997234000680` | `6402.19.00` | EU 38 - 43 | Rp 38,500 | $1.66 | 12 | 22 | `/assets/shopee/AP_Boots_AP_963_Cream_Sepatu_Bola_PVC/hero_AP_Boots_AP_963_Cream_Sepatu_Bola_PVC.webp` | APPROVED |
| `MST-069` | `APB-086` | AP Boots | AP Boots AP 967 Hitam | `10_Kasual_Sneakers` | `8997234000697` | `6402.19.00` | EU 38 - 43 | Rp 39,900 | $1.72 | 12 | 16 | `/assets/shopee/AP_Boots_AP_967_Hitam_Sepatu_Bola_PVC/hero_AP_Boots_AP_967_Hitam_Sepatu_Bola_PVC.webp` | APPROVED |
| `MST-070` | `APB-091` | AP Boots | AP Boots 2015 Ultimate Abu | `07_Classic_Boots` | `8997234000703` | `6401.92.00` | EU 38 - 43 | Rp 162,999 | $7.02 | 12 | 14 | `/assets/shopee/AP_Boots_2015_Ultimate_Abu_Sepatu_Boot_PVC/hero_AP_Boots_2015_Ultimate_Abu_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-071` | `APB-092` | AP Boots | AP Boots 2015 Ultimate Hitam | `07_Classic_Boots` | `8997234000710` | `6401.92.00` | EU 38 - 43 | Rp 169,133 | $7.29 | 12 | 12 | `/assets/shopee/AP_Boots_2015_Ultimate_Hitam_Sepatu_PVC/hero_AP_Boots_2015_Ultimate_Hitam_Sepatu_PVC.webp` | APPROVED |
| `MST-072` | `APB-093` | AP Boots | AP Boots 2015 Ultimate Hijau | `07_Classic_Boots` | `8997234000727` | `6401.92.00` | EU 38 - 43 | Rp 169,133 | $7.29 | 12 | 14 | `/assets/shopee/AP_Boots_2015_Ultimate_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_2015_Ultimate_Hijau_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-073` | `APB-094` | AP Boots | AP Boots 2015 Ultimate Orange | `07_Classic_Boots` | `8997234000734` | `6401.92.00` | EU 38 - 43 | Rp 169,133 | $7.29 | 12 | 12 | `/assets/shopee/AP_Boots_2015_Ultimate_Orange_Sepatu_Boot_PVC/hero_AP_Boots_2015_Ultimate_Orange_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-074` | `APB-100` | AP Boots | AP Boots 2018 Ultraflex Abu | `07_Classic_Boots` | `8997234000741` | `6401.92.00` | EU 38 - 43 | Rp 187,566 | $8.08 | 12 | 16 | `/assets/shopee/AP_Boots_2018_Ultraflex_Abu_Sepatu_Boot_PVC/hero_AP_Boots_2018_Ultraflex_Abu_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-075` | `APB-101` | AP Boots | AP Boots 2018 Ultraflex Hijau | `07_Classic_Boots` | `8997234000758` | `6401.92.00` | EU 38 - 43 | Rp 187,566 | $8.08 | 12 | 16 | `/assets/shopee/AP_Boots_2018_Ultraflex_Hijau_Sepatu_Boot_PVC/hero_AP_Boots_2018_Ultraflex_Hijau_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-076` | `APB-102` | AP Boots | AP Boots 2007 | `07_Classic_Boots` | `8997234000765` | `6401.92.00` | EU 38 - 43 | Rp 98,766 | $4.25 | 12 | 7 | `/assets/shopee/AP_Boots_2007_Sepatu_Boot_PVC/hero_AP_Boots_2007_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-077` | `APB-103` | AP Boots | AP Boots 2006 | `07_Classic_Boots` | `8997234000772` | `6401.92.00` | EU 38 - 43 | Rp 164,666 | $7.09 | 12 | 9 | `/assets/shopee/AP_Boots_2006_Sepatu_Boot_PVC/hero_AP_Boots_2006_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-078` | `APB-017` | AP Boots | AP KIDS 2012 MERAH STABILO | `08_Kids_Boots` | `8997234000789` | `6401.92.00` | EU 28 - 35 | Rp 68,566 | $2.95 | 12 | 26 | `/assets/shopee/AP_Boots_AP_KIDS_2012_MERAH_STABILO_MULTI_SIZE_BESAR_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_MERAH_STABILO_MULTI_SIZE_BESAR_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-079` | `APB-018` | AP Boots | AP KIDS 2012 HIJAU STABILO | `08_Kids_Boots` | `8997234000796` | `6401.92.00` | EU 28 - 35 | Rp 68,566 | $2.95 | 12 | 26 | `/assets/shopee/AP_Boots_AP_KIDS_2012_MERAH_STABILO_MULTI_SIZE_BESAR_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_MERAH_STABILO_MULTI_SIZE_BESAR_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-080` | `APB-019` | AP Boots | AP KIDS 2012 UNGU STABILO | `08_Kids_Boots` | `8997234000802` | `6401.92.00` | EU 28 - 35 | Rp 68,566 | $2.95 | 12 | 26 | `/assets/shopee/AP_Boots_AP_KIDS_2012_UNGU_STABILO_MULTI_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_UNGU_STABILO_MULTI_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-081` | `APB-042` | AP Boots | AP KIDS SAFARI ELEPHANT | `08_Kids_Boots` | `8997234000819` | `6401.92.00` | EU 26 - 32 | Rp 59,566 | $2.57 | 12 | 15 | `/assets/shopee/AP_Boots_AP_KIDS_SAFARI_ELEPHANT_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_SAFARI_ELEPHANT_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-082` | `APB-043` | AP Boots | AP KIDS SAFARI ZEBRA | `08_Kids_Boots` | `8997234000826` | `6401.92.00` | EU 26 - 32 | Rp 59,566 | $2.57 | 12 | 17 | `/assets/shopee/AP_Boots_AP_KIDS_SAFARI_ZEBRA_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_SAFARI_ZEBRA_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-083` | `APB-044` | AP Boots | AP KIDS SAFARI CROCODILE | `08_Kids_Boots` | `8997234000833` | `6401.92.00` | EU 26 - 32 | Rp 59,566 | $2.57 | 12 | 17 | `/assets/shopee/AP_Boots_AP_KIDS_SAFARI_CROCODILE_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_SAFARI_CROCODILE_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-084` | `APB-049` | AP Boots | AP KIDS 2012 LEMON POLKADOT | `08_Kids_Boots` | `8997234000840` | `6401.92.00` | EU 27 - 34 | Rp 65,425 | $2.82 | 12 | 35 | `/assets/shopee/AP_Boots_AP_KIDS_2012_LEMON_POLKADOT_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_LEMON_POLKADOT_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-085` | `APB-050` | AP Boots | AP KIDS 2012 MIXED BLACK FUXIA | `08_Kids_Boots` | `8997234000857` | `6401.92.00` | EU 28 - 35 | Rp 68,566 | $2.95 | 12 | 32 | `/assets/shopee/AP_Boots_AP_KIDS_2012_MIXED_BLACK_FUXIA_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_MIXED_BLACK_FUXIA_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-086` | `APB-065` | AP Boots | AP KIDS 2012 BLUE JEANS | `08_Kids_Boots` | `8997234000864` | `6401.92.00` | EU 28 - 35 | Rp 68,566 | $2.95 | 12 | 38 | `/assets/shopee/AP_Boots_AP_KIDS_2012_BLUE_JEANS_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_BLUE_JEANS_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-087` | `APB-066` | AP Boots | AP KIDS 2012 VIOLET CIRCLE | `08_Kids_Boots` | `8997234000871` | `6401.92.00` | EU 28 - 35 | Rp 61,900 | $2.67 | 12 | 39 | `/assets/shopee/AP_Boots_AP_KIDS_2012_BLUE_JEANS_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_BLUE_JEANS_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-088` | `APB-067` | AP Boots | AP KIDS 2012 FUXIA STRIPE | `08_Kids_Boots` | `8997234000888` | `6401.92.00` | EU 28 - 35 | Rp 68,566 | $2.95 | 12 | 32 | `/assets/shopee/AP_Boots_AP_KIDS_2012_MIXED_BLACK_FUXIA_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_MIXED_BLACK_FUXIA_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-089` | `APB-068` | AP Boots | AP KIDS 2012 UNGU STABILO MULTI | `08_Kids_Boots` | `8997234000895` | `6401.92.00` | EU 28 - 35 | Rp 68,566 | $2.95 | 12 | 26 | `/assets/shopee/AP_Boots_AP_KIDS_2012_UNGU_STABILO_MULTI_Sepatu_Boot_PVC/hero_AP_Boots_AP_KIDS_2012_UNGU_STABILO_MULTI_Sepatu_Boot_PVC.webp` | APPROVED |
| `MST-090` | `APB-079` | AP Boots | AP BOOTS 2001 HIJAU | `08_Kids_Boots` | `8997234000901` | `6401.92.00` | EU 26 - 33 | Rp 72,825 | $3.14 | 12 | 12 | `/assets/shopee/Sepatu_Boot_Anak_AP_BOOTS_2001_HIJAU_Sepatu_Boot_Karet/hero_Sepatu_Boot_Anak_AP_BOOTS_2001_HIJAU_Sepatu_Boot_Karet.webp` | APPROVED |
| `MST-091` | `APB-011` | AP Boots | AP CLOGS Ladies Pink Cream | `09_Sandals_Clogs` | `8997234000918` | `6402.20.00` | EU 36 - 40 | Rp 54,066 | $2.33 | 24 | 7 | `/assets/shopee/AP_Boots_AP_CLOGS_Ladies_Pink_Cream_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Ladies_Pink_Cream_Sepatu_Slip_On_PVC.webp` | APPROVED |
| `MST-092` | `APB-046` | AP Boots | AP CLOGS Hitam | `09_Sandals_Clogs` | `8997234000925` | `6402.20.00` | EU 39 - 43 | Rp 67,400 | $2.90 | 24 | 2 | `/assets/shopee/AP_Boots_AP_CLOGS_Hitam_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Hitam_Sepatu_Slip_On_PVC.webp` | APPROVED |
| `MST-093` | `APB-047` | AP Boots | AP CLOGS COKLAT | `09_Sandals_Clogs` | `8997234000932` | `6402.20.00` | EU 39 - 43 | Rp 67,400 | $2.90 | 24 | 2 | `/assets/shopee/AP_Boots_AP_CLOGS_COKLAT_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_COKLAT_Sepatu_Slip_On_PVC.webp` | APPROVED |
| `MST-094` | `APB-048` | AP Boots | AP CLOGS Navy | `09_Sandals_Clogs` | `8997234000949` | `6402.20.00` | EU 39 - 43 | Rp 67,400 | $2.90 | 24 | 2 | `/assets/shopee/AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC.webp` | APPROVED |
| `MST-095` | `APB-056` | AP Boots | AP CLOGS Putih Krem | `09_Sandals_Clogs` | `8997234000956` | `6402.20.00` | EU 36 - 41 | Rp 47,400 | $2.04 | 24 | 10 | `/assets/shopee/AP_Boots_AP_CLOGS_Putih_Krem_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Putih_Krem_Sepatu_Slip_On_PVC.webp` | APPROVED |
| `MST-096` | `APB-057` | AP Boots | AP CLOGS Putih Abu | `09_Sandals_Clogs` | `8997234000963` | `6402.20.00` | EU 36 - 42 | Rp 54,066 | $2.33 | 24 | 10 | `/assets/shopee/AP_Boots_AP_CLOGS_Putih_Abu_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Putih_Abu_Sepatu_Slip_On_PVC.webp` | APPROVED |
| `MST-097` | `APB-058` | AP Boots | AP CLOGS Putih Merah | `09_Sandals_Clogs` | `8997234000970` | `6402.20.00` | EU 36 - 42 | Rp 47,400 | $2.04 | 24 | 10 | `/assets/shopee/AP_Boots_AP_CLOGS_Putih_Merah_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Putih_Merah_Sepatu_Slip_On_PVC.webp` | APPROVED |
| `MST-098` | `APB-059` | AP Boots | AP CLOGS Putih Navy | `09_Sandals_Clogs` | `8997234000987` | `6402.20.00` | EU 36 - 42 | Rp 47,400 | $2.04 | 24 | 10 | `/assets/shopee/AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC/hero_AP_Boots_AP_CLOGS_Putih_Navy_Sepatu_Slip_On_PVC.webp` | APPROVED |
| `MST-099` | `APB-084` | AP Boots | Ap Boots 1001 HITAM | `09_Sandals_Clogs` | `8997234000994` | `6402.20.00` | EU 38 - 43 | Rp 37,674 | $1.62 | 24 | 14 | `/assets/shopee/Ap_Boots_1001_HITAM_Sandal_Selop/hero_Ap_Boots_1001_HITAM_Sandal_Selop.webp` | APPROVED |
| `MST-100` | `APB-085` | AP Boots | Ap Boots 991 Hitam | `09_Sandals_Clogs` | `8997234001007` | `6402.20.00` | EU 38 - 43 | Rp 36,933 | $1.59 | 24 | 7 | `/assets/shopee/Ap_Boots_991_Hitam_Sandal_Selop/hero_Ap_Boots_991_Hitam_Sandal_Selop.webp` | APPROVED |
| `MST-101` | `APB-087` | AP Boots | Ap Boots 989 Hitam | `09_Sandals_Clogs` | `8997234001014` | `6402.20.00` | EU 38 - 43 | Rp 36,933 | $1.59 | 24 | 9 | `/assets/shopee/Ap_Boots_989_Hitam_Sandal_Selop/hero_Ap_Boots_989_Hitam_Sandal_Selop.webp` | APPROVED |
| `MST-102` | `APB-088` | AP Boots | Ap Boots 995 Hitam (V1) | `09_Sandals_Clogs` | `8997234001021` | `6402.20.00` | EU 38 - 43 | Rp 36,933 | $1.59 | 24 | 12 | `/assets/shopee/Ap_Boots_995_Hitam_Sandal_Selop/hero_Ap_Boots_995_Hitam_Sandal_Selop.webp` | APPROVED |
| `MST-103` | `APB-089` | AP Boots | Ap Boots 999 Hitam | `09_Sandals_Clogs` | `8997234001038` | `6402.20.00` | EU 38 - 43 | Rp 44,100 | $1.90 | 24 | 11 | `/assets/shopee/Ap_Boots_999_Hitam_Sandal_Selop/hero_Ap_Boots_999_Hitam_Sandal_Selop.webp` | APPROVED |
| `MST-104` | `APB-090` | AP Boots | Ap Boots 995 Hitam (V2) | `09_Sandals_Clogs` | `8997234001045` | `6402.20.00` | EU 38 - 43 | Rp 36,933 | $1.59 | 24 | 12 | `/assets/shopee/Ap_Boots_995_Hitam_Sandal_Selop/hero_Ap_Boots_995_Hitam_Sandal_Selop.webp` | APPROVED |
| `MST-105` | `APB-054` | AP Boots | AP STAR Hitam Putih | `10_Kasual_Sneakers` | `8997234001052` | `6402.99.90` | EU 38 - 43 | Rp 50,566 | $2.18 | 12 | 12 | `/assets/shopee/AP_Boots_AP_STAR_Hitam_Putih_Sepatu_Kets_PVC/hero_AP_Boots_AP_STAR_Hitam_Putih_Sepatu_Kets_PVC.webp` | APPROVED |
| `MST-106` | `APB-055` | AP Boots | AP STAR Hitam Hitam | `10_Kasual_Sneakers` | `8997234001069` | `6402.99.90` | EU 38 - 43 | Rp 70,900 | $3.05 | 12 | 2 | `/assets/shopee/AP_Boots_AP_STAR_Hitam_Hitam_Sepatu_Kets_PVC/hero_AP_Boots_AP_STAR_Hitam_Hitam_Sepatu_Kets_PVC.webp` | APPROVED |
| `MST-107` | `PTR-001` | Petrova | Petrova Sepatu Boots Nelayan Yellow PVC Steel Toe Cap Anti Static | `01_Safety_Boots` | `8997234001076` | `6401.10.00` | EU 38 - 45 | Rp 239,000 | $10.30 | 10 | 5 | `/assets/shopee/Petrova_Sepatu_Boots_Nelayan_Yellow_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Nelayan_Yellow_PVC_Steel_Toe_Cap_Anti_Static.webp` | APPROVED |
| `MST-108` | `PTR-002` | Petrova | Petrova Sepatu Boots Phenom Yellow PVC Steel Toe Cap Anti Static | `01_Safety_Boots` | `8997234001083` | `6401.10.00` | EU 38 - 45 | Rp 177,000 | $7.62 | 10 | 5 | `/assets/shopee/Petrova_Sepatu_Boots_Phenom_Yellow_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Phenom_Yellow_PVC_Steel_Toe_Cap_Anti_Static.webp` | APPROVED |
| `MST-109` | `PTR-003` | Petrova | Petrova Sepatu Boots Phenom Yellow Size 39 PVC Steel Toe Cap Anti Static | `01_Safety_Boots` | `8997234001090` | `6401.10.00` | EU 38 - 45 | Rp 177,000 | $7.62 | 10 | 5 | `/assets/shopee/Petrova_Sepatu_Boots_Phenom_Yellow_Size_39_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Phenom_Yellow_Size_39_PVC_Steel_Toe_Cap_Anti_Static.webp` | APPROVED |
| `MST-110` | `PTR-004` | Petrova | Petrova Sepatu Boots Strength WB Biru Boots Air PVC | `01_Safety_Boots` | `8997234001106` | `6401.10.00` | EU 38 - 45 | Rp 110,000 | $4.74 | 10 | 5 | `/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_Biru_Boots_Air_PVC/hero_Petrova_Sepatu_Boots_Strength_WB_Biru_Boots_Air_PVC.webp` | APPROVED |
| `MST-111` | `PTR-005` | Petrova | Petrova Sepatu Boots Strength WB Hijau Boots Air PVC | `01_Safety_Boots` | `8997234001113` | `6401.10.00` | EU 38 - 45 | Rp 110,000 | $4.74 | 10 | 5 | `/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_Hijau_Boots_Air_PVC/hero_Petrova_Sepatu_Boots_Strength_WB_Hijau_Boots_Air_PVC.webp` | APPROVED |
| `MST-112` | `PTR-006` | Petrova | Petrova Sepatu Boots Strength WB Hitam Boots Air PVC | `01_Safety_Boots` | `8997234001120` | `6401.10.00` | EU 38 - 45 | Rp 77,500 | $3.34 | 10 | 5 | `/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_Hitam_Boots_Air_PVC/hero_Petrova_Sepatu_Boots_Strength_WB_Hitam_Boots_Air_PVC.webp` | APPROVED |
| `MST-113` | `PTR-007` | Petrova | Petrova Sepatu Boots Strength WB Kuning Boots Air PVC | `01_Safety_Boots` | `8997234001137` | `6401.10.00` | EU 38 - 45 | Rp 95,000 | $4.09 | 10 | 5 | `/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_Kuning_Boots_Air_PVC/hero_Petrova_Sepatu_Boots_Strength_WB_Kuning_Boots_Air_PVC.webp` | APPROVED |
| `MST-114` | `PTR-008` | Petrova | Petrova Sepatu Boots Strength WB orange Boots Air PVC | `01_Safety_Boots` | `8997234001144` | `6401.10.00` | EU 38 - 45 | Rp 110,000 | $4.74 | 10 | 5 | `/assets/shopee/Petrova_Sepatu_Boots_Strength_WB_orange_Boots_Air_PVC/hero_Petrova_Sepatu_Boots_Strength_WB_orange_Boots_Air_PVC.webp` | APPROVED |
| `MST-115` | `PTR-009` | Petrova | Petrova Sepatu Boots Tinggi Safety ERGOS kuning Steel Toe PVC | `01_Safety_Boots` | `8997234001151` | `6401.10.00` | EU 38 - 45 | Rp 167,000 | $7.19 | 10 | 5 | `/assets/shopee/Petrova_Sepatu_Boots_Tinggi_Safety_ERGOS_kuning_Steel_Toe_PVC/hero_Petrova_Sepatu_Boots_Tinggi_Safety_ERGOS_kuning_Steel_Toe_PVC.webp` | APPROVED |
| `MST-116` | `PTR-010` | Petrova | Petrova Sepatu Boots Ultimate Yellow PVC Steel Toe Cap Anti Static | `01_Safety_Boots` | `8997234001168` | `6401.10.00` | EU 38 - 45 | Rp 216,500 | $9.33 | 10 | 5 | `/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_PVC_Steel_Toe_Cap_Anti_Static.webp` | APPROVED |
| `MST-117` | `PTR-011` | Petrova | Petrova Sepatu Boots Ultimate Yellow Size 38 PVC Steel Toe Cap Anti Static | `01_Safety_Boots` | `8997234001175` | `6401.10.00` | EU 38 - 45 | Rp 216,500 | $9.33 | 10 | 5 | `/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_38_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_38_PVC_Steel_Toe_Cap_Anti_Static.webp` | APPROVED |
| `MST-118` | `PTR-012` | Petrova | Petrova Sepatu Boots Ultimate Yellow Size 39 PVC Steel Toe Cap Anti Static | `01_Safety_Boots` | `8997234001182` | `6401.10.00` | EU 38 - 45 | Rp 216,500 | $9.33 | 10 | 5 | `/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_39_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_39_PVC_Steel_Toe_Cap_Anti_Static.webp` | APPROVED |
| `MST-119` | `PTR-013` | Petrova | Petrova Sepatu Boots Ultimate Yellow Size 40 PVC Steel Toe Cap Anti Static | `01_Safety_Boots` | `8997234001199` | `6401.10.00` | EU 38 - 45 | Rp 216,500 | $9.33 | 10 | 5 | `/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_40_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_40_PVC_Steel_Toe_Cap_Anti_Static.webp` | APPROVED |
| `MST-120` | `PTR-014` | Petrova | Petrova Sepatu Boots Ultimate Yellow Size 41 PVC Steel Toe Cap Anti Static | `01_Safety_Boots` | `8997234001205` | `6401.10.00` | EU 38 - 45 | Rp 216,500 | $9.33 | 10 | 5 | `/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_41_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_41_PVC_Steel_Toe_Cap_Anti_Static.webp` | APPROVED |
| `MST-121` | `PTR-015` | Petrova | Petrova Sepatu Boots Ultimate Yellow Size 43 PVC Steel Toe Cap Anti Static | `01_Safety_Boots` | `8997234001212` | `6401.10.00` | EU 38 - 45 | Rp 216,500 | $9.33 | 10 | 5 | `/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_43_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_43_PVC_Steel_Toe_Cap_Anti_Static.webp` | APPROVED |
| `MST-122` | `PTR-016` | Petrova | Petrova Sepatu Boots Ultimate Yellow Size 44 PVC Steel Toe Cap Anti Static | `01_Safety_Boots` | `8997234001229` | `6401.10.00` | EU 38 - 45 | Rp 216,500 | $9.33 | 10 | 5 | `/assets/shopee/Petrova_Sepatu_Boots_Ultimate_Yellow_Size_44_PVC_Steel_Toe_Cap_Anti_Static/hero_Petrova_Sepatu_Boots_Ultimate_Yellow_Size_44_PVC_Steel_Toe_Cap_Anti_Static.webp` | APPROVED |
| `MST-123` | `PTR-017` | Petrova | Petrova Sepatu Boots Tinggi PETROVA Classic Hitam Boots PVC Lentur Lokal | `01_Safety_Boots` | `8997234001236` | `6401.10.00` | EU 38 - 45 | Rp 140,000 | $6.03 | 10 | 5 | `/assets/shopee/Sepatu_Boots_Tinggi_PETROVA_Classic_Hitam_Boots_PVC_Lentur_Lokal/hero_Sepatu_Boots_Tinggi_PETROVA_Classic_Hitam_Boots_PVC_Lentur_Lokal.webp` | APPROVED |
| `MST-124` | `PTR-018` | Petrova | Petrova Sepatu Boots Tinggi PETROVA Pro Green Boots Karet Lentur Lokal Anti Slip & Air Ringan perkebunan | `01_Safety_Boots` | `8997234001243` | `6401.10.00` | EU 38 - 45 | Rp 90,000 | $3.88 | 10 | 5 | `/assets/shopee/Sepatu_Boots_Tinggi_PETROVA_Pro_Green_Boots_Karet_Lentur_Lokal_Anti_Slip_&_Air_Ringan_perkebunan/hero_Sepatu_Boots_Tinggi_PETROVA_Pro_Green_Boots_Karet_Lentur_Lokal_Anti_Slip_&_Air_Ringan_perkebunan.webp` | APPROVED |
| `MST-125` | `PTR-019` | Petrova | Petrova Sepatu Boots Tinggi Safety  STRENGTH kuning Steel Toe PVC | `01_Safety_Boots` | `8997234001250` | `6401.10.00` | EU 38 - 45 | Rp 161,000 | $6.94 | 10 | 5 | `/assets/shopee/Sepatu_Boots_Tinggi_Safety_Petrova_STRENGTH_kuning_Steel_Toe_PVC/hero_Sepatu_Boots_Tinggi_Safety_Petrova_STRENGTH_kuning_Steel_Toe_PVC.webp` | APPROVED |

---

## 8. Ringkasan Data Tabel Pendukung (`alibaba_master.db` & `padi_umkm_master.db`)

### A. Sebaran `marketplace_raw` (491 Baris)
| Source | Jumlah Baris | Rata-Rata Harga (IDR) |
| :--- | ---: | ---: |
| blibli | 173 | Rp 106,801 |
| shopee | 125 | Rp 134,697 |
| lazada | 106 | Rp 129,204 |
| tokopedia | 87 | Rp 89,690 |

### B. Sebaran `alibaba_matrix_800` (810 Baris)
| Target Industry Angle | Jumlah Listing |
| :--- | ---: |
| Wholesale OEM Supply | 81 |
| Oil & Gas Refinery | 81 |
| Motorcycle & Courier | 81 |
| Mining & Quarrying | 81 |
| Medical & Kitchen Hygiene | 81 |
| Fishery & Seafood | 81 |
| Civil Construction | 81 |
| Chemical & Factory Manufacturing | 81 |
| All-Weather Rain Utility | 81 |
| Agriculture & Farming | 81 |

### C. Sebaran Sumber Foto `product_reference_images` (2.034 Baris)
| Source Flag | Flag Label | Jumlah Foto |
| :--- | :--- | ---: |
| `TOKOPEDIA_LOCAL` | `[TOKOPEDIA LOKAL]` | 835 |
| `TOKOPEDIA` | `[TOKOPEDIA ONLINE]` | 654 |
| `SHOPEE` | `[SHOPEE]` | 250 |
| `BLIBLI` | `[BLIBLI]` | 156 |
| `LAZADA` | `[LAZADA]` | 84 |
| `PHOTOBANK` | `[PHOTOBANK]` | 55 |

### D. Data Lengkap `padi_umkm_master.db` — Tabel `padi_products` (76 Baris)
| ID | Batch | Kode SKU | Nama Produk | Kategori | Harga (IDR) | Min Order | TKDN (%) | Status |
| ---: | ---: | :--- | :--- | :--- | ---: | ---: | ---: | :--- |
| 1 | 1 | `APB-056` | AP CLOGS ( WARNA) - Black; White; Blue; Grey; Brown | `661` | Rp 50,000 | 1 | - | Ready |
| 2 | 1 | `APB-056` | AP CLOGS ( WHITE, PINK ) - White; Pink | `661` | Rp 51,000 | 1 | - | Ready |
| 3 | 1 | `APB-105` | AP ALLBIKE BLACK - RED/GREEN/ORANGE - Black; Green; Red; Orange; Red S | `2450` | Rp 61,000 | 1 | - | Ready |
| 4 | 1 | `APB-069` | AP ALLBIKE GREY - BLACK - Black; Black Sole; Grey | `2450` | Rp 61,000 | 1 | - | Ready |
| 5 | 1 | `APB-070` | AP ALLBIKE 2 BLACK - RED/GREEN/ORANGE - Black; Green; Red; Orange; Red | `2450` | Rp 61,000 | 1 | - | Ready |
| 6 | 1 | `APB-070` | AP ALLBIKE 2 GREY - BLACK - Black; Black Sole; Grey | `2450` | Rp 61,000 | 1 | - | Ready |
| 7 | 1 | `APB-077` | AP BLACK ( I ) - Black | `2450` | Rp 64,000 | 1 | - | Ready |
| 8 | 1 | `APB-077` | AP WHITE ( I ) - White | `2450` | Rp 75,000 | 1 | - | Ready |
| 9 | 1 | `APB-077` | AP BLACK ( II ) - Black | `2450` | Rp 75,000 | 1 | - | Ready |
| 10 | 1 | `APB-077` | AP BLACK ( III ) & (V) - Black | `2450` | Rp 67,000 | 1 | - | Ready |
| 11 | 1 | `APB-005` | AP Boots 2005 GREEN - Green | `2450` | Rp 61,000 | 1 | - | Ready |
| 12 | 1 | `APB-004` | AP Boots 2005 + MOTIF - Pattern | `2450` | Rp 80,000 | 1 | - | Ready |
| 13 | 1 | `APB-102` | AP Boots 2007 GREEN - Green | `2450` | Rp 80,000 | 1 | - | Ready |
| 14 | 1 | `APB-045` | AP Boots 2011 GREEN - Green | `2450` | Rp 80,000 | 1 | - | Ready |
| 15 | 1 | `APB-002` | AP Boots 2017 GREEN - Green | `2450` | Rp 102,000 | 1 | - | Ready |
| 16 | 1 | `APB-002` | AP Boots 2017 GREEN LIME/TOSCA - Green; Lime Green; Teal | `2450` | Rp 103,000 | 1 | - | Ready |
| 17 | 1 | `APB-078` | AP Boots 9905 BLACK - Black; Black Sole | `2450` | Rp 99,000 | 1 | - | Ready |
| 18 | 1 | `APB-097` | AP MOTO (I) BLACK / RED - Black; Red; Red Sole | `2450` | Rp 110,000 | 1 | - | Ready |
| 19 | 1 | `APB-098` | AP MOTO (II) BLACK / RED - Black; Red; Red Sole | `2450` | Rp 116,000 | 1 | - | Ready |
| 20 | 1 | `APB-099` | AP MOTO (III) BLACK / RED - Black; Red; Red Sole | `2450` | Rp 121,000 | 1 | - | Ready |
| 21 | 2 | `APB-017` | AP Boots 9303 GREEN - Green | `2450` | Rp 113,000 | 1 | - | Ready |
| 22 | 2 | `APB-017` | AP Boots 9303 GREEN - Green | `2450` | Rp 114,000 | 1 | - | Ready |
| 23 | 2 | `APB-025` | AP XT - Green | `2450` | Rp 113,000 | 1 | - | Ready |
| 24 | 2 | `APB-028` | AP Boots 9506 GREEN - Green | `2450` | Rp 127,000 | 1 | - | Ready |
| 25 | 2 | `APB-006` | AP Boots 2003 GREEN - Green; Multi Color | `2450` | Rp 132,000 | 1 | - | Ready |
| 26 | 2 | `APB-103` | AP Boots 2006 GREEN - Green; Multi Color | `2450` | Rp 134,000 | 1 | - | Ready |
| 27 | 2 | `APB-091` | AP Boots 2015 GREEN/GREY/ORANGE/BLACK - Black; Green; Grey; Orange; Mu | `2450` | Rp 138,000 | 1 | - | Ready |
| 28 | 2 | `APB-062` | AP Boots 2018 ULTRAFLEX GREEN/GREY/BLUE - Green; Blue; Grey; Multi Col | `2450` | Rp 154,000 | 1 | - | Ready |
| 29 | 2 | `APB-081` | AP Boots TERRA SAFETY S4 YELLOW - Yellow | `2450` | Rp 242,000 | 1 | - | Ready |
| 30 | 2 | `APB-074` | AP METAGUARD YELLOW - Yellow | `2450` | Rp 253,000 | 1 | - | Ready |
| 31 | 2 | `APB-073` | AP BOOTS SAFETY S5 YELLOW - Yellow | `2450` | Rp 275,000 | 1 | - | Ready |
| 32 | 2 | `APB-073` | AP BOOTS SAFETY S5 BLACK - Black | `2450` | Rp 275,000 | 1 | - | Ready |
| 33 | 2 | `APB-073` | AP BOOTS SAFETY S5 YELLOW - Yellow | `2450` | Rp 281,000 | 1 | - | Ready |
| 34 | 2 | `APB-033` | AP MAX BLACK/GREY - Black | `2450` | Rp 297,000 | 1 | - | Ready |
| 35 | 2 | `APB-033` | AP MAX BROWN/BLACK - Black | `2450` | Rp 297,000 | 1 | - | Ready |
| 36 | 2 | `APB-007` | AP Boots TERRA ECO 1 BL - Black | `2450` | Rp 62,000 | 1 | - | Ready |
| 37 | 2 | `APB-040` | AP Boots TERRA ECO 2 BL - Black | `2450` | Rp 72,000 | 1 | - | Ready |
| 38 | 2 | `APB-007` | AP Boots TERRA ECO 3 BL - Black | `2450` | Rp 92,000 | 1 | - | Ready |
| 39 | 2 | `APB-007` | AP Boots TERRA ECO 3 GR/YL/OR - Green; Orange | `2450` | Rp 98,000 | 1 | - | Ready |
| 40 | 2 | `APB-076` | AP Boots TERRA ECO 5 GR - Green | `2450` | Rp 72,000 | 1 | - | Ready |
| 41 | 3 | `APB-076` | AP Boots TERRA ECO 5 WH - White | `2450` | Rp 83,000 | 1 | - | Ready |
| 42 | 3 | `APB-076` | AP Boots TERRA 5 GR - Green | `2450` | Rp 105,000 | 1 | - | Ready |
| 43 | 3 | `APB-041` | AP Boots TERRA 3 BL/YL - Black; Yellow | `2450` | Rp 99,000 | 1 | - | Ready |
| 44 | 3 | `APB-041` | AP Boots TERRA 3 GR - RED - Green; Red; Red Sole | `2450` | Rp 106,000 | 1 | - | Ready |
| 45 | 3 | `APB-075` | AP Boots TERRA 2 GR - Green | `2450` | Rp 107,000 | 1 | - | Ready |
| 46 | 3 | `APB-007` | AP Boots TERRA GR/WH/YL - White; Green; Yellow | `2450` | Rp 113,000 | 1 | - | Ready |
| 47 | 3 | `APB-052` | AP Boots TERRA ARMY - ARMY PANJANG | `2450` | Rp 132,000 | 1 | - | Ready |
| 48 | 3 | `APB-053` | AP Boots TERRA FOREST - FOREST PANJANG | `2450` | Rp 132,000 | 1 | - | Ready |
| 49 | 3 | `APB-083` | AP Boots TERRA GP BLACK - Black | `2450` | Rp 64,000 | 1 | - | Ready |
| 50 | 3 | `APB-083` | AP Boots TERRA GP GREEN - Green | `2450` | Rp 75,000 | 1 | - | Ready |
| 51 | 3 | `APB-038` | AP CHEF BLACK/WHITE - Black; White | `2450` | Rp 219,000 | 1 | - | Ready |
| 52 | 3 | `APB-036` | AP MEDIC BLACK/BLUE/GREEN/WHITE - Black; White; Green; Blue | `2450` | Rp 299,000 | 1 | - | Ready |
| 53 | 3 | `APB-027` | AP Boots ORCA GR - Green | `2450` | Rp 90,000 | 1 | - | Ready |
| 54 | 3 | `APB-049` | AP KIDS MULTI - Multi Color | `519` | Rp 41,000 | 1 | - | Ready |
| 55 | 3 | `APB-049` | AP KIDS STABILLO - Multi Color | `519` | Rp 43,000 | 1 | - | Ready |
| 56 | 3 | `APB-049` | AP Boots 9307 W - ANAK-ANAK KECIL | `519` | Rp 42,000 | 1 | - | Ready |
| 57 | 3 | `APB-049` | AP Boots GRANDPRIX - ANAK-ANAK KECIL | `519` | Rp 43,000 | 1 | - | Ready |
| 58 | 3 | `APB-001` | AP Boots 9309 W - Multi Color | `519` | Rp 47,000 | 1 | - | Ready |
| 59 | 3 | `APB-049` | AP Boots 2001 W - Multi Color | `519` | Rp 64,000 | 1 | - | Ready |
| 60 | 3 | `APB-001` | AP Boots 2001 GR - Green | `519` | Rp 66,000 | 1 | - | Ready |
| 61 | 4 | `APB-001` | AP Boots 2001 ROOT N LEAVES - ROOT N LEAVES TANGGUNG PENDEK | `519` | Rp 83,000 | 1 | - | Ready |
| 62 | 4 | `APB-042` | AP SAFARI - PATTERN BINATANG UNTUK ANAK-ANAK KECIL | `519` | Rp 61,000 | 1 | - | Ready |
| 63 | 4 | `APB-049` | AP JASMINE - PATTERN BONEKA UNTUK ANAK-ANAK KECIL | `519` | Rp 61,000 | 1 | - | Ready |
| 64 | 4 | `APB-086` | AP Boots 961 / 967 BL - Black | `2450` | Rp 237,000 | 1 | - | Ready |
| 65 | 4 | `APB-082` | AP Boots 963 BL - Black | `2450` | Rp 226,000 | 1 | - | Ready |
| 66 | 4 | `APB-082` | AP Boots 963 / 965 WH - White | `2450` | Rp 390,000 | 1 | - | Ready |
| 67 | 4 | `APB-082` | AP Boots 963 WH - White | `2450` | Rp 352,000 | 1 | - | Ready |
| 68 | 4 | `APB-082` | AP Boots 963 CR - Cream | `2450` | Rp 396,000 | 1 | - | Ready |
| 69 | 4 | `APB-086` | AP Boots 969 WH - White; Multi Color | `2450` | Rp 429,000 | 1 | - | Ready |
| 70 | 4 | `APB-086` | AP Boots 969 BL - Black; Multi Color | `2450` | Rp 341,000 | 1 | - | Ready |
| 71 | 4 | `APB-085` | AP Boots 985 BL - Black | `660` | Rp 237,000 | 1 | - | Ready |
| 72 | 4 | `APB-084` | AP Boots 987/989 /991/995/997/1001 BL - Black | `660` | Rp 237,000 | 1 | - | Ready |
| 73 | 4 | `APB-088` | AP Boots 999 BL - Black | `660` | Rp 259,000 | 1 | - | Ready |
| 74 | 4 | `APB-039` | AP Boots 977 BL - Black | `660` | Rp 292,000 | 1 | - | Ready |
| 75 | 4 | `APB-084` | AP Boots 1003 BL - Black | `660` | Rp 292,000 | 1 | - | Ready |
| 76 | 4 | `APB-077` | AP Boots HOBBY & WORK BLACK/RED - Black; Red | `2450` | Rp 72,000 | 1 | - | Ready |
