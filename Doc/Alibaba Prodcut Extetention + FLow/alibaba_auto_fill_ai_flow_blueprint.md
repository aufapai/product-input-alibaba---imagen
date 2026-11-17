# Project Blueprint: Alibaba Accurate Auto-Fill, Freeze & AI Visual Flow

Dokumen ini berisi arsitektur teknis, pembagian fase pengerjaan, serta rincian tugas (*task breakdown*) untuk membangun sistem otomatisasi listing produk Alibaba berbasis **Chrome Extension (Manifest V3)** yang terhubung langsung dengan **Python Local Bridge**.

---

## 1. Tujuan Sistem
1. **Akurasi Data & Freeze Setting:** Mengatasi masalah *auto-bulk* bawaan Alibaba yang sering mereset harga, MOQ, dan konfigurasi atribut dengan mengunci (*freeze*) elemen DOM setelah diisi dari master dataset (Excel/CSV).
2. **Manajemen Foto Lokal & Photobank:** Mengunggah foto langsung dari folder lokal PC ke Alibaba Photobank sesuai grup/kategori folder menggunakan sesi login Chrome aktif.
3. **Integrasi Google Flow (Phase 2):** Otomatisasi pembuatan aset visual produk di tab `flow.google` menggunakan gambar referensi lokal sebelum diunggah ke Alibaba.

---

## 2. Arsitektur Teknis (Browser-Native)

Seluruh proses berjalan di dalam browser Google Chrome utama pengguna (tanpa *headless browser* eksternal) untuk menghindari blokir keamanan dan CAPTCHA.

```text
[Master Excel / CSV]
        │
        ▼
[Python Local Bridge (Flask - 127.0.0.1:5000)]
  ├── Validasi & Lock Data Harga/MOQ
  └── Menyajikan File Foto Lokal (Blob/Stream)
        │
        ▼ (Fetch API via Localhost)
[Chrome Extension (Manifest V3)]
  ├── Tab 1 (Phase 2): flow.google (Generate & Download Gambar)
  └── Tab 2 (Phase 1): post.alibaba.com (Photobank Upload + Auto-Fill + DOM Freeze)
```

---

## 3. Rincian Tugas Pengembangan (Task Breakdown)

### Phase 1: MVP — Upload Produk Akurat, Photobank & Freeze (Minggu 1 – 2)
*Fokus utama memastikan pengisian form produk dan penguncian harga berjalan 100% akurat tanpa ter-reset oleh skrip Alibaba.*

* **Task 1.1: Setup Python Local Bridge (`server.py`)**
  * [ ] Buat endpoint `GET /get-product/<row_index>` untuk membaca baris data dari file Excel (`pandas`).
  * [ ] Tambahkan logika validasi tipe data (angka harga, MOQ, string kategori) dan flag `lock: true`.
  * [ ] Buat endpoint `GET /get-image/<filename>` untuk mengirim file gambar dari folder lokal ke browser.
  * [ ] Konfigurasi `Flask-CORS` agar domain `*.alibaba.com` diizinkan mengakses `http://127.0.0.1:5000`.

* **Task 1.2: DOM Mapping Form Alibaba**
  * [ ] Identifikasi *selector* input standar: `Product Name`, `Keywords`, `Min. Order (MOQ)`, `Min/Max Price`.
  * [ ] Identifikasi struktur *Dynamic Category Attributes* (Brand, Model Number, Material, dll.) menggunakan `MutationObserver`.
  * [ ] Tangani *custom dropdown* non-`<select>` (simulasi klik trigger $\rightarrow$ tunggu list muncul $\rightarrow$ klik opsi yang cocok).

* **Task 1.3: Implementasi React Input Setter & Fitur Freeze**
  * [ ] Implementasikan `HTMLInputElement.prototype.value` setter + `Event('input', { bubbles: true })` agar *state* React Alibaba terbaca.
  * [ ] Bangun fungsi `freezeInput()` yang memantau perubahan nilai DOM setiap `400ms` selama halaman masih memuat AJAX, lalu mengembalikannya jika ter-reset.
  * [ ] Tambahkan indikator visual (border biru) pada field yang berstatus terkunci (*frozen*).

