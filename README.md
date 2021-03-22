Automated creation of WSL 2 Development Machine
===

Welcome to the WSL Tooling repository. The aim of this project is to supply with the ability to autpmatically install a fully working WSL 2 development environment just by invoking a powershell script even without the `wsl --install` flag.

I have fully reworked and updated the whole installation. Once your Windows is capabale of running WSL 2 instances, the Ubuntu LTS WSL 2 installation is fully automatic.


## Preparation
This repository must be clone on your local disk.

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
.\installWSL2.ps1
```

## Installation

### Download and Install Ubuntu LTS (20.04)
If not already done, open a new powershell with administrative privileges and install Ubuntu LTS. You **need** to provide four arguments. If you don't specify them on command line, then the script will ask:
- `<wslName>`: Provide a name for the WSL that is goind to be created (e.g. `devbox`)
- `<wslInstallationPath>`: The directory where the vhdx disk of the new WSL is stored
- `<username>`: the name of the user that is used when WSL distro is launched without `-u`
- `<installAllSoftware>`: Tell if all software packages (see [Available Software](#Available-Software)) shall be installed or if `false` only a fully updated system with configured user is supplied
For example, the command can look as follows:
```powershell
installUbuntuLTS.ps1 devbox D:\WSL2\devbox kai true
```

### Available Software Package
If don't want to install all packages during initial WSL creation, you can install them one buy one. They are available here [./scripts](./scripts). These are currently available
- Ubunut Base Package (git, virt-manager, firefox, dbus-x11, x11-apps, make, unzip) ([scripts/install/installBasePackage.sh](./scripts/install/installBasePackage.sh))
- docker &docker-compose ([scripts/install/installDocker.sh](./scripts/install/installDocker.sh))
- OpenJDK 11 ([scripts/install/installOpenjdk.sh](scripts/install/installOpenjdk.sh))
- Apache Maven ([scripts/install/installMaven.sh](./scripts/install/installMaven.sh))
- Gradle ([scripts/install/installGradle.sh](./scripts/install/installGradle.sh))
- n (node manager), Nodejs, npm & Typescript ([scripts/install/installNodejs.sh](./scripts/install/installNodejs.sh)
- Rust and Cargo ([scripts/install/installRust.sh](./scripts/install/installRust.sh))
- Deno ([scripts/install/installDeno.sh](./scripts/install/installDeno.sh))
- Google Chrome ([scripts/install/installChrome.sh](./scripts/install/installChrome.sh))


Firefox and other tools can be installed directly with Ubuntu's package manager `apt`. Some of the above scripts also use `apt` and apply additional configuration.

#### Removal
Not available yet, but with fast a internet connection and fast SSD you have the WSL recreated in approx. five minutes. :sunglasses:


## Usage

### X-Server
I recommend to use [VcXsrv](https://sourceforge.net/projects/vcxsrv/) (also available via chocolatey) to connect to user interfaces launched from WSL on display 0. The WSL linux setup configures everything properly. Use the following Powershell script to launch (it assume vcxsrv is installed at default location `C:\Program Files\VcXsrv\vcxsrv.exe`):
```powershell
.\scripts\xserver\xerver.ps1
```

### Certificates
Copy any certificates you require under `/usr/local/share/ca-certificates/` and the run the command:
```bash
sudo update-ca-certificates
```

## Misc
- My Terminal recommendation in 2021 clearly is [Microsoft Terminal](https://github.com/microsoft/terminal)
- Overview of [WSL commands and launch configurations](https://docs.microsoft.com/en-us/windows/wsl/wsl-config)
- For Development wiht Visual Studio Code use the `Remote - WSL` extension

Constructive feedback is appreciated!

Have fun!

Kai
