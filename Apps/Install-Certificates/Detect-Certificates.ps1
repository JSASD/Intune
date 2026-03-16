$certsRoot = Join-Path $PSScriptRoot "certs"
$storeLocation = "LocalMachine"
$allFound = $true

Get-ChildItem -Path $certsRoot -Directory | ForEach-Object {
    $storeName = $_.Name

    $certFiles = Get-ChildItem -Path $_.FullName -File | Where-Object { $_.Name -ne ".gitkeep" }

    $certFiles | ForEach-Object {
        try {
            $cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2 $_.FullName
            $store = New-Object System.Security.Cryptography.X509Certificates.X509Store($storeName, $storeLocation)
            $store.Open("ReadOnly")

            $existing = $store.Certificates | Where-Object { $_.Thumbprint -eq $cert.Thumbprint }
            if (-not $existing) {
                $allFound = $false
            }

            $store.Close()
        } catch {
            $allFound = $false
        }
    }
}

if ($allFound) {
    Write-Host "Detected"
    exit 0
} else {
    Write-Host "Not Detected"
    exit 1
}