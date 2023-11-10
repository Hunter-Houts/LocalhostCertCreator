# Bash Script for Creating Self-Signed Certificates

This script checks the operating system and creates a self-signed certificate for localhost. It supports Linux, MacOS, and Windows.

## Dependencies

1. **Bash shell**: This is the environment where the script will run. It is pre-installed on most Unix-like operating systems, including Linux and MacOS. For Windows, it can be installed via Cygwin or Windows Subsystem for Linux (WSL).

2. **OpenSSL**: This is used to generate the self-signed certificates. It can be installed via the system's package manager (e.g., apt for Ubuntu, brew for MacOS, or Chocolatey for Windows).

3. **PowerShell**: This is used in the Windows part of the script. It is pre-installed on modern Windows systems.

## Installation Instructions

### Bash Shell
Bash shell is pre-installed on most Unix-like operating systems. For Windows, you can install it via Cygwin or Windows Subsystem for Linux (WSL).

### OpenSSL
- Ubuntu: `sudo apt-get install openssl`
- MacOS: `brew install openssl`
- Windows: Install via Chocolatey or download from the OpenSSL website.

### PowerShell
PowerShell is pre-installed on modern Windows systems. If necessary, it can be downloaded from the Microsoft website.

## Usage

1. Download the script `main.sh` or `main.bat` depending on your operating system.
2. Open a terminal (or command prompt in Windows).
3. Navigate to the directory where you downloaded the script.
4. Run the script:
   - For Linux/MacOS: `bash main.sh` (You may have to chmod +x main.sh)
   - For Windows: `main.bat`
5. The script will check your operating system and generate a self-signed certificate for localhost. If you're on MacOS, it will also add the certificate to your keychain.
6. If the script runs successfully, you should see a message indicating the operating system and a `localhost.crt` file in your current directory. This is your self-signed certificate.

## Check for cert

- MacOS: `security find-certificate -a -c "localhost" -p /Library/Keychains/System.keychain`
- Linux: `ls /usr/local/share/ca-certificates/localhost.crt` `trust list --filter=certificates | grep 'localhost'`
- Windows: (In **Powershell**)  `Get-ChildItem -Path Cert:\LocalMachine\Root | Where-Object { $_.Subject -like "*localhost*" }`

## Remove cert

- Linux: `sudo rm /usr/local/share/ca-certificates/localhost.crt` `sudo update-ca-certificates`
- MacOS: `sudo security delete-certificate -c "localhost" /Library/Keychains/System.keychain`
- Windows: (**Powershell as admin**) `Get-ChildItem -Path Cert:\LocalMachine\Root | Where-Object { $_.Subject -like "*localhost*" } | Remove-Item`
