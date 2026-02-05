$passportFolder = "C:\Windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\Ngc"
 
$folderExists = Test-Path $passportFolder

if($folderExists) {
    Write-Host "Windows Hello data found"
    exit 1
} else {
    Write-Host "Windows Hello data not found"
    exit 0
}