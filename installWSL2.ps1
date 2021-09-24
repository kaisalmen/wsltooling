# create staging directory if it does not exists
if (-Not (Test-Path -Path .\staging)) { $dir = mkdir .\staging }

curl.exe -L -o .\staging\wsl_update_x64.msi https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi

.\staging\wsl_update_x64.msi /quiet
wsl --set-default-version 2

Remove-Item .\staging\wsl_update_x64.msi
