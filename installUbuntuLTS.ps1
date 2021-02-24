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

mv .\staging\ubuntuLTS.appx .\staging\$wslName.zip
Expand-Archive .\staging\$wslName.zip .\staging\$wslName

if (-Not (Test-Path -Path $wslInstallationPath)) {
    mkdir $wslInstallationPath
}
wsl --import $wslName $wslInstallationPath .\staging\$wslName\install.tar.gz

del .\staging\$wslName.zip
del -r .\staging\$wslName\

# Update the system
wsl -d $wslName -- apt update
wsl -d $wslName -- apt upgrade -y

# install git and other applications useful for the environment
wsl -d $wslName -- apt install -y git virt-manager firefox dbus-x11 x11-apps make

# create your user and add to sudo
wsl -d $wslName -e scripts/install/createUser.sh $username

# ensure WSL Distro is restarted when first used with user
wsl -t $wslName