* **Task 1.4: Integrasi Upload Foto & Grup Photobank**
  * [ ] Gunakan `DataTransfer` API di `content.js` untuk menyuntikkan file gambar dari Python ke elemen `<input type="file">`.
  * [ ] Automasi pemilihan grup/folder di dalam modal **Alibaba Photobank** berdasarkan kolom `Photobank_Group` dari Excel.

---

### Phase 2: Integrasi Google Flow Agentic Visual (Minggu 3)
*Menambahkan otomatisasi pembuatan gambar di `flow.google` sebelum masuk ke pipeline Phase 1.*

* **Task 2.1: DOM Mapping `flow.google`**
  * [ ] Identifikasi tombol upload gambar referensi (*base image*), kolom input prompt, tombol *Generate*, dan tombol *Download*.
  * [ ] Tangani status *loading/generating* untuk mendeteksi kapan gambar selesai dirender.

* **Task 2.2: Otomatisasi Tab & Chrome Downloads API**
  * [ ] Gunakan `chrome.tabs` untuk membuka atau beralih ke tab `flow.google` secara otomatis.
  * [ ] Gunakan `chrome.downloads.onChanged` di `background.js` untuk mendeteksi saat hasil gambar selesai diunduh ke folder lokal.
  * [ ] Beri sinyal ke Python Bridge bahwa gambar baru siap digunakan untuk listing Alibaba.

---

### Phase 3: Batch Processing & Stabilisasi (Akhir Minggu 3)
* **Task 3.1: UI Overlay & Kontrol Antrean**
  * [ ] Tambahkan panel kontrol mengambang di halaman Alibaba (pilih baris Excel, tombol *Run Single*, tombol *Pause/Resume*, dan log status).
* **Task 3.2: Error Handling & Logging**
  * [ ] Catat status sukses/gagal per baris produk kembali ke file Excel/log lokal agar tidak terjadi duplikasi listing.
  * [ ] Tambahkan jeda acak (*human-like delay*) antar aksi untuk menjaga stabilitas sesi browser.

---

## 4. Struktur Template Dataset (`produk_alibaba.xlsx`)

| Kolom Excel | Tipe Data | Contoh Isi | Keterangan |
| :--- | :--- | :--- | :--- |
| `Product_Name` | String | `Custom Wireless Gaming Earbuds X15` | Judul utama produk |
| `Keyword_1` | String | `Wireless Earbuds` | Keyword pencarian 1 |
| `Keyword_2` | String | `Gaming TWS` | Keyword pencarian 2 |
| `Keyword_3` | String | `Bluetooth 5.3 Earphone` | Keyword pencarian 3 |
| `Category_Path` | String | `Consumer Electronics > Earbuds` | Path kategori Alibaba |
| `MOQ` | Integer | `50` | Minimum Order Quantity (Locked) |
| `Price_Min` | Float | `4.50` | Harga FOB terendah (Locked) |
| `Price_Max` | Float | `6.00` | Harga FOB tertinggi (Locked) |
| `Photobank_Group` | String | `Audio_Products_2026` | Nama folder grup di Photobank |
| `Image_Filename` | String | `tws_x15_main.jpg` | Nama file foto di folder lokal |
| `Flow_Prompt` | String | `Studio lighting, waterproof splash...` | Prompt untuk Phase 2 (Google Flow) |
| `Status` | String | `PENDING` / `DONE` | Status tracking otomatis |

---

## 5. Daftar Kebutuhan Teknis (Prerequisites)
* **Python 3.10+** dengan library: `flask`, `flask-cors`, `pandas`, `openpyxl`.
* **Google Chrome** (Developer Mode aktif di `chrome://extensions/`).
* Sesi akun **My Alibaba** dan **Google Flow** dalam keadaan sudah login di profil Chrome yang sama.