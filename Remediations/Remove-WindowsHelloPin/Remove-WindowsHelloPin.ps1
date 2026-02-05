$passportFolder = "C:\Windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\Ngc"
 
# Take ownership and grant full control to Administrators
Write-Host "Granting access to Windows Hello folder for deletion"
powershell -windowstyle hidden -command "Start-Process cmd -ArgumentList '/s,/c,takeown /f $passportFolder /r /d y & icacls $passportFolder /grant administrators:F /t' -Verb runAs"
 
# Remove the contents of the Ngc folder
Write-Host "Removing Windows Hello folder"
Remove-Item -Path "$passportFolder\*" -Recurse -Force -ErrorAction SilentlyContinue
 
# Recreate the Ngc folder (optional, but good practice)
Write-Host "Recreating an empty Windows Hello folder"
New-Item -Path $passportFolder -ItemType Directory -Force