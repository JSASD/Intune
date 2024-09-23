# Set-AutoLogon
Checks if AutoLogon settings are configured in the Windows registry, and sets them to the desired values if not.

# Requirements
 - Some PowerShell variable knowledge

# Set-AutoLogon.ps1
## Usage
Change the values udner `# CHANGE THE FOLLOWING #`:
 - `$defaultUsername`: Username you want to autologon with
 - `$defaultPassword`: Password you want to autologon with
 - `$defaultDomain`: Your domain name in the format of `company.com`
 - `$logFilePath`: File path to send logs to

# Security notes
**PLEASE NOTE:** This script stores a password in plain text in delivery to the machine and in the Windows registry. Make sure the account being used has no administrative privilege and is not using an important password.

The Jersey Shore Area School District is not responsible for delivery of insecure passwords or vulnerabilities on your systems.