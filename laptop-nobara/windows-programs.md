# Windows Programs

[Back](./README.md)

## Windows Installers

Get the windows installers

```(shell)
wget -O ~/.install-scripts/wargaming.exe \
    https://redirect.wargaming.net/WGC/Wargaming_Game_Center_Install_EU.exe

wget -O ~/.install-scripts/ubisoft.exe https://ubi.li/4vxt9
```

## Wine Method

Run the instalers using wine

```(shell)
wine ~/.install-scripts/wargaming.exe
wine ~/.install-scripts/ubisoft.exe
```

Install Fonts via Winetricks

Open Winetricks > "Select the default wineprefix" > "Install a font"

Install the desired fonts, multiple tries may be necessary if it fails

## Bottles Method

Install Bottles via Flatpak

```(shell)
flatpak install com.usebottles.bottles
```

Create bottle with the gaming environment

In the settings for the bottle enable the following features

```(shell)
Deep Learning Super Sampling
FidelityFX Super Resolution
Discrete Graphics
```

And select ```Fsync``` for synchronization, other options may work better for some games.

In the dependencies install the required dependencies for the program which is going to run in the bottle.

For most cases ```allfonts``` is the only one necessary to install manually.

Finally, run the Windows executable in the bottle and install the software.
