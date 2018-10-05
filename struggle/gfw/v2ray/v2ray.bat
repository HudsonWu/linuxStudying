:: @echo off
:: if "%1" == "h" goto begin
:: start mshta vbscript:createobject("wscript.shell").run("""%~nx0""h",0)(window.close)&&exit
:: :begin

set today=%date:~0,4%-%date:~5,2%-%date:~8,2%
set now=%time:~0,2%%time:~3,2%%time:~6,2%
cd /d E:\fq\v2ray-v3.45-windows-64
start /b v2ray.exe >> E:\fq\v2ray-v3.45-windows-64\logs\log%today%_%now%.txt

:: pause