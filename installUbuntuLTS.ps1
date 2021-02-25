Param (
[Parameter(Mandatory=$True)]
[ValidateNotNull()]
[string]$wslName,
[Parameter(Mandatory=$True)]
[ValidateNotNull()]
[string]$wslInstallationPath,
[Parameter(Mandatory=$True)]
[ValidateNotNull()]
[string]$username
)

curl.exe -L -o .\staging\ubuntuLTS.appx https://aka.ms/wslubuntu2004

Move-Item .\staging\ubuntuLTS.appx .\staging\$wslName.zip
Expand-Archive .\staging\$wslName.zip .\staging\$wslName

if (-Not (Test-Path -Path $wslInstallationPath)) {
    mkdir $wslInstallationPath
}
wsl --import $wslName $wslInstallationPath .\staging\$wslName\install.tar.gz

Remove-Item .\staging\$wslName.zip
Remove-Item -r .\staging\$wslName\

# Update the system
wsl -d $wslName -u root -e scripts/install/installBasePackages.sh

# create your user and add it to sudoers
wsl -d $wslName -u root -e scripts/config/system/createUser.sh $username

# ensure WSL Distro is restarted when first used with user account
wsl -t $wslName

wsl -d $wslName -u $username -e ./installSoftware.sh
