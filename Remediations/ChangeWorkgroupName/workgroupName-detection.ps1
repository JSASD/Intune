<#
    .SYNOPSIS 
    Change Workgroup to Azure AD tenant name

    .DESCRIPTION
    Install:   C:\Windows\SysNative\WindowsPowershell\v1.0\PowerShell.exe -ExecutionPolicy Bypass -Command .\detection.ps1
    
    .ENVIRONMENT
    PowerShell 5.0
    
    .AUTHOR
    Niklas Rast // JSASD Technology Department
#>

#Get AAD Tenant ID and Name
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\CloudDomainJoin\TenantInfo"
$TenantInfoPath = (Get-ChildItem -Path $regPath).Name
$parentPart = Split-Path $TenantInfoPath -Parent
$AADTenantID = Split-Path $TenantInfoPath -Leaf
$AADName = (Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\CloudDomainJoin\TenantInfo\$AADTenantID" -Name DisplayName).DisplayName

$CurrentWorkgroupName = (Get-WmiObject -Class Win32_ComputerSystem).Domain

if($CurrentWorkgroupName -ne $AADName){
    return 0
}else{
    return 1
}
