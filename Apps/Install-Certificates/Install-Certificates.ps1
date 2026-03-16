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
            $store.Add($cert)
            $store.Close()
            Write-Host "Installed [$($_.Name)] -> $storeLocation\$storeName"
        } catch {
            Write-Warning "Failed to install [$($_.Name)]: $_"
        }
    }
}