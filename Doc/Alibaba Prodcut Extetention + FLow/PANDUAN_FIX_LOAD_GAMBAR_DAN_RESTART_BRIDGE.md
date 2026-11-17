# Panduan Perbaikan Load Gambar Lokal & Restart Bridge (:8888)

Dokumen ini merangkum temuan penyebab gambar gagal dimuat pada panel Chrome Extension serta langkah cepat untuk mengaktifkan versi terbaru saat Anda siap melanjutkan.

---

## 1. Penyebab Gambar Gagal Dimuat (Hasil Pemeriksaan Nyata)

1. **Proses Server Lama Masih Menempati Port `8888` (PID `6956`):**
   * Saat dilakukan pengecekan langsung ke `http://127.0.0.1:8888/api/ext/categories`, server yang sedang aktif mengembalikan `HTTP 404: Endpoint not found`, dan `MST-029 (AP Chef Hitam)` masih terbaca `03_Orca_Series`.
   * Artinya, proses Python lama (`PID 6956`) masih berjalan di background sehingga kode baru di [`App/extension_bridge.py`](file:///d:/Work/Hots/Product%20Input/App/extension_bridge.py) dan [`App/alibaba_manager_app.py`](file:///d:/Work/Hots/Product%20Input/App/alibaba_manager_app.py) belum terpakai.
2. **Blokir Mixed Content / CSP pada Halaman HTTPS (`flow.google.com` & `i.alibaba.com`):**
   * Browser memblokir `<img src="http://localhost:8888/...">` secara langsung di dalam halaman HTTPS, sehingga kotak thumbnail tampil putih.
   * **Sudah diperbaiki** di [`Chrome_Extension/content_overlay.js`](file:///d:/Work/Hots/Product%20Input/Chrome_Extension/content_overlay.js) dan [`Chrome_Extension/background.js`](file:///d:/Work/Hots/Product%20Input/Chrome_Extension/background.js): thumbnail kini diambil lewat Service Worker (`BRIDGE_FETCH_IMAGE_BASE64` dengan `encodeURI` dan fallback `127.0.0.1:8888` → `localhost:8888`) lalu diubah menjadi `Blob` URL lokal halaman (`URL.createObjectURL`).

---

## 2. Langkah Mengaktifkan Perbaikan (Saat Siap Dilanjutkan)

1. **Hentikan Server `:8888` yang Lama:**
   * Tutup jendela terminal/CMD **HOTS Local Bridge 8888** yang masih terbuka, **atau** hentikan lewat Task Manager / Command Prompt:
     ```cmd
     taskkill /F /PID 6956
     ```
2. **Jalankan Ulang Launcher Lokal:**
   * Double-click [`run_alibaba_extension_flow.bat`](file:///d:/Work/Hots/Product%20Input/run_alibaba_extension_flow.bat) agar server `:8888` menyala dengan kode terbaru.
3. **Reload Ekstensi & Refresh Tab Chrome (`Profile 7` / `aufahots@gmail.com`):**
   * Buka `chrome://extensions/` → klik **Reload (`↻`)** pada **HOTS Trading — Alibaba Auto-Fill, Photobank & Google Flow Bridge**.
   * Tekan `F5` pada tab `flow.google.com` / `i.alibaba.com`.

---

## 3. Checklist Verifikasi Setelah Restart

* [ ] Buka `http://localhost:8888/api/ext/categories` → harus tampil JSON berisi 11 kategori resmi (bukan 404).
* [ ] Pilih `MST-029 (AP Chef Hitam)` di panel ekstensi → Grup berubah menjadi **`04_Chef_Series`** (dan `MST-080` menjadi **`08_Kids_Boots`**).
* [ ] Thumbnail foto lokal tampil di kotak preview panel ekstensi dan siap disuntikkan ke `publish-plan` atau Google Flow.
