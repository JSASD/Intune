<#
    .SYNOPSIS 
    Change Workgroup to Azure AD tenant name

    .DESCRIPTION
    Install:   C:\Windows\SysNative\WindowsPowershell\v1.0\PowerShell.exe -ExecutionPolicy Bypass -Command .\remediation.ps1
    
    .ENVIRONMENT
    PowerShell 5.0
    
    .AUTHOR
    Niklas Rast // JSASD Technology Department
#>

#Get AAD Tenant ID
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\CloudDomainJoin\TenantInfo"
$TenantInfoPath = (Get-ChildItem -Path $regPath).Name
$parentPart = Split-Path $TenantInfoPath -Parent
$EntraTenantID = Split-Path $TenantInfoPath -Leaf

#Get AAD Name
$EntraName = (Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\CloudDomainJoin\TenantInfo\$EntraTenantID" -Name DisplayName).DisplayName

#Install Customer Workgroup
Add-Computer -WorkGroupName "$EntraName"