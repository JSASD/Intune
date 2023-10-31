$Version = "v1.1"

<#
Author: Jannik Reinhard (jannikreinhard.com)
Script: Hide-TaskViewWidgetsAndSearchRemediation
Description:
Hite the Task View Widgets and search icons in the task bar

Modified by Quinn Henry for JSASD
#> 

# Custom logging function
function Write-Log {
    param (
        [Parameter(Mandatory=$true)]
        [string] $Message
    )

    $logFilePath = "$($env:ProgramData)\Microsoft\RemoveW11Bloatware\RemoveW11Bloatware.log"
    Add-Content -Path $logFilePath -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss'): $Message"
}

Write-Log -Message "Hide-TaskViewWidgetsAndSearchRemediation.ps1 - $Version"


function Test-RegistryValue {
    param (
     [parameter(Mandatory=$true)]
     [ValidateNotNullOrEmpty()]$Path,
    
    [parameter(Mandatory=$true)]
     [ValidateNotNullOrEmpty()]$Value
    )
    
    try {
        Get-ItemProperty -Path $Path | Select-Object -ExpandProperty $Value -ErrorAction Stop | Out-Null
        return $true
    }catch {
        return $false
    }
}

$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion"
$showTaskViewButton = "ShowTaskViewButton"
$showWidgets = "TaskbarDa"
$showSearch = "SearchboxTaskbarMode"

If(Test-RegistryValue -Path "$regPath\Explorer\Advanced" -Value $showTaskViewButton){
    if((Get-ItemProperty -Path "$regPath\Explorer\Advanced" | Select-Object -ExpandProperty $showTaskViewButton) -ne 0){
        Set-ItemProperty -path "$regPath\Explorer\Advanced" -name $showTaskViewButton -value 0 -Force
    }
}

If(Test-RegistryValue -Path "$regPath\Explorer\Advanced" -Value $showWidgets){
    if((Get-ItemProperty -Path "$regPath\Explorer\Advanced" | Select-Object -ExpandProperty $showWidgets) -ne 0){
        Set-ItemProperty -path "$regPath\Explorer\Advanced" -name $showWidgets -value 0 -Force
    }
}

If(Test-RegistryValue -Path "$regPath\Search" -Value $showSearch){
    if((Get-ItemProperty -Path "$regPath\Search" | Select-Object -ExpandProperty $showSearch) -ne 0){
        Set-ItemProperty -path "$regPath\Search" -name $showSearch -value 0 -Force
    }
}