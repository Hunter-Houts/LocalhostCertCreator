#!/bin/bash

# Check if openssl is installed
if ! command -v openssl &> /dev/null; then
    echo "openssl could not be found"
    exit
fi

# Function to generate a self-signed certificate for Linux and Mac
generate_cert() {
    openssl req -x509 -out localhost.crt -keyout localhost.key \
      -newkey rsa:2048 -nodes -sha256 \
      -subj '/CN=localhost' -extensions EXT -config <( \
       printf "[dn]\nCN=localhost\n[req]\n\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")
}

# Check OS and execute relevant commands
case "$OSTYPE" in 
  "linux-gnu"*)
    echo "OS: Linux"
    generate_cert
    # Copy the certificate to the trusted store and update the certificate store
    sudo cp localhost.crt /usr/local/share/ca-certificates/
    sudo update-ca-certificates
    ;;
  "darwin"*)
    echo "OS: Mac"
    generate_cert
    # Add the certificate to keychain
    sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain localhost.crt
    ;;
  "cygwin"|"msys"|"win32"|"MINGW64_NT-10.0-22621")
    echo "OS: Windows"
    powershell.exe -Command "& {$cert = New-SelfSignedCertificate -DnsName 'localhost' -CertStoreLocation 'cert:\LocalMachine\My'; Export-Certificate -Cert $cert -FilePath localhost.crt; Import-Certificate -FilePath localhost.crt -CertStoreLocation 'Cert:\LocalMachine\Root'}"
    ;;
  *)
    echo "Unknown OS"
    ;;
esac

