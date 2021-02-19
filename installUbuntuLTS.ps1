curl.exe -L -o .\staging\ubuntuLTS.appx https://aka.ms/wslubuntu2004

del .\staging\ubuntuLTS.zip
del -r .\staging\ubuntuLTS\

mv .\staging\ubuntuLTS.appx .\staging\ubuntuLTS.zip
Expand-Archive .\staging\ubuntuLTS.zip .\staging\ubuntuLTS

.\staging\ubuntuLTS\ubuntu2004.exe
