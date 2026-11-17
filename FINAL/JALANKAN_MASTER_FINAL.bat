@echo off
TITLE AP BOOTS and PETROVA MASTER CATALOG FINAL
COLOR 0B
chcp 65001 >nul

echo ===================================================================
echo   AP BOOTS and PETROVA - UNIFIED MASTER PRODUCT CATALOG (FINAL)
echo       Single Source of Truth - 0 Duplikat - 125 Master SKU
echo ===================================================================
echo.

cd /d "%~dp0"

:: 1. Deteksi Python dengan Fallback Cerdas
set "PY_CMD="
python --version >nul 2>&1
if not errorlevel 1 (
    set "PY_CMD=python"
) else (
    py -3 --version >nul 2>&1
    if not errorlevel 1 (
        set "PY_CMD=py -3"
    ) else (
        if exist "C:\Program Files\Python313\python.exe" (
            set "PY_CMD=C:\Program Files\Python313\python.exe"
        ) else if exist "C:\Program Files\Python312\python.exe" (
            set "PY_CMD=C:\Program Files\Python312\python.exe"
        ) else if exist "C:\Program Files\Python311\python.exe" (
            set "PY_CMD=C:\Program Files\Python311\python.exe"
        )
    )
)

if "%PY_CMD%"=="" (
    COLOR 0C
    echo [ERROR] Python tidak terdeteksi di sistem Anda!
    echo Pastikan Python 3 telah terpasang dan opsi "Add Python to PATH" dicentang.
    echo.
    pause
    exit /b 1
)

echo [OK] Python terdeteksi via: %PY_CMD%
echo.

:: 2. Pastikan file database telah dikompilasi
if not exist "master_products_consolidated.db" (
    echo [1/3] Mengompilasi database SQL dan dataset master awal...
    "%PY_CMD%" build_complete_database_and_exports.py
    if errorlevel 1 (
        echo [WARNING] Kompilasi database menghadapi catatan, melanjutkan dengan file yang ada...
    )
) else (
    echo [1/3] Database master dan aset SQL/Excel siap digunakan!
)
echo.

:: 3. Buka browser otomatis
echo [2/3] Membuka antarmuka Master Catalog di peramban web...
start "" "http://localhost:8899"

:: 4. Jalankan Dedicated Server
echo [3/3] Menjalankan Server Master Final di Port 8899...
echo.
echo ===================================================================
echo  Server Aktif: http://localhost:8899
echo  SQL Live Web : http://localhost:8899/inject_catalog_hotstrading.sql
echo  Database SQL : http://localhost:8899/master_products_database.sql
echo  Master Excel : http://localhost:8899/master_products_complete_detailed.xlsx
echo  Macro Excel  : http://localhost:8899/master_products_complete_detailed.xlsm
echo.
echo  Jangan tutup jendela ini selama menggunakan aplikasi.
echo  Tekan Ctrl + C untuk mematikan server.
echo ===================================================================
echo.

"%PY_CMD%" server_final.py

echo.
echo Server telah berhenti.
pause
