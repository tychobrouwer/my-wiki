# Windows Programs

[Back](./README.md)

## Windows Installers

Get the windows installers

```(shell)
wget -O ~/.install-scripts/wargaming.exe \
    https://redirect.wargaming.net/WGC/Wargaming_Game_Center_Install_EU.exe

wget -O ~/.install-scripts/ubisoft.exe https://ubi.li/4vxt9
```

Run the instalers using wine

```(shell)
wine ~/.install-scripts/wargaming.exe
wine ~/.install-scripts/ubisoft.exe
```

## Install Fonts

Open Winetricks > "Select the default wineprefix" > "Install a font"

Install the desired fonts, multiple tries may be necessary if it fails
