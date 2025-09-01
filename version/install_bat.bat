@echo off
setlocal enabledelayedexpansion
title Japanese Kana Learning Tool - Installer
chcp 65001 >nul 2>&1

echo.
echo ===============================================
echo   Japanese Kana Learning Tool - Installer
echo ===============================================
echo.
echo This installer will set up everything you need to run
echo the Japanese Kana Learning Tool on Windows.
echo.

REM Check if running as administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [WARNING] Not running as administrator.
    echo Some features may not work properly.
    echo Right-click this file and select "Run as administrator" for best results.
    echo.
    pause
    echo.
)

REM Create installation directory
set "INSTALL_DIR=%USERPROFILE%\KanaLearningTool"
if not exist "%INSTALL_DIR%" (
    echo Creating installation directory...
    mkdir "%INSTALL_DIR%"
    echo ✓ Created: %INSTALL_DIR%
)

REM Check if Git is already installed
echo Checking for Git installation...
git --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✓ Git is already installed!
    goto :download_files
)

REM Check common Git installation paths
set "GIT_FOUND=0"
if exist "C:\Program Files\Git\bin\git.exe" set "GIT_FOUND=1"
if exist "C:\Program Files (x86)\Git\bin\git.exe" set "GIT_FOUND=1"
if exist "%LOCALAPPDATA%\Programs\Git\bin\git.exe" set "GIT_FOUND=1"

if %GIT_FOUND% equ 1 (
    echo ✓ Git found in system!
    goto :download_files
)

echo.
echo Git for Windows is required to run this tool.
echo.
echo OPTIONS:
echo 1. Auto-download and install Git (Recommended)
echo 2. Manual installation (opens download page)
echo 3. Skip Git installation (use PowerShell version only)
echo 4. Exit installer
echo.
set /p "git_choice=Choose option (1-4): "

if "%git_choice%"=="1" goto :auto_install_git
if "%git_choice%"=="2" goto :manual_install_git
if "%git_choice%"=="3" goto :skip_git
if "%git_choice%"=="4" goto :exit_installer

echo Invalid choice. Defaulting to option 2.
:manual_install_git
echo.
echo Opening Git download page in your browser...
echo Please download and install with default settings, then run this installer again.
start https://git-scm.com/download/win
pause
goto :exit_installer

:auto_install_git
echo.
echo Attempting to download Git installer...
echo This may take a few minutes depending on your internet connection.
echo.

REM Try to download Git installer using PowerShell
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://github.com/git-for-windows/git/releases/latest/download/Git-2.42.0.2-64-bit.exe' -OutFile '%TEMP%\Git-Installer.exe'}" >nul 2>&1

if exist "%TEMP%\Git-Installer.exe" (
    echo ✓ Download successful!
    echo.
    echo Starting Git installation...
    echo Please follow the installer prompts (default settings are recommended).
    echo.
    pause
    "%TEMP%\Git-Installer.exe"
    echo.
    echo Waiting for Git installation to complete...
    echo Press any key after the Git installer finishes.
    pause
    del "%TEMP%\Git-Installer.exe" >nul 2>&1
) else (
    echo ✗ Download failed. Please install Git manually:
    echo https://git-scm.com/download/win
    pause
    goto :exit_installer
)

:download_files
echo.
echo Downloading Kana Learning Tool files...

REM Copy files to installation directory
if exist "kana_learn.sh" (
    copy "kana_learn.sh" "%INSTALL_DIR%\" >nul
    echo ✓ Copied: kana_learn.sh
)

if exist "kana_learn.bat" (
    copy "kana_learn.bat" "%INSTALL_DIR%\" >nul
    echo ✓ Copied: kana_learn.bat
)

if exist "kana_learn.ps1" (
    copy "kana_learn.ps1" "%INSTALL_DIR%\" >nul
    echo ✓ Copied: kana_learn.ps1
)

