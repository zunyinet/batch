rem Instruction: https://hung1001nd.blogspot.com/2017/06/batchscript-nhap-key-va-lay.html

set key=NK96Y-D9CD8-W44CQ-R8YTK-DYJWX
for /f "tokens=6 delims=[.] " %a in ('ver') do set ver=%a
cscript //nologo %windir%\system32\slmgr.vbs /ipk %key%
for /f "tokens=3" %i in ('cscript //nologo %windir%\system32\slmgr.vbs /dti') do set id=%i
if %ver% LEQ 7601 ((echo Key: %key%&echo.&echo Installation ID: %id:~0,6%-%id:~6,6%-%id:~12,6%-%id:~18,6%-%id:~24,6%-%id:~30,6%-%id:~36,6%-%id:~42,6%-%id:~48,6%)> id.txt) else (
(echo Key: %key%&echo.&echo Installation ID: %id:~0,7%-%id:~7,7%-%id:~14,7%-%id:~21,7%-%id:~28,7%-%id:~35,7%-%id:~42,7%-%id:~49,7%-%id:~56,7%)> id.txt)
start id.txt&timeout 2 >nul&del /f /q %windir%\system32\id.txt
cls