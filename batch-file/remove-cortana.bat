rem Instruction: https://hung1001nd.blogspot.com/2017/05/batchscript-huong-dan-go-bo-vinh-vien.html

:: Made by Hoang Hung
@echo off
 
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if "%errorlevel%" NEQ "0" (
 echo: Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
 echo: UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
 "%temp%\getadmin.vbs" & exit 
)
if exist "%temp%\getadmin.vbs" del /f /q "%temp%\getadmin.vbs"
 
Title Remove Cortana ^& Search
 
for /f "tokens=2*" %%e in ('reg query "HKEY_CLASSES_ROOT\CLSID\{5FDD51E2-A9D0-44CE-8C8D-162BA0C591A0}" /v "Version"') do set vers=%%f
 
if %PROCESSOR_ARCHITECTURE% EQU AMD64 (set arc=amd64) else (set arc=x86)
 
echo.
echo Deleting key in "Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\InboxApplications"
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\InboxApplications\Microsoft.Windows.Cortana_%vers%_neutral_neutral_cw5n1h2txyewy" /f
 
set pack=(Microsoft-Windows-Cortana-Package~31bf3856ad364e35~%arc%~~%vers%,Microsoft-Windows-Cortana-PAL-Desktop-Package~31bf3856ad364e35~%arc%~~%vers%)
 
for /d %%b in %pack% do (
echo ========================================================================
echo Deleting key in "Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages\%%b\Owners"
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages\%%b\Owners" /f
echo.
)
set packremove=(Microsoft-Windows-Cortana-Package~31bf3856ad364e35~%arc%~~%vers%,Microsoft-Windows-Cortana-PAL-Desktop-Package~31bf3856ad364e35~%arc%~~%vers%)
 
for /d %%c in %packremove% do (
echo ========================================================================
echo Removing package %%c...
dism /online /remove-package /packagename:%%c /NoRestart
echo.
)
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f
taskkill /IM explorer.exe /F >nul 2>&1
explorer.exe >nul 2>&1
echo ========================================================================
pause