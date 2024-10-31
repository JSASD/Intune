# Define paths
$sourceFilePath = ".\3DxWareSetup.xml"
$targetDir = "C:\temp\"
$targetFilePath = Join-Path -Path $targetDir -ChildPath "3DxWareSetup.xml"
$installerPath = ".\3DxWare64_v10-9-1_b650.exe"

# Create target directory if it doesn't exist
if (!(Test-Path -Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force
}

# Copy settings file to target directory
Copy-Item -Path $sourceFilePath -Destination $targetFilePath -Force

# Run the installer with the absolute path to the settings file, using -PassThru and timeout
$process = Start-Process -FilePath $installerPath -ArgumentList "LoadSettings=`"$targetFilePath`" /install /quiet /norestart" -NoNewWindow -PassThru
$process.WaitForExit(300000) # Wait for up to 5 minutes (300,000 ms)

# Clean up: remove the settings file and directory if the process has exited
if ($process.HasExited) {
    if (Test-Path -Path $targetFilePath) {
        Remove-Item -Path $targetFilePath -Force
    }
    
    # Check if the directory is empty, then delete it
    if (Test-Path -Path $targetDir) {
        if ((Get-ChildItem -Path $targetDir | Measure-Object).Count -eq 0) {
            Remove-Item -Path $targetDir -Force -Recurse
        }
    }
} else {
    Write-Output "Installation process exceeded the timeout."
    $process | Stop-Process
}
