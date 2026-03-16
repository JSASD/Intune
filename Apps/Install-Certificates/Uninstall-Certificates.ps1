$organization = "JSASD"
$packageName = "VexCerts"

$certsRoot = Join-Path $PSScriptRoot "certs"
$storeLocation = "LocalMachine"

Get-ChildItem -Path $certsRoot -Directory | ForEach-Object {
    $storeName = $_.Name

    $certFiles = Get-ChildItem -Path $_.FullName -File | Where-Object { $_.Name -ne ".gitkeep" }

    if (-not $certFiles) {
        Write-Host "No certs found in $storeName, skipping."
        return
    }

    $certFiles | ForEach-Object {
        try {
            $cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2 $_.FullName
            $store = New-Object System.Security.Cryptography.X509Certificates.X509Store($storeName, $storeLocation)
            $store.Open("ReadWrite")

            $existing = $store.Certificates | Where-Object { $_.Thumbprint -eq $cert.Thumbprint }
            if ($existing) {
                $store.Remove($existing)
                Write-Host "Removed [$($_.Name)] from $storeLocation\$storeName"

                Remove-Item -Path "HKLM:\SOFTWARE\$organization\$packageName" -Force -Recurse -ErrorAction SilentlyContinue
                Write-Host "Removed registry entry for $packageName"
            } else {
                Write-Host "Not found, skipping [$($_.Name)] in $storeLocation\$storeName"
            }

            $store.Close()
        } catch {
            Write-Warning "Failed to remove [$($_.Name)]: $_"
        }
    }
}