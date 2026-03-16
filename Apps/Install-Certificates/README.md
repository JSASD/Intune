# Install-Certificates
Adds certificates that exist in the `certs` directory to a computer's certificate store. Takes in as many certs as you want.

# Requirements
Script must be run as an *Administrator*.

# Usage
Place your desired certificates in their respective subdirectories under `certs`. Run the script.

For example, if you want to install a certificate in the *Trusted Publishers* store, put your cert in `certs\TrustedPublisher`.

# Limitations
Currently does not support `.pfx` files. `certs/**/*.pfx` is included in the `.gitignore` file for potential future use.