@echo off
title Japanese Kana Learning Tool
chcp 65001 >nul

REM Check if Git Bash exists
if exist "C:\Program Files\Git\bin\bash.exe" (
    echo Starting Japanese Kana Learning Tool...
    echo.
    "C:\Program Files\Git\bin\bash.exe" "%~dp0kana_learn.sh"
) else if exist "C:\Program Files (x86)\Git\bin\bash.exe" (
    echo Starting Japanese Kana Learning Tool...
    echo.
    "C:\Program Files (x86)\Git\bin\bash.exe" "%~dp0kana_learn.sh"
) else (
    echo.
    echo ====================================================
    echo   Japanese Kana Learning Tool - Setup Required
    echo ====================================================
    echo.
    echo This tool requires Git Bash to run on Windows.
    echo.
    echo EASY SETUP:
    echo 1. Download Git for Windows: https://git-scm.com/download/win
    echo 2. Install with default settings
    echo 3. Run this file again
    echo.
    echo Alternative: Use Windows Subsystem for Linux ^(WSL^)
    echo Run: wsl --install in PowerShell ^(as admin^)
    echo.
    echo Press any key to open download page...
    pause >nul
    start https://git-scm.com/download/win
)

pause