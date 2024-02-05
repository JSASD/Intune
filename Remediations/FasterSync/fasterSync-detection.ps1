<#
    .SYNOPSIS 
    Fixes the 8-hour wait period for Sharepoint folder syncing to take effect

    .DESCRIPTION
    Install:   C:\Windows\SysNative\WindowsPowershell\v1.0\PowerShell.exe -ExecutionPolicy Bypass -Command .\detection.ps1
    
    .ENVIRONMENT
    PowerShell 5.0
    
    .AUTHOR
    Niklas Rast // JSASD Technology Department
#>

$RegPath = "HKCU:\SOFTWARE\Microsoft\OneDrive\Accounts\Business1"
$KeyName = "TimerAutoMount"
$Value = 1

Try {
    $Reg = Get-ItemProperty -Path $RegPath -Name $KeyName -ErrorAction Stop | Select-Object -ExpandProperty $KeyName
    If ($Reg -eq $Value){
        Exit 0
    } 
    Exit 1
} 
Catch {
    Exit 1
}