rem Instruction: https://hung1001nd.blogspot.com/2017/07/batchscript-nhap-key-va-lay.html

:: Made by Hoang Hung
:: Homepage: https://hung1001nd.blogspot.com
@echo off
color 0f
pushd "%~dp0"
title Get IID Office 2010-2013-2016
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if "%errorlevel%" NEQ "0" (
 echo: Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
 echo: UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
 "%temp%\getadmin.vbs" & exit 
)
if exist "%temp%\getadmin.vbs" del /f /q "%temp%\getadmin.vbs"
 
setLocal EnableDelayedExpansion
set ver=(4,5,6)
for /d %%a in %ver% do call:path "%%a"
start %~dp0id.txt
timeout 2 >nul 
del /f %~dp0id.txt
exit
 
:path
if exist "C:\Program Files\Microsoft Office\Office1%~1\ospp.vbs" (
 cd /d "C:\Program Files\Microsoft Office\Office1%~1"
 call:getID "%~1"
)
 
if exist "C:\Program Files (x86)\Microsoft Office\Office1%~1\ospp.vbs" (
 cd /d "C:\Program Files (x86)\Microsoft Office\Office1%~1"
 call:getID "%~1"
)
goto:eof
 
:getID
for /f "tokens=4-8 delims=:, " %%b in ('cscript //nologo ospp.vbs /dinstid ^| findstr /i "Installation ID"') do (
 set id=%%f
 if %~1 EQU 4 (
  set id1=!id:~0,6!& set id2=!id:~6,6!& set id3=!id:~12,6!& set id4=!id:~18,6!& set id5=!id:~24,6!& set id6=!id:~30,6!& set id7=!id:~36,6!& set id8=!id:~42,6!& set id9=!id:~48,6!
  (echo %%b %%c, %%d & echo.Installation ID: !id1!-!id2!-!id3!-!id4!-!id5!-!id6!-!id7!-!id8!-!id9!&echo.) >>%~dp0id.txt 
 ) else (
  set id1=!id:~0,7!& set id2=!id:~7,7!& set id3=!id:~14,7!& set id4=!id:~21,7!& set id5=!id:~28,7!& set id6=!id:~35,7!& set id7=!id:~42,7!& set id8=!id:~49,7!& set id9=!id:~56,7!
  (echo %%b %%c, %%d & echo.Installation ID: !id1!-!id2!-!id3!-!id4!-!id5!-!id6!-!id7!-!id8!-!id9!&echo.) >>%~dp0id.txt
 )
)
exit /b