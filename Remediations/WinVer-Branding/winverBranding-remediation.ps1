<#
    .SYNOPSIS 
    Change WinVer and OEM Info

    .DESCRIPTION
    Install:   C:\Windows\SysNative\WindowsPowershell\v1.0\PowerShell.exe -ExecutionPolicy Bypass -Command .\remediation.ps1
    
    .ENVIRONMENT
    PowerShell 5.0
    
    .AUTHOR
    Niklas Rast // JSASD Technology Department
#>

$BrandingContent = @"
RegKeyPath,Key,Value
"HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation","SupportURL","https://kb.jsasd.org"
"HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation","Manufacturer","Jersey Shore Area School District"
"HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation","SupportHours","Monday - Friday, 8:00 AM - 4:00 PM"
"HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation","SupportPhone","+1 570-398-5251 x71380"
"HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion","RegisteredOwner","Instructional Technology Department"
"HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion","RegisteredOrganization","Jersey Shore Area School District"
"@

$Branding = $BrandingContent | ConvertFrom-Csv -delimiter ","

foreach ($Brand in $Branding) {

    IF (!(Test-Path ($Brand.RegKeyPath))) {
        Write-Host ($Brand.RegKeyPath) " does not exist. Will be created."
        New-Item -Path $RegKeyPath -Force | Out-Null
    }
    IF (!(Get-Item -Path $($Brand.Key))) {
        Write Host $($Brand.Key) " does not exist. Will be created."
        New-ItemProperty -Path $($Brand.RegKeyPath) -Name $($Brand.Key) -Value $($Brand.Value) -PropertyType STRING -Force
    }
    
    $ExistingValue = (Get-Item -Path $($Brand.RegKeyPath)).GetValue($($Brand.Key))
    if ($ExistingValue -ne $($Brand.Value)) {
        Write-Host $($Brand.Key) " not correct value. Will be set."
        Set-ItemProperty -Path $($Brand.RegKeyPath) -Name $($Brand.Key) -Value $($Brand.Value) -Force
    }
    else {
        Write-Host $($Brand.Key) " is correct"
    }
}

Exit 0
