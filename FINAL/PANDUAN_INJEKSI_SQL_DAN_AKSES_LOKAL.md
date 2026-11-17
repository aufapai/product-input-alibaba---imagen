# Panduan Akses Lokal, Sinkronisasi Database, dan Injeksi SQL ke catalog.hotstrading.com
**PT Indo Sukses Semesta — HOTS Trading**
*Versi: 2.5 (November 2026)*

---

## 1. Ringkasan Fitur yang Telah Diterapkan

Sesuai permintaan Anda, seluruh kebutuhan integrasi telah selesai dikerjakan secara tuntas:

1. **Akses Offline Foto Lokal Tokopedia (468 Foto 1600x1600)**:
   - 468 foto resolusi tinggi dari folder `Images_Tokopedia/` (102 folder seri) telah diindeks dan dihubungkan secara otomatis ke 125 Master SKU.
   - Foto dapat diakses langsung secara lokal/offline melalui routing `/assets/tokopedia/...` tanpa bergantung pada koneksi internet atau link CDN Tokopedia yang memiliki token kedaluwarsa.
   - Diberi flag warna hijau: `[TOKOPEDIA LOKAL]`.

2. **Sinkronisasi Database Lokal (`Database/alibaba_master.db`)**:
   - Sebanyak 125 Master SKU resmi (106 AP Boots + 19 Petrova) telah disinkronkan ke dalam tabel `products` di `Database/alibaba_master.db`.
   - Tabel `master_products`, `product_reference_images` (2.034 foto multi-sumber), dan `product_marketplace_crossref` kini tersedia langsung di dalam database SQLite lokal tersebut.
   - View terpadu `v_master_products_full` siap digunakan untuk query instan.

3. **Skrip SQL Khusus untuk Live Website `catalog.hotstrading.com`**:
   - File baru: `FINAL/inject_catalog_hotstrading.sql` (juga di-mirror ke `Database/inject_catalog_hotstrading.sql`).
   - Dibuat khusus mengikuti struktur database produksi `hotj4796_hotstrading` (MariaDB / MySQL 10.11+).
   - Memasukkan data lengkap untuk 8 tabel:
     - `categories`: 11 Kategori alas kaki.
     - `manufacturers`: PT Indo Sukses Semesta (ID 1) & PT Waru Gunung Industry (ID 2).
     - `products`: 125 Produk dengan status `'APPROVED'`, deskripsi berformat B2B, harga FOB, spesifikasi, dan badges yang presisi seperti di kartu web `catalog.hotstrading.com`.
     - `product_specifications`: 1.875 baris spesifikasi teknis lengkap.
     - `product_use_cases`: 537 target aplikasi sektor industri.
     - `product_regions`: 625 target pasar ekspor global.
     - `product_certifications`: 401 data sertifikasi standar resmi (SNI, EN ISO 20345 S5, ISO 9001, GPSR EU).
     - `alibaba_export_listings`: 125 data listing ekspor lengkap dengan prompt AI 4-slot.

4. **Perbaikan Bug Error Console & Koneksi**:
   - Bug Javascript `pcError: Cannot set properties of null (setting 'innerText') at showToast` telah diperbaiki secara defensif dengan `try/catch` dan pemeriksaan elemen DOM yang aman.
   - Error `net::ERR_CONNECTION_REFUSED` pada aset Shopee/Photobank telah diatasi dengan penambahan handler statis lokal dan SVG fallback placeholder otomatis (`/assets/placeholder_boot.webp`).

---

## 2. Cara Menjalankan & Mengakses Secara Lokal

### Opsi A: Melalui Alibaba & Photobank Manager (`localhost:8888`)
1. Buka folder kerja dan jalankan:
   ```cmd
   start.bat
   ```
2. Aplikasi akan otomatis membuka browser di:
   - **Dashboard Utama**: [http://localhost:8888](http://localhost:8888)
   - **Master Catalog FINAL**: [http://localhost:8888/final](http://localhost:8888/final)
   - **Download SQL Injeksi Website**: [http://localhost:8888/inject_catalog_hotstrading.sql](http://localhost:8888/inject_catalog_hotstrading.sql)
   - **Download Master SQL Universal**: [http://localhost:8888/master_products_database.sql](http://localhost:8888/master_products_database.sql)

### Opsi B: Melalui Dedicated Master Final Server (`localhost:8899`)
1. Buka folder `FINAL` dan klik ganda:
   ```cmd
   JALANKAN_MASTER_FINAL.bat
   ```
2. Web UI Master Catalog akan terbuka di:
   - [http://localhost:8899](http://localhost:8899)
   - Terdapat tombol hijau baru di navigasi atas: **`⚡ SQL Live Catalog (.sql)`** untuk mengunduh skrip injeksi langsung sekali klik.

---

## 3. Panduan Injeksi SQL ke `catalog.hotstrading.com`

File skrip yang digunakan: `FINAL/inject_catalog_hotstrading.sql` (Ukuran: ~896 KB).

### Metode 1: Lewat phpMyAdmin cPanel (Paling Mudah)
1. Login ke cPanel hosting Anda di `hotstrading.com`.
2. Buka menu **phpMyAdmin**.
3. Di panel sebelah kiri, pilih database produksi: **`hotj4796_hotstrading`**.
4. Klik tab **Import** di bagian atas menu.
5. Pada bagian **File to import**, klik **Choose File** dan pilih file:
   `FINAL/inject_catalog_hotstrading.sql`
6. Pastikan opsi encoding **utf-8** terpilih.
7. Gulir ke bawah dan klik tombol **Import** / **Go**.
8. phpMyAdmin akan mengeksekusi skrip transaksi dan menampilkan pesan sukses berwarna hijau:
   `Import has been successfully finished, XXX queries executed.`

### Metode 2: Lewat SSH / MySQL Command Line Terminal
Jika Anda memiliki akses terminal SSH ke server:
```bash
mysql -u hotj4796_user -p hotj4796_hotstrading < inject_catalog_hotstrading.sql
```

### Keunggulan Skrip Injeksi Ini:
- **Idempoten (Aman Di-run Berulang Kali)**: Menggunakan `ON DUPLICATE KEY UPDATE` dan blok pembersihan awal khusus untuk SKU `MST-001` s/d `MST-125` (ID 2001 - 2125), sehingga tidak akan menduplikasi produk atau merusak data yang sudah ada sebelumnya.
- **Foreign Key Safe**: Menggunakan `SET FOREIGN_KEY_CHECKS = 0;` dan `START TRANSACTION; ... COMMIT;` untuk menjamin integritas data secara atomik.
- **Tampilan Kartu Sesuai Desain**:
  - Kolom `description` dan `badges` disesuaikan dengan kartu web `catalog.hotstrading.com` yang menampilkan:
    - *Compliance* (SNI, EN ISO 20345 S5, EVA/PVC)
    - *Key Spec* (200J Steel Toe, 150,000 Flex Cycles, Oil & Acid Resistant)
    - *Target Sectors* (Heavy Industry, Mining, Construction, Healthcare, HORECA)
    - *Packaging* (10/12/24 Pairs / Master Carton, m³, kg)
    - *Wholesale FOB Reference* ($ USD dan Rp Factory List)

---

## 4. Daftar File Utama dalam Proyek

| File Path | Deskripsi |
| :--- | :--- |
| `FINAL/inject_catalog_hotstrading.sql` | **Skrip SQL Utama** untuk injeksi ke `catalog.hotstrading.com` (`hotj4796_hotstrading`). |
| `Database/inject_catalog_hotstrading.sql` | Salinan mirror skrip injeksi di folder `Database/`. |
| `FINAL/generate_hotstrading_sql.py` | Generator otomatis pembuat skrip injeksi SQL dari master dataset. |
| `FINAL/master_products_consolidated.db` | Database SQLite master terpadu (125 produk, 2.034 foto berlabel). |
| `Database/alibaba_master.db` | Database SQLite lokal yang telah disinkronkan dengan 125 master produk. |
| `FINAL/master_products_complete_detailed.xlsx` | Excel Master 4-sheet lengkap dengan spesifikasi teknis dan deskripsi 2 bahasa. |
| `FINAL/master_products_complete_detailed.xlsm` | Excel Macro-enabled (.xlsm) untuk otomasi formula logistik. |
| `FINAL/master_products_catalog.json` | Master JSON API siap integrasi. |
| `Images_Tokopedia/` | 468 foto lokal Tokopedia dalam 102 folder seri, siap offline di `/assets/tokopedia/`. |
| `FINAL/JALANKAN_MASTER_FINAL.bat` | Batch script peluncur server port 8899 (bebas force close). |
| `start.bat` | Batch script peluncur server port 8888 (bebas force close). |

