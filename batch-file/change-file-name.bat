 rem Instruction: https://hung1001nd.blogspot.com/2018/01/doi-ten-file-theo-dinh-dang-don-gian-bang-batchscript.html

:: Author - Hung Hoang
@echo off
pushd %~dp0
set /a var=0
setlocal enabledelayedexpansion
for /f %%a in ('dir /b *.phan_mo_rong') do (
 set /a var+=1
 ren "%%a" "[ten_tuy_thich]!var!.phan_mo_rong"
)
exit /b