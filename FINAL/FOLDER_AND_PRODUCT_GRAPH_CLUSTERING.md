# 🕸️ DOKUMENTASI GRAPHIFY & KLASTERISASI FOLDER / PRODUK
**AP BOOTS® & PETROVA — UNIFIED MASTER PRODUCT CATALOG**  
*PT Indo Sukses Semesta — HOTS Trading*  
**Visual Knowledge Graph & Folder Architecture**

---

## 📌 1. Ikhtisar Klasterisasi Knowledge Graph

Sesuai permintaan Anda untuk melakukan **graphify dan pengelompokan folder serta produk yang sesuai**, sistem telah memetakan seluruh aset, folder kerja, dan 125 produk master ke dalam arsitektur **Knowledge Graph** berbasis hubungan entitas (Entity-Relationship & Community Detection).

File visualisasi interaktif Graphify dapat langsung Anda buka di peramban:
👉 **[`FINAL/graphify-out/graph.html`](file:///d:/Work/Hots/Product%20Input/FINAL/graphify-out/graph.html)**  
*(Atau via server lokal di `http://localhost:8899/graphify-out/graph.html`)*

```mermaid
graph TD
    subgraph Cluster_1["🏢 KLASTER 1: MASTER PRODUCTION CORE (FINAL/)"]
        FINAL_DB[("master_products_consolidated.db<br/>(SQLite Database)")]
        FINAL_SQL["master_products_database.sql<br/>(Universal SQL Script)"]
        FINAL_XLSX["master_products_complete_detailed.xlsx<br/>(4-Sheet Excel Workbook)"]
        FINAL_XLSM["master_products_complete_detailed.xlsm<br/>(Macro-Ready Excel)"]
        FINAL_JSON["master_products_catalog.json<br/>(125 SKU Full Data)"]
        FINAL_UI["index.html<br/>(Master Web UI)"]
        FINAL_SRV["server_final.py<br/>(Dedicated Server 8899)"]
    end

    subgraph Cluster_2["🛒 KLASTER 2: MULTI-MARKETPLACE RAW INGESTION"]
        RAW_SHP["Shopee_Product_Assets/<br/>(124 Folders, Hero/Side WebP)"]
        RAW_TOK["Images_Tokopedia/<br/>(468 Tokopedia CDN Photos)"]
        RAW_DB["Database/alibaba_master.db<br/>(marketplace_raw 491 rows)"]
        RAW_INP["Input/<br/>(Raw Excel/CSV Ingestion)"]
    end

    subgraph Cluster_3["🎨 KLASTER 3: B2B PHOTOBANK & AI STUDIO SYNTHESIS"]
        PB_SLOTS["Output/Photobank_Siap_Upload/<br/>(10 Kategori, 518 Slot WebP)"]
        PB_GEN["photobank generator/<br/>(Generator Engine)"]
        PB_FLOW["Flow/ & Image Flow/<br/>(Google Flow Bundles)"]
    end

    subgraph Cluster_4["🌐 KLASTER 4: WEB APPLICATION & REST APIS"]
        APP_SRV["App/alibaba_manager_app.py<br/>(Main App Server 8888)"]
        APP_UI["App/template.html<br/>(Main Management UI)"]
        APP_API["App/api_docs.py<br/>(REST API Explorer & OpenAPI)"]
        APP_BRIDGE["App/photobank_api_bridge.py<br/>(OpenAI & Photoroom Bridge)"]
    end

    subgraph Cluster_5["📚 KLASTER 5: KNOWLEDGE BASE & COMPLIANCE"]
        DOC_106["Doc/KATALOG_REFERENSI_106_SKU.md<br/>(Whitepaper Standar Mutu)"]
        DOC_GPSR["Doc/GPSR_Batch_Compliance.md<br/>(EU 2023/988 Compliance)"]
        DOC_PRM["Doc/ALIBABA_LISTING_MASTER_PROMPT.md<br/>(B2B Prompting Rules)"]
    end

    %% Hubungan Alur Data (Data Flow & Edges)
    RAW_SHP -->|"Konsolidasi & Ekstraksi"| FINAL_JSON
    RAW_TOK -->|"Mapping Foto Marketplace"| FINAL_JSON
    RAW_DB -->|"Konsolidasi Harga & SKU"| FINAL_JSON
    DOC_106 -->|"Buku Putih Spesifikasi Teknis"| FINAL_JSON
    PB_SLOTS -->|"Registri 4-Slot Studio"| FINAL_JSON

    FINAL_JSON -->|"Generator Database"| FINAL_SQL
    FINAL_JSON -->|"Kompilasi SQLite"| FINAL_DB
    FINAL_JSON -->|"Spreadsheet Komprehensif"| FINAL_XLSX
    FINAL_JSON -->|"Format Makro"| FINAL_XLSM
    FINAL_JSON -->|"Render Front-End"| FINAL_UI
    FINAL_SRV -->|"Serve Web & Aset"| FINAL_UI
```

---

## 🥾 2. Klasterisasi 125 Produk Master (11 Strategic Communities)

Seluruh 125 Master SKU resmi dikelompokkan ke dalam **11 Komunitas Produk (Category Clusters)** sesuai karakteristik fungsional, material, dan standar K3:

| Klaster # | Nama Komunitas / Kategori | Total SKU | Standar K3 / Proteksi | Target Industri Vertikal | Kode HS | Rekomendasi Ekspor |
|---|---|---|---|---|---|---|
| **Klaster 1** | **AP Safety Boots** | 7 SKU | Steel Toe Cap 200J, EN ISO 20345 S5 | Tambang Batubara, Migas, Proyek Sipil, Pabrik Kimia | `6401.10.00` | Eropa, Amerika Utara, Australia |
| **Klaster 2** | **AP Terra Series** | 19 SKU | Sol Traktor Anti-Selip Lumpur | Perkebunan Kelapa Sawit, Sawah Padi, Kehutanan | `6401.92.00` | ASEAN, Afrika, Amerika Latin |
| **Klaster 3** | **AP Orca Series** | 1 SKU | Shaft Ekstra Tinggi (40 cm), Anti Air Asin | Perikanan Laut Dalam, Cold Storage, Galangan Kapal | `6401.92.00` | Oseania, Pasifik, Skandinavia |
| **Klaster 4** | **AP Chef Series** | 3 SKU | Ergonomis, Anti-Fatigue, Sol SRC Minyak | Dapur Komersial HORECA, Bakery, Restoran Cepat Saji | `6402.99.10` | Timur Tengah, Eropa, Singapura |
| **Klaster 5** | **AP Medic Series** | 7 SKU | Polimer Higienis Antiseptik, Mudah Sterilisasi | Rumah Sakit, Lab Klinis, Farmasi, Cleanroom | `6402.99.10` | Timur Tengah, Afrika, Asia Pasifik |
| **Klaster 6** | **AP Biker & Casual** | 12 SKU | Pelindung Mata Kaki, Ringan, Tahan Hujan | Kurir Logistik, Pengendara Motor Harian, Touring | `6401.92.00` | ASEAN, Amerika Latin |
| **Klaster 7** | **AP Classic Boots** | 28 SKU | Virgin PVC 100% Kedap Air, Awet | Banjir Musiman, Dinas Sanitasi Kota, Selokan/Got | `6401.92.00` | Global (Wilayah Tropis & Sub-Tropis) |
| **Klaster 8** | **AP Kids Boots** | 13 SKU | Bebas Phthalate Berbahaya, Warna Cerah | Anak Sekolah Musim Hujan, Aktivitas Taman | `6401.92.00` | Eropa Timur, Asia, Amerika Latin |
| **Klaster 9** | **AP Sandals & Clogs** | 14 SKU | Ultra-Light EVA/PVC, Sol Datar Anti-Slip | Kolam Renang, Kasir Supermarket, Santai Harian | `6402.99.10` | Timur Tengah, Afrika, Domestik |
| **Klaster 10** | **AP Kasual Sneakers** | 2 SKU | Tampilan Kasual Modern, 100% Tahan Air | Pekerja Lapangan Santai, Komuter Hujan Modis | `6402.91.10` | ASEAN, Jepang, Korea Selatan |
| **Klaster 11** | **Petrova Heavy Duty Safety** | 19 SKU | Steel Toe Cap 200J + Steel Midsole Plate | Tambang Terbuka, Galangan Kapal, Pengecoran Baja | `6401.10.00` | Australia, Timur Tengah, Afrika |

---

## 🗄️ 3. Skema Database Relasional SQL & Re-Identifikasi ("Identifikasi Kembali")

Untuk memastikan data dapat Anda masukkan langsung ke sistem SQL Anda dan mudah diidentifikasi kembali (`identifikasi kembali`), database relasional telah dinormalisasi menjadi **4 tabel terpadu + 1 view denormalized**:

```mermaid
erDiagram
    master_categories ||--o{ master_products : "memiliki"
    master_products ||--o{ product_marketplace_crossref : "dipetakan ke"
    master_products ||--o{ product_reference_images : "memiliki foto"

    master_categories {
        int category_id PK
        string category_code UK
        string category_name
        string category_group
        string hs_code_default
        text target_industry
    }

    master_products {
        int id PK
        string master_sku UK "MST-001 s/d MST-125"
        string original_sku "APB-xxx / PTR-xxx"
        string barcode_ean13 UK "Standar GS1 13 Digit"
        string brand "AP Boots / Petrova"
        string model_name
        int category_id FK
        string color
        string material_upper
        string material_outsole
        decimal shaft_height_cm
        int weight_per_pair_g
        string steel_toe_cap
        string slip_resistance_rating
        int price_retail_avg_idr
        int price_wholesale_idr
        decimal price_fob_usd
        int pairs_per_carton
        decimal carton_volume_cbm
        text description_id "Deskripsi Lengkap Bahasa Indonesia"
        text description_en "Full Export Description in English"
        string primary_image_url
        int total_reference_images
    }

    product_marketplace_crossref {
        int id PK
        int product_id FK
        string master_sku
        string original_sku
        string barcode_ean13
        string shopee_folder "Folder di Shopee_Product_Assets"
        string shopee_sku "SHP-xxx"
        string tokopedia_id "TOK-xxx"
        string blibli_id "BLI-xxx"
        string lazada_id "LZD-xxx"
        string alibaba_matrix_sku "ALB-MAT-xxx"
        string hots_system_sku "HOTS-xxx"
    }

    product_reference_images {
        int id PK
        int product_id FK
        string master_sku
        string source_flag "[SHOPEE], [TOKOPEDIA], dll"
        string flag_color "Hex Color Code"
        string image_title
        string image_type "Hero 1:1, Side, Tread, Contextual"
        text image_url
        int is_primary
    }
```

### Keunggulan untuk "Identifikasi Kembali" di Sistem SQL Anda:
1. **Pencarian Cepat dengan Barcode EAN-13:**  
   Setiap produk memiliki barcode GS1 resmi 13-digit yang dihitung menggunakan algoritma check digit resmi (contoh: `8997234000017`). Sistem kasir, scanner gudang, atau ERP dapat langsung memindai produk.
2. **Tabel Cross-Reference Multi-Marketplace:**  
   Tabel `product_marketplace_crossref` menyimpan mapping ID produk di Tokopedia, Shopee, Blibli, Lazada, Alibaba, dan folder aset internal, sehingga sistem Anda dapat melakukan `JOIN` atau sync otomatis kapan saja tanpa risiko duplikasi data.
3. **View `v_master_products_full`:**  
   Cukup jalankan satu query:
   ```sql
   SELECT * FROM v_master_products_full WHERE master_sku = 'MST-001';
   ```
   Seluruh data kategori, spesifikasi, harga, crossref ID, dan deskripsi lengkap langsung tersaji dalam 1 baris.

---

## 💻 4. Panduan Eksekusi SQL di Sistem Anda

File SQL produksi siap impor tersedia di:
👉 [**`FINAL/master_products_database.sql`**](file:///d:/Work/Hots/Product%20Input/FINAL/master_products_database.sql)  
*(Juga disalin ke [`Database/master_products_database.sql`](file:///d:/Work/Hots/Product%20Input/Database/master_products_database.sql))*

### Cara Impor ke MySQL / MariaDB:
```bash
mysql -u username -p database_anda < "d:/Work/Hots/Product Input/FINAL/master_products_database.sql"
```

### Cara Impor ke PostgreSQL:
```bash
psql -U username -d database_anda -f "d:/Work/Hots/Product Input/FINAL/master_products_database.sql"
```

### Cara Impor ke SQLite:
```bash
sqlite3 database_anda.db < "d:/Work/Hots/Product Input/FINAL/master_products_database.sql"
```
*(Database SQLite mandiri yang sudah terisi dan teruji juga sudah siap digunakan langsung di [`FINAL/master_products_consolidated.db`](file:///d:/Work/Hots/Product%20Input/FINAL/master_products_consolidated.db))*

---

## 📊 5. Format Excel & Macro-Ready (.xlsx & .xlsm)

Selain SQL, tersedia file spreadsheet yang lengkap dengan seluruh kolom teknis dan deskripsi:
1. **[`FINAL/master_products_complete_detailed.xlsx`](file:///d:/Work/Hots/Product%20Input/FINAL/master_products_complete_detailed.xlsx)**  
   Workbook Excel komprehensif berformat profesional dengan 4 sheet terpisah (Master Products Complete, Crossref & SQL Identification, Flagged Reference Images, Pricing & Container Logistics).
2. **[`FINAL/master_products_complete_detailed.xlsm`](file:///d:/Work/Hots/Product%20Input/FINAL/master_products_complete_detailed.xlsm)**  
   Workbook format makro (*Macro-Ready*) sesuai permintaan Anda untuk kebutuhan integrasi otomatis ke piranti kerja atau otomasi spreadsheet perusahaan.
3. **[`FINAL/master_products_complete_detailed.csv`](file:///d:/Work/Hots/Product%20Input/FINAL/master_products_complete_detailed.csv)**  
   File flat CSV universal siap pakai.

