# Stage-DesktopBackground.ps1
# Stages the background and installation script for setting the default desktop background in Windows 11
# JSASD Technology Department

#Copy the PS1 File
# Variables
$Target = "$env:ProgramData\Scripts"
$Script = "DesktopBackround.ps1"

# If local path for script doesn't exist, create it
If (!(Test-Path $Target)) { New-Item -Path $Target -Type Directory -Force }

Copy-Item "DesktopBackground.ps1" -Destination "C:\ProgramData\Scripts" -Force

#copy your background
Copy-Item "jsasd-background.jpg" -Destination "C:\Users\Public\Pictures" -Force

#Load Default User Profile
reg load HKU\DEFAULT_USER C:\Users\Default\NTUSER.DAT
#Set Default Background using a run once that calls the ps1 script you just copied.
reg.exe add "HKU\DEFAULT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce" /v "DefaultBackground" /t REG_SZ /d "powershell.exe -executionpolicy Bypass -Windowstyle Hidden -file C:\Programdata\Scripts\DesktopBackground.ps1" /f | Out-Host
#Unload Default User Profile
reg unload HKU\DEFAULT_USER