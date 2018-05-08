rem Instruction: https://hung1001nd.blogspot.com/2017/05/tips-huong-dan-go-bo-microsoft-edge.html

:: Made by Hoang Hung
@echo off
color 0f
mode con: cols=140 lines=30
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if "%errorlevel%" NEQ "0" (
 echo: Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
 echo: UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
 "%temp%\getadmin.vbs" & exit 
)
if exist "%temp%\getadmin.vbs" del /f /q "%temp%\getadmin.vbs"
 
Title Remove Microsoft Edge
 
for /f "tokens=2*" %%e in ('reg query "HKEY_CLASSES_ROOT\CLSID\{5FDD51E2-A9D0-44CE-8C8D-162BA0C591A0}" /v "Version"') do set vers=%%f
 
if %PROCESSOR_ARCHITECTURE% EQU AMD64 (set arc=amd64) else (set arc=x86)
 
echo.
echo Deleting key in "Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\InboxApplications"
 
for /f "tokens=1" %%a in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\InboxApplications" ^| find /i "Microsoft.MicrosoftEdge"') do (set pack=%%a)
for /f "tokens=9 delims=\" %%b in ("%pack%") do (set packagename=%%b)
if "%packagename%" == "" ( echo.&echo Key doesn't exist...
) else (
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\InboxApplications\%packagename%" /f
)
 
set packowner=(Microsoft-Windows-Internet-Browser-Package~31bf3856ad364e35~%arc%~~%vers%)
 
for /d %%b in %packowner% do (
echo ========================================================================
echo Deleting key in "Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages\%%b\Owners"
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages\%%b\Owners" /f
echo ========================================================================
echo Removing package %%b...
dism /online /remove-package /packagename:%%b /NoRestart
)
echo ========================================================================
pause