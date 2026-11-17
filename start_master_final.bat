@echo off
TITLE AP BOOTS and PETROVA MASTER CATALOG FINAL LAUNCHER
COLOR 0B
chcp 65001 >nul

cd /d "%~dp0"
if exist "FINAL\JALANKAN_MASTER_FINAL.bat" (
    cd FINAL
    call JALANKAN_MASTER_FINAL.bat
) else (
    echo [ERROR] Folder FINAL tidak ditemukan di: %~dp0FINAL
    echo Pastikan folder FINAL berada di samping file launcher ini.
    echo.
    pause
)
