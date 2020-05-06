# .Description: Hashes a password and writes username + hash into new ps1 script.
# .Author: Martin Heusser
# .Version: 1.0

$Username = Read-Host "Please enter your username."

$SecureStringPassword = Read-Host "Please enter the password you would like to hash." -AsSecureString

$PasswordHash = $SecureStringPassword | ConvertFrom-SecureString

#$SecurePassword = $PasswordHash | ConvertTo-SecureString

#PwCheck
#$PasswordCheck = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword))

#Write-Host $PasswordCheck

#$Creds = New-Object System.Management.Automation.PSCredential -ArgumentList $Username, $SecurePassword


$WriteScript = '$Username = ' + '"' + $Username + '"' + "`n`n" + '$PasswordHash = ' + '"' + $PasswordHash + '"' + "`n`n" + '$SecurePassword = ' + '$PasswordHash | ConvertTo-SecureString' `
               + "`n`n" + '$Creds = New-Object System.Management.Automation.PSCredential -ArgumentList $Username, $SecurePassword' `
               + "`n`n" + '$PasswordCheck = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword))' `
               + "`n`n" + 'Write-Host $PasswordCheck'

$FileName = "SecureCreds.ps1"

Set-Content .\$FileName $WriteScript

Write-Host "Your password, hashed, written into $FileName and decrypted from said file using account: $env:USERNAME"
& .\SecureCreds.ps1


