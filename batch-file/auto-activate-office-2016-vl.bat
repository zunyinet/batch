rem Instruction: https://hung1001nd.blogspot.com/2017/03/batch-script-auto-activate-microsoft.html

:: Made by Hoang Hung
@echo off
color 0f
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if "%errorlevel%" NEQ "0" (
 echo: Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
 echo: UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
 "%temp%\getadmin.vbs" & exit 
)
if exist "%temp%\getadmin.vbs" del /f /q "%temp%\getadmin.vbs"
title Auto activate Office 2016 VL
if exist "C:\Program Files\Microsoft Office\Office16\ospp.vbs" set folder="C:\Program Files\Microsoft Office\Office16"
if exist "C:\Program Files (x86)\Microsoft Office\Office16\ospp.vbs" set folder="C:\Program Files (x86)\Microsoft Office\Office16"
cscript //nologo "%folder%\ospp.vbs" /sethst:kms.lotro.cc
for /f "tokens=5 delims=,_ " %%b in ('cscript //nologo "%folder%\ospp.vbs" /dstatus ^| find "NAME"') do (set version=%%b&call:check)
cscript //nologo %folder%\ospp.vbs" /act & cls & cscript //nologo %folder%\ospp.vbs" /dstatus
pause & exit
:check
if "%version%" EQU "Office16ProPlusVL" cscript //nologo "%folder%\ospp.vbs" /inpkey:XQNVK-8JYDB-WJ9W3-YJ8YR-WFG99
if "%version%" EQU "Office16ProjectProVL" cscript //nologo "%folder%\ospp.vbs" /inpkey:YG9NW-3K39V-2T3HJ-93F3Q-G83KT
if "%version%" EQU "Office16VisioProVL" cscript //nologo "%folder%\ospp.vbs" /inpkey:PD3PC-RHNGV-FXJ29-8JK7D-RJRJK
if "%version%" EQU "Office16StandardVL" cscript //nologo "%folder%\ospp.vbs" /inpkey:JNRGM-WHDWX-FJJG3-K47QV-DRTFM
if "%version%" EQU "Office16ProjectStdVL" cscript //nologo "%folder%\ospp.vbs" /inpkey:GNFHQ-F6YQM-KQDGJ-327XX-KQBVC
if "%version%" EQU "Office16VisioStdVL" cscript //nologo "%folder%\ospp.vbs" /inpkey:7WHWN-4T7MP-G96JF-G33KR-W8GF4
goto:eof