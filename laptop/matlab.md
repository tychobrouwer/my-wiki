# **MATLAB**

[Back](./README.md)

## **Install MATLAB**

Get installer from <https://nl.mathworks.com/downloads/>

Unzip the downloaded archive

```(shell)
unzip ~/.install-scripts/matlab_R2022a_glnxa64.zip -d ~/.install-scripts/matlab
```

Install MATLAB

```(shell)
cd ~/.install-scripts/matlab
sudo ./install
```

Install the necessary addons and ensure symbolic links are created

## **Installing Addons**

To allow for adding addons in the future without running the installer again change the permissions of the MATLAB folder

```(shell)
sudo chown -R tychob:tychob /usr/local/MATLAB
```

## **Application Icon**

Add the desktop file ```/usr/share/applications/matlab.desktop``` to get a shortcut in the application list

```(shell)
[Desktop Entry]
Version=1.0
Type=Application
Name=MATLAB R2023a
Icon=matlab
Path=/home/tychob
Exec=/usr/local/MATLAB/R2023a/bin/glnxa64/MATLAB -desktop -prefersoftwareopengl
Terminal=false
Categories=Development;Math;Science;Education;
```

If necessary update the permissions of the desktop file

```(shell)
chmod +x /usr/share/applications/matlab.desktop
```
