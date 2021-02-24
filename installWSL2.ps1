curl.exe -L -o .\staging\wsl_update_x64.msi https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi
.\staging\wsl_update_x64.msi /quiet
wsl --set-default-version 2
del .\staging\wsl_update_x64.msi
