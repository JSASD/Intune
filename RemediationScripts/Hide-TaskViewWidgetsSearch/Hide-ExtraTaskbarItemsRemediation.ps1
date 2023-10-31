# Checks if Widgets button, Task View Button and Search bar are disabled on Windows 11 machines
# JSASD Technology Department

$Version = "v1.1"

$directory = "C:\ProgramData\Hide-TaskbarItems"
if (-not (Test-Path $directory)) {
    New-Item -ItemType Directory -Path $directory
}

function Write-Log {
    param ([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $Message" | Out-File -FilePath "$Directory\Remediation.txt" -Append
}

Write-Log "Starting remediation script $Version"

function Test-RegistryValue {
    param (
        [parameter(Mandatory=$true)]$Path,
        [parameter(Mandatory=$true)]$Value
    )
    
    try {
        Get-ItemProperty -Path $Path | Select-Object -ExpandProperty $Value -ErrorAction Stop | Out-Null
        return $true
    } catch {
        return $false
    }
}

$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion"
$checks = @(
    @{ Path="$regPath\Explorer\Advanced"; Value="ShowTaskViewButton"; Message="Task view hidden." },
    @{ Path="$regPath\Explorer\Advanced"; Value="TaskbarDa"; Message="Widgets button hidden" },
    @{ Path="$regPath\Search"; Value="SearchboxTaskbarMode"; Message="Search Hidden" }
)

foreach ($check in $checks) {
    if (Test-RegistryValue -Path $check.Path -Value $check.Value) {
        if ((Get-ItemProperty -Path $check.Path | Select-Object -ExpandProperty $check.Value) -ne 0) {
            Set-ItemProperty -Path $check.Path -Name $check.Value -Value 0 -Force
            Write-Log $check.Message
        }
    }
}

Write-Log "Remediation script completed successfully, exiting."
