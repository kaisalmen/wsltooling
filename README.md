WSL Tooling
===

Welcome to the WSL Tooling repository.

Here you a guide for semi-automatic setup and configuration guide for Windows Subsystem for Linux using Ubuntu 18.04.
The aim is to create a development environment that combines the best of both worlds without the need for an extra Virtual machine.


## Installation

### Enable Subsystem for Linux support
Open a powershell with administrative privileges and execute:
```powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```
This will take a couple of minutes. If it was not enabled before, you need to reboot Windows.

### Download and Install Ubuntu 18.04
After reboot, open a new powershell with administrative privileges and download Ubuntu 18.04 with curl:
```powershell
curl.exe -L -o ubuntu-1804.appx https://aka.ms/wsl-ubuntu-1804
```
Install it afterwards by executing the app package directly:
```powershell
.\ubuntu-1804.appx
```
The installation will ask you for a user and a password. This account is not bound to your current Windows account and therefore you can use a separate username and password.

### Further information
It is possible to have different distributions at the same time. Use this [resource from Microsoft](https://docs.microsoft.com/en-us/windows/wsl/wsl-config) as starting point for further reading.

## Configuration
Automatically pre-configure Ubuntu 18.04 with the following script [setupWslUbuntu1804.sh](./setupWslUbuntu1804.sh):
- It updates the system and removes unnecessary packages afterwards
- It configures dbus for XServer usage including setup of environment variables in `/etc/profile.d`.
- It installs OpenJDK-8 and makes it available system wide


### Available Scripts
More scripts are available for automated installation and configuration in the [./scripts](./scripts) directory:
- maven ([scripts/install/installMaven.sh](./scripts/install/installMaven.sh))
- Docker to be connected to Docker for Windows ([scripts/install/installDocker.sh](./scripts/install/installDocker.sh))
- nodejs ([scripts/install/installNodejs.sh](./scripts/install/installNodejs.sh)
- Google Chrome ([scripts/install/installChrome.sh](./scripts/install/installChrome.sh))
- OpenJDK-8 ([scripts/install/installOpenjdk8.sh](./scripts/install/installOpenjdk8.sh))

Firefox and other tools can be installed directly with Ubuntu's package manager `apt`. Some of the above scripts also use `apt` and apply additional configuration.

This list will be expanded in the future.

### Certificates
Copy any certificates you require under `/usr/local/share/ca-certificates/` and the run the command:
```bash
sudo update-ca-certificates
```

## Windows Integration

### X-Server
Use [VcXsrv](https://sourceforge.net/projects/vcxsrv/) to connect to user interfaces launched from WSL on display 0. The setup configures everything properly. Just use the XLaunch in Mulit-Window mode and you are ready to go.
Quickest test is to run Firefox (`sudo apt install firefox` and you are ready to go)

### Lauch shell scripts
Set WSL as default bash execution:
https://superuser.com/questions/1260528/associating-linux-shell-sh-scripts-on-windows-10-to-bash-or-wsl

### Console Emulator
Use a console emulator like [ConEmu](https://conemu.github.io/) for a better working environment. 

## Known issues
When you use a VPN the wrong primary name resolution host is likely contained in `/etc/resolv.conf`. Comment the home/local address DNS host preventing proper name resolution in the connected VPN network.  


Have fun!

Kai
