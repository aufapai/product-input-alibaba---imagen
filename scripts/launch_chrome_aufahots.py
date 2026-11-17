# -*- coding: utf-8 -*-
"""
Launcher Minimalis Google Chrome Profil aufahots@gmail.com + Chrome Extension
Tidak membuka banyak tab terpisah; kontrol Tab Group ('HOTS Flow') dan
pembukaan Google Flow / Photobank / Alibaba dijalankan langsung dari Extension.
"""

import os
import sys
import json
import subprocess

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

TARGET_EMAIL = "aufahots@gmail.com"
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
EXT_DIR = os.path.join(BASE_DIR, "Chrome_Extension")
DEFAULT_START_URL = "https://flow.google.com/project/5a88c3fd-477c-4eed-a126-f812ccfb079c"


def find_chrome_exe() -> str:
    candidates = [
        os.path.join(os.environ.get("PROGRAMFILES", ""), "Google", "Chrome", "Application", "chrome.exe"),
        os.path.join(os.environ.get("PROGRAMFILES(X86)", ""), "Google", "Chrome", "Application", "chrome.exe"),
        os.path.join(os.environ.get("LOCALAPPDATA", ""), "Google", "Chrome", "Application", "chrome.exe"),
    ]
    for c in candidates:
        if c and os.path.exists(c):
            return c
    return ""


def find_profile_directory(target_email: str) -> str:
    local_state = os.path.join(
        os.environ.get("LOCALAPPDATA", ""), "Google", "Chrome", "User Data", "Local State"
    )
    if not os.path.exists(local_state):
        return ""
    try:
        with open(local_state, "r", encoding="utf-8") as f:
            data = json.load(f)
        info_cache = data.get("profile", {}).get("info_cache", {})
        for prof_dir, meta in info_cache.items():
            user_name = str(meta.get("user_name", "")).strip().lower()
            name = str(meta.get("name", "")).strip().lower()
            if target_email.lower() in (user_name, name) or target_email.lower() in user_name:
                return prof_dir
    except Exception as e:
        print(f"[WARN] Gagal membaca Local State Chrome: {e}")
    return ""


def main():
    chrome_exe = find_chrome_exe()
    if not chrome_exe:
        print("[ERROR] Google Chrome (chrome.exe) tidak ditemukan di lokasi standar.")
        sys.exit(1)

    prof_dir = find_profile_directory(TARGET_EMAIL)
    args = [chrome_exe]

    if prof_dir:
        print(f"[OK] Profil Chrome '{TARGET_EMAIL}' ditemukan di folder: {prof_dir}")
        args.append(f"--profile-directory={prof_dir}")
    else:
        print(f"[INFO] Profil '{TARGET_EMAIL}' belum terdeteksi otomatis di Local State, membuka Chrome standar.")

    if os.path.exists(EXT_DIR):
        print(f"[OK] Memuat ekstensi lokal: {EXT_DIR}")
        args.append(f"--load-extension={EXT_DIR}")

    args.append(DEFAULT_START_URL)

    print("[INFO] Membuka Google Chrome (profil aufahots@gmail.com)...")
    subprocess.Popen(args, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    print("[SELESAI] Gunakan popup/panel Chrome Extension untuk 'Buka Grup Kerja' atau 'Run Google Flow'.")


if __name__ == "__main__":
    main()
