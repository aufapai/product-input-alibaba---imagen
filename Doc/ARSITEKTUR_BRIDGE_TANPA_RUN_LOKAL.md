# Solusi Arsitektur Bridge: Agar Tidak Perlu Menjalankan Server Lokal Manual

Dokumen ini menjawab pertanyaan: *"Apakah server lokal (`localhost:8888`) bisa dijalankan dari dalam Chrome Extension, atau bagaimana solusi idealnya agar tidak perlu run manual secara lokal?"*

---

## 1. Mengapa Chrome Extension Tidak Bisa Menyalakan `python App/alibaba_manager_app.py` Secara Langsung?
Secara arsitektur keamanan browser (**Manifest V3 Sandbox**), Chrome Extension berjalan di dalam sandbox browser dan **tidak diizinkan** mengeksekusi perintah OS/terminal secara langsung (`python ...`, `.bat`, dll.).

Namun, ada **3 solusi ideal** agar alur kerja berjalan mulus tanpa harus menyalakan terminal manual setiap kali ingin menggunakan ekstensi:

---

## 2. Pilihan Solusi Terbaik

### Opsi A — Auto-Start Silent di Windows (Paling Praktis untuk Pemakaian Harian di PC Sendiri)
Server Python tetap berjalan di komputer Anda (`localhost:8888`) sehingga akses ke `Shopee_Product_Assets/`, `Tokopedia_Product_Assets/`, `Output/Flow_Generated/`, dan `Database/alibaba_master.db` super cepat (0 ms latency, offline-ready), tetapi **menyala otomatis tanpa jendela terminal**:
1. **Task Scheduler / `shell:startup` dengan `pythonw.exe`:**
   - Buat shortcut di `Win + R` → `shell:startup` yang menjalankan:
     ```bat
     pythonw.exe "D:\Work\Hots\Product Input\App\alibaba_manager_app.py"
     ```
   - `pythonw.exe` menjalankan server di background tanpa membuka jendela CMD.
2. **Chrome Native Messaging Host (On-Demand Launch):**
   - Daftarkan manifest Native Messaging di Windows Registry (`HKCU\Software\Google\Chrome\NativeMessagingHosts\com.hots.bridge`).
   - Saat ekstensi mendeteksi `localhost:8888` offline, `background.js` memanggil `chrome.runtime.connectNative("com.hots.bridge")` yang otomatis membangunkan server Python di background.

---

### Opsi B — Hybrid Cloud / VPS + Cloudflare Tunnel (Paling Ideal Jika Dipakai Tim / Multi-Laptop)
Jika ekstensi ingin dipakai di banyak laptop tanpa menyalakan server lokal di masing-masing PC:
1. **Deploy `App/alibaba_manager_app.py` + `Database/alibaba_master.db` + folder aset** ke 1 VPS/server kantor, **atau** ekspos PC utama menggunakan **Cloudflare Tunnel** (`cloudflared tunnel`) menjadi HTTPS domain tetap (contoh: `https://hots-bridge.domainanda.com`).
2. Di `Chrome_Extension/background.js`, ubah `BRIDGE_BASE` (atau buat input URL Server di `popup.html`) dari `http://localhost:8888` ke URL HTTPS tersebut, dan tambahkan domain tersebut ke `host_permissions` di `Chrome_Extension/manifest.json`.
3. **Catatan untuk hasil Google Flow:** File hasil download Google Flow (`chrome.downloads`) tetap masuk ke folder `Downloads` browser lokal pengguna, lalu `background.js` bisa meng-upload file/metadata tersebut via `multipart/form-data` ke server bridge.

---

### Opsi C — Bundled Offline Catalog JSON (Zero-Server Fallback untuk Data Teks)
Jika suatu saat server `:8888` mati dan Anda hanya butuh mengisi **Judul, Keyword, Kategori, Harga FOB, MOQ, Atribut, dan Deskripsi B2B** di `https://post.alibaba.com/product/publish.htm` atau **4-Slot Prompt** di Google Flow:
- Data teks 125 SKU (`master_products_catalog.json` versi ringkas) dapat dibundel langsung di dalam folder `Chrome_Extension/data/catalog_lite.json`.
- Ekstensi akan otomatis memakai data bundel tersebut saat `:8888` tidak aktif, sementara **foto lokal & penyimpanan hasil Flow** tetap memakai Opsi A atau Opsi B.

---

## 3. Rekomendasi Implementasi
- **Untuk 1 PC / Operator Utama:** Gunakan **Opsi A (`pythonw.exe` di `shell:startup`)** — paling cepat, gratis, dan zero-setup di kode ekstensi.
- **Untuk Tim / Banyak Device:** Gunakan **Opsi B (VPS / Cloudflare Tunnel)** + fallback **Opsi C (`catalog_lite.json`)**.
