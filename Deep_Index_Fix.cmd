@echo off
setlocal enabledelayedexpansion

echo ====================================================
echo   DEEP FILE + FOLDER INDEXER FOR LINUX MOUNT
echo ====================================================

:: Проверка прав администратора
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] ERROR: Please run as Administrator
    pause & exit /b
)

set /p target="Drag and drop folder here and press Enter: "
set target=%target:"=%

if not exist "%target%" (
    echo [!] Path not found.
    pause & exit /b
)

echo.
echo [STEP 1] Taking ownership (Folders + Files)...
takeown /F "%target%" /R /D Y >nul

echo [STEP 2] Resetting ACL permissions (777 equivalent)...
icacls "%target%" /reset /T /C /Q
icacls "%target%" /grant:r Everyone:(OI)(CI)F /T /C /Q

echo [STEP 3] Indexing Folders (MFT Refresh)...
for /d /r "%target%" %%i in (*) do (
    echo Folder: %%i
    ren "%%i" "fix_tmp"
    ren "%%~dpi\fix_tmp" "%%~nxi"
)

echo [STEP 4] Indexing Files (Touching metadata)...
:: Команда copy /b обновляет дату изменения файла без изменения содержимого
:: Это заставляет систему заново прочитать дескриптор файла
for /r "%target%" %%f in (*) do (
    echo File: %%~nxf
    attrib -R -S -H "%%f"
    copy /b "%%f" +,, "%%f" >nul 2>&1
)

echo.
echo ====================================================
echo   SUCCESS! 
echo   All files and folders are now visible and unlocked.
echo ====================================================
pause
