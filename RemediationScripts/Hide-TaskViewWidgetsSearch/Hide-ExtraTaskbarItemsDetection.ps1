# Hides Widgets button, Task View Button and Search bar on Windows 11 machines
# JSASD Technology Department

$Version = "v1.1"

$directory = "C:\ProgramData\Hide-TaskbarItems"
if (-not (Test-Path $directory)) {
    New-Item -ItemType Directory -Path $directory
}

function Write-Log {
    param ([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $Message" | Out-File -FilePath "$Directory\Detection.txt" -Append
}

Write-Log "Starting detection script $Version"

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
    @{ Path="$regPath\Explorer\Advanced"; Value="ShowTaskViewButton"; Message="Show Task View Button is active" },
    @{ Path="$regPath\Explorer\Advanced"; Value="TaskbarDa"; Message="Show Widgets is active" },
    @{ Path="$regPath\Search"; Value="SearchboxTaskbarMode"; Message="Show Search Button is active" }
)

$exitCode = 0

foreach ($check in $checks) {
    if (Test-RegistryValue -Path $check.Path -Value $check.Value) {
        if ((Get-ItemProperty -Path $check.Path | Select-Object -ExpandProperty $check.Value) -ne 0) {
            Write-Log $check.Message
            $exitCode = 1
        }
    }
}

if ($exitCode -eq 1) {
    Write-Log "At least one feature is active, exiting as unsuccessful..."
    exit 1
} else {
    Write-Log "None are found, exiting as successful..."
    exit 0
}