:skip_git
REM Create desktop shortcut
echo.
echo Creating desktop shortcut...
set "DESKTOP=%USERPROFILE%\Desktop"
set "SHORTCUT=%DESKTOP%\Japanese Kana Learning Tool.lnk"

REM Use PowerShell to create shortcut
powershell -Command "& {$WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%SHORTCUT%'); $Shortcut.TargetPath = '%INSTALL_DIR%\kana_learn.bat'; $Shortcut.WorkingDirectory = '%INSTALL_DIR%'; $Shortcut.Description = 'Japanese Kana Learning Tool'; $Shortcut.Save()}" >nul 2>&1

if exist "%SHORTCUT%" (
    echo ✓ Desktop shortcut created!
) else (
    echo ⚠ Could not create desktop shortcut
)

REM Create Start Menu entry
echo Creating Start Menu entry...
set "STARTMENU=%APPDATA%\Microsoft\Windows\Start Menu\Programs"
if not exist "%STARTMENU%\Japanese Learning Tools" mkdir "%STARTMENU%\Japanese Learning Tools"

powershell -Command "& {$WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%STARTMENU%\Japanese Learning Tools\Kana Learning Tool.lnk'); $Shortcut.TargetPath = '%INSTALL_DIR%\kana_learn.bat'; $Shortcut.WorkingDirectory = '%INSTALL_DIR%'; $Shortcut.Description = 'Interactive Japanese Kana Learning Tool'; $Shortcut.Save()}" >nul 2>&1

echo ✓ Start Menu entry created!

REM Add to PATH (optional)
echo.
set /p "add_path=Add tool to system PATH? (y/n): "
if /i "%add_path%"=="y" (
    echo Adding to PATH...
    REM This would require admin privileges
    setx PATH "%PATH%;%INSTALL_DIR%" >nul 2>&1
    echo ✓ Added to PATH ^(restart command prompt to use^)
)

REM Create uninstaller
echo.
echo Creating uninstaller...
(
echo @echo off
echo title Kana Learning Tool - Uninstaller
echo echo Removing Japanese Kana Learning Tool...
echo rd /s /q "%INSTALL_DIR%"
echo del "%DESKTOP%\Japanese Kana Learning Tool.lnk" ^>nul 2^>^&1
echo rd /s /q "%STARTMENU%\Japanese Learning Tools" ^>nul 2^>^&1
echo echo Uninstallation complete!
echo pause
) > "%INSTALL_DIR%\uninstall.bat"
echo ✓ Uninstaller created: %INSTALL_DIR%\uninstall.bat

REM Installation complete
echo.
echo ===============================================
echo           INSTALLATION COMPLETE! 🎉
echo ===============================================
echo.
echo The Japanese Kana Learning Tool has been installed to:
echo %INSTALL_DIR%
echo.
echo HOW TO RUN:
echo • Double-click the desktop shortcut
echo • Use Start Menu: Japanese Learning Tools
echo • Run: %INSTALL_DIR%\kana_learn.bat
echo.
echo WHAT'S INCLUDED:
if exist "%INSTALL_DIR%\kana_learn.sh" echo ✓ Bash version ^(full-featured^)
if exist "%INSTALL_DIR%\kana_learn.ps1" echo ✓ PowerShell version ^(Windows native^)
echo ✓ Desktop shortcut
echo ✓ Start Menu entry  
echo ✓ Uninstaller
echo.
echo がんばって！^(Ganbatte! - Good luck with your studies!^) 🇯🇵
echo.

REM Ask if user wants to run now
set /p "run_now=Would you like to run the tool now? (y/n): "
if /i "%run_now%"=="y" (
    echo.
    echo Starting Japanese Kana Learning Tool...
    cd /d "%INSTALL_DIR%"
    call "kana_learn.bat"
)

:exit_installer
echo.
echo Thank you for installing Japanese Kana Learning Tool!
echo.
pause
exit /b 0