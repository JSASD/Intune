$Version = "v1.5"
$ChangesMade = $false
$ScriptFailed = $false

function Write-Log {
    param ([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "[ $timestamp ]   $Message"
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
        Write-Log "Failed to check registry value: $Path\$Value"
        $ScriptFailed = $true
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
            try {
                Set-ItemProperty -Path $check.Path -Name $check.Value -Value 0 -Force
                Write-Log $check.Message
                $ChangesMade = $true
            } catch {
                Write-Log "Failed to set registry value: $check.Path\$check.Value"
                $ScriptFailed = $true
            }
        }
    }
}

if ($ScriptFailed) {
    Write-Log "Script failed."
    exit 1
} elseif ($ChangesMade) {
    Write-Log "Remediation complete, settings modified."
    exit 0
} else {
    Write-Log "Remediation complete, no changes necessary."
    exit 0
}
