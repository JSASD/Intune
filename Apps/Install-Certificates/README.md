# Install-Certificates
Adds certificates that exist in the `certs` directory to a computer's certificate store. Takes in as many certs as you want.

# Requirements
Script must be run as an *Administrator*.

# Usage
## Variables
Take note of the variables `$version`, `$organization`, and `$packageName` and change them accordingly.

The install script will create registry keys under *HKLM:\SOTWARE\$organization\$packageName*. Change these to match your needs. The detection script will check this location, and uninstall script will remove it.

## Running
Place your desired certificates in their respective subdirectories under `certs`. Run the script.

For example, if you want to install a certificate in the *Trusted Publishers* store, put your cert in `certs\TrustedPublisher`.

# Limitations
Currently does not support `.pfx` files. `certs/**/*.pfx` is included in the `.gitignore` file for potential future use.