$version = "1.0.0"
$organization = "JSASD"
$packageName = "VexCerts"
$val = Get-ItemProperty -Path "HKLM:\SOFTWARE\$organization\$packageName" -Name "version" -ErrorAction SilentlyContinue


if ($val.Version -eq $version) {
    Write-Host "Detected"
    exit 0
} else {
    Write-Host "Not Detected"
    exit 1
}