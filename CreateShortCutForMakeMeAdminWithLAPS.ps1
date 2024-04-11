$shortcut = (New-Object -ComObject Wscript.Shell).CreateShortcut("$([Environment]::GetFolderPath('Desktop'))\MakeMeAdminWithLAPS.lnk")
$shortcut.TargetPath = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe"
$shortcut.Arguments = "-WindowStyle Hidden -File ""$env:SystemRoot\System32\MakeMeAdminWithLAPS.ps1"""
$shortcut.IconLocation = "$env:ProgramFiles\Make Me Admin\MakeMeAdminUI.exe"
$shortcut.WorkingDirectory = "$env:SystemRoot\System32"
$shortcut.WindowStyle = 7 #Minimized
$shortcut.Save()
