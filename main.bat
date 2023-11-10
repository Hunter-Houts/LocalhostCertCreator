'''
This script creates a self-signed certificate for localhost in Windows and adds it to the Trusted Root Certification Authorities certificate store.
'''
@echo off
REM Generate a self-signed certificate (5 year expiration)
powershell.exe -Command "& {$fiveYears = (Get-Date).AddYears(5); $cert = New-SelfSignedCertificate -DnsName 'localhost' -CertStoreLocation 'cert:\LocalMachine\My' -NotAfter $fiveYears; Export-Certificate -Cert $cert -FilePath localhost.crt; Import-Certificate -FilePath localhost.crt -CertStoreLocation 'Cert:\LocalMachine\Root'}"
