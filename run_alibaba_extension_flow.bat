@echo off
title HOTS Alibaba Extension and Google Flow Bridge - aufahots@gmail.com
color 0b
chcp 65001 >nul

cd /d "%~dp0"

echo ===================================================================
echo   HOTS TRADING - LOCAL BRIDGE + CHROME EXTENSION (GRUP TAB MODE)
echo   Profil Target Chrome: aufahots@gmail.com
echo ===================================================================
echo.

echo [1/3] Memeriksa Python...
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python tidak terdeteksi!
    pause
    exit /b 1
)

echo [2/3] Menyalakan Local Bridge Server di background (:8888)...
netstat -ano | findstr ":8888 " | findstr "LISTENING" >nul 2>&1
if errorlevel 1 (
    start /min "HOTS Local Bridge 8888" cmd /k "cd /d "%~dp0" && python App\alibaba_manager_app.py"
    timeout /t 2 /nobreak >nul
    echo [OK] Local Bridge Server berjalan minimized di port 8888.
) else (
    echo [OK] Local Bridge Server sudah berjalan di port 8888.
)

echo [3/3] Memastikan profil Chrome aufahots@gmail.com siap...
python scripts\launch_chrome_aufahots.py

echo.
echo ===================================================================
echo  SELESAI! Semua kendali sekarang ada di Chrome Extension:
echo   - Klik ikon Extension HOTS -> "Buka Grup Kerja" (1 Tab Group)
echo   - Klik "Run Google Flow (Agent 2K)" langsung dari Extension
echo   - Klik "Tutup Grup Tab" untuk menutup semua tab kerja sekaligus
echo ===================================================================
echo.
pause
