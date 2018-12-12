DIM objShell
set objShell=wscript.createObject("wscript.shell")
iReturn=objShell.Run("cmd.exe /C E:\fq\v2ray-v3.45-windows-64\v2ray.bat", 0, TRUE)