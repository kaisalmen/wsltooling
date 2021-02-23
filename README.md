WSL Tooling
===

Welcome to the WSL Tooling repository.

This is a guide for semi-automatic setup and configuration of Ubuntu LTS for Windows Subsystem for Linux.
The aim is to create a development environment that combines the best of both worlds without the need for an extra Virtual machine.


## Preparation
This repository must be available on your local disk.

### Enable Windows Subsystem for Linux V2 support
***This step is only required if WSL support was never activated before on your Windows machine*** 

Open a powershell with administrative privileges and execute:
Run the script to enable WSL and VM paltform on your machine
```powershell
.\enableWSL.ps1
```
This will take a couple of minutes. If it was not enabled before, you need to reboot Windows.

A restart is required if any of the two above features have not been installed before.

Set the default WSL version to 2. Open a powershell with administrative privileges:
```powershell
.\installWSL2.sh
```

## Installation

### Download and Install Ubuntu LTS (20.04)
After reboot, open a new powershell with administrative privileges and install Ubuntu LTS:
```powershell
installUbuntuLTS.ps1
```
It will ask you for a user and a password. This account is not bound to your current Windows account and therefore you can use a separate username and password.


### Further information
It is possible to have different distributions at the same time. Use this [resource from Microsoft](https://docs.microsoft.com/en-us/windows/wsl/wsl-config) as starting point for further reading.

## Configuration
Inside the "Ubuntu 18.04" application change directory to where this repository has been checked out (all Windows drives are available under `/mnt`).
Automatically pre-configure Ubuntu 18.04 with the following script [setupWslUbuntu1804.sh](setupUbuntuLTS.sh):
- It updates the system and removes unnecessary packages afterwards
- It installs OpenJDK-8, Apache maven 3.6.x, node.js LTS from nodesource and makes them available system wide
- It configures dbus for XServer usage including setup of environment variables in `/etc/profile.d`
- It install git, virt-manager and firefox
After the setup is complete and you restarted Ubuntu, Windows drives are available at `/` (e.g. `/c/Windows`).

**Hint:** Firefox does not work properly with remote X. Set `browser.newtab.preload` to `false` in `about:config` to fix this issue."

### Available Scripts
More scripts are available for automated installation and configuration in the [./scripts](./scripts) directory:
- maven ([scripts/install/installMaven.sh](./scripts/install/installMaven.sh))
- Docker to be connected to Docker for Windows ([scripts/install/installDocker.sh](./scripts/install/installDocker.sh))
- nodejs ([scripts/install/installNodejs.sh](./scripts/install/installNodejs.sh)
- Google Chrome (buggy, disabled for now) ([scripts/install/installChrome.sh](./scripts/install/installChrome.sh))
- OpenJDK 8 ([scripts/install/installOpenjdk8.sh](./scripts/install/installOpenjdk8.sh))

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

### Lauch shell scripts
Set WSL as default bash execution:
https://superuser.com/questions/1260528/associating-linux-shell-sh-scripts-on-windows-10-to-bash-or-wsl

### Console Emulator
Use a console emulator like [ConEmu](https://conemu.github.io/) for a better working environment. 

## Known issues
When you use a VPN the wrong primary name resolution host is likely contained in `/etc/resolv.conf`. Comment the home/local address DNS host preventing proper name resolution in the connected VPN network.  


Have fun!

Kai
