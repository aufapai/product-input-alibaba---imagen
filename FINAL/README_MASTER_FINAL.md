# 👑 AP BOOTS® & PETROVA — UNIFIED MASTER PRODUCT CATALOG (FINAL)
**PT Indo Sukses Semesta — HOTS Trading**  
*Single Source of Truth • 0 Duplicate Guarantee • Multi-Source Flagged Reference Images*

---

## 📌 1. Ringkasan & Tujuan Sistem FINAL

Sistem pada direktori `FINAL/` ini dibangun khusus untuk memenuhi kebutuhan standarisasi data produk master:
1. **Bebas Duplikasi (0 Duplikat):** Mengkonsolidasikan seluruh SKU dan database marketplace yang berserakan (Shopee, Tokopedia, Blibli, Lazada, Alibaba Master, HOTS SQL) menjadi tepat **125 Master SKU resmi**:
   * **106 SKU AP Boots Indonesia** (Sesuai buku putih [`Doc/KATALOG_REFERENSI_PRODUK_MASTER_106_SKU.md`](file:///d:/Work/Hots/Product%20Input/Doc/KATALOG_REFERENSI_PRODUK_MASTER_106_SKU.md))
   * **19 SKU Petrova Heavy Duty Safety** (Varian boots industri berat dengan steel toe cap 200J)
2. **Koleksi Foto Berbagai Sumber Berlabel (Source Flag):** Setiap produk mengumpulkan seluruh aset foto dari beragam platform dan menandainya dengan **Source Flag** warna khusus sebagai referensi visual visualisasi B2B ekspor:
   * 🟠 **`🏷️ [SHOPEE]`**: Foto studio resmi 1:1 square berlatar putih bersih (hero & side view).
   * 🟣 **`🏷️ [PHOTOBANK]`**: Foto render 4-slot studio B2B (Hero, 90° Side Profile, Outsole Tread Cleats, Contextual In-Use).
   * 🟢 **`🏷️ [TOKOPEDIA]`**: Foto listing marketplace terverifikasi dari Official Store Tokopedia.
   * 🔵 **`🏷️ [BLIBLI]`**: Foto etalase e-commerce Blibli.
   * 🔷 **`🏷️ [LAZADA]`**: Foto listing resmi Lazada Flagship Store.
   * 🟡 **`🏷️ [ALIBABA]`**: Foto verifikasi ekspor 6-sudut.
   * 🟢 **`🏷️ [AI_GEN]`**: Foto studio sintetis hasil AI (OpenAI DALL-E 3 / Google AI Studio).
3. **Total Registri Referensi Visual:** Tercatat **1.199 foto referensi multi-sumber** yang terpetakan secara presisi ke masing-masing 125 produk.

---

## 🚀 2. Cara Menjalankan Aplikasi (Satu Kali Klik)

Tersedia skrip otomatis `.bat` yang dapat langsung Anda klik:

### Pilihan A: Dari Root Folder
Klik dua kali file:
👉 [`start_master_final.bat`](file:///d:/Work/Hots/Product%20Input/start_master_final.bat)

### Pilihan B: Dari Folder `FINAL/`
Klik dua kali file:
👉 [`FINAL/JALANKAN_MASTER_FINAL.bat`](file:///d:/Work/Hots/Product%20Input/FINAL/JALANKAN_MASTER_FINAL.bat)

Skrip ini akan secara otomatis:
1. Memverifikasi Python di sistem Anda.
2. Menjalankan pipeline konsolidasi data [`FINAL/consolidate_master.py`](file:///d:/Work/Hots/Product%20Input/FINAL/consolidate_master.py) untuk memastikan database master selalu up-to-date.
3. Membuka peramban (browser) Anda langsung ke alamat:  
   👉 **`http://localhost:8899`**
4. Menjalankan server HTTP dedicated [`FINAL/server_final.py`](file:///d:/Work/Hots/Product%20Input/FINAL/server_final.py).

---

## 📂 3. Struktur File pada Folder `FINAL/`

```text
FINAL/
├── JALANKAN_MASTER_FINAL.bat     # Launcher otomatis 1-klik
├── consolidate_master.py        # Mesin konsolidasi data & penghilang duplikat
├── server_final.py              # Server web HTTP port 8899 dengan routing aset
├── index.html                   # Halaman web dashboard master katalog interaktif
├── master_products_catalog.json # Dataset master lengkap format JSON (125 SKU)
├── master_products_catalog.xlsx # Workbook Excel berformat profesional (4 Sheet)
├── master_products_catalog.csv  # Flat CSV universal untuk import ERP / Database
└── README_MASTER_FINAL.md       # Dokumentasi panduan operasional (file ini)
```

---

## 📊 4. Spesifikasi Workbook Excel (`master_products_catalog.xlsx`)

File Excel [`FINAL/master_products_catalog.xlsx`](file:///d:/Work/Hots/Product%20Input/FINAL/master_products_catalog.xlsx) telah diformat secara elegan dengan 4 sheet terpisah:
1. **Sheet 1: `Master Catalog (125 SKU)`**  
   Daftar 125 produk tunggal tanpa duplikasi, mencakup Master SKU (`MST-001` s/d `MST-125`), SKU Asli, Brand, Nama Model, Kategori, Material Upper/Outsole, Fitur Keamanan, Ukuran, Harga Ritel Rata-Rata, Harga FOB Ekspor (USD), dan Tautan Foto Utama.
2. **Sheet 2: `Price Comparison Matrix`**  
   Tabel komparasi harga langsung antara Shopee vs Tokopedia vs Blibli vs Lazada vs Rata-rata Pasar vs Ekspor USD.
3. **Sheet 3: `Reference Images Registry`**  
   Registri lengkap seluruh 1.199 foto berlabel flag (`[SHOPEE]`, `[TOKOPEDIA]`, `[PHOTOBANK]`, dll.), deskripsi tipe foto, dan URL aksesnya.
4. **Sheet 4: `Logistics & Container Specs`**  
   Standar kemasan karton ekspor, berat kotor (Gross Weight), kubikasi CBM (0.096 m³), estimasi muatan kontainer 20ft (3.600 pasang), dan kontainer 40ft HQ (8.500 pasang).

---

## 🌐 5. Fitur Halaman Web Baru (`http://localhost:8899`)

* **Pencarian Instan:** Ketik nama produk, model number, warna, atau fitur (contoh: `terra`, `s5`, `chef`, `allbike`, `petrova`) untuk filter waktu-nyata tanpa reload.
* **Filter Kategori & Brand:** Dropdown 11 kategori produk dan tombol pemilih brand (AP Boots / Petrova).
* **Filter Sumber Foto:** Tombol pill untuk menampilkan hanya produk yang memiliki foto dari sumber tertentu (contoh: klik tombol `🏷️ [PHOTOBANK]` untuk melihat produk yang siap aset 4-slot studio).
* **Mode Tampilan:** Pilihan antara **Grid Card View** (tampilan kartu visual modern) atau **Tabel Data** (tampilan spreadsheet lengkap).
* **Modal Galeri Referensi Multi-Sumber:** Mengklik tombol *"🖼️ Galeri Referensi"* pada kartu produk akan membuka modal pop-up yang menyajikan seluruh foto produk tersebut dari semua platform secara berdampingan lengkap dengan tag flag warna masing-masing, tombol salin URL, dan tombol perbesar.
* **Unduh Data Satu Klik:** Tombol di bagian atas untuk mengunduh Master Excel, JSON, atau CSV secara langsung.

---

> **Status Integrasi:** 100% Selesai & Terverifikasi  
> **Lisensi & Hak Cipta:** PT Indo Sukses Semesta / HOTS Trading © 2026

