# Laptop

[Back](../README.md)

## Navigate

- [Troubleshooting](./troubleshooting.md)

- [Setup zsh](./zsh.md)

- [Install Elm](./elm.md)

- [Install Flutter](./flutter.md)

- [Install Howdy](./howdy.md)

- [Install NordVPN](./nordvpn.md)

- [Install TLP](./tlp.md)

- [Install Vivaldi](./tlp.md)

- [Setup Git](./git.md)

- [Setup SMB Mounts](./smb-mounts.md)

- [Setup Wireguard](./wireguard.md)

- [Setup XDG Directories](./xdg-directories.md)

- [Install MatLab](./matlab.md)

- [Install Windows Programs](./windows-programs.md)

- [Setup Windows 11 VM](./windows.md)

- [Setup dconf Settings](./dconf.md)

- [Setup Secure Boot](./secure-boot.md)

## Laptop Setup

- [Updating Packages](#updating-packages)

- [Installing Packages](#installing-packages)

- [Remove Unwanted GNOME Extensions](#remove-unwanted-gnome-extensions)

- [Configure SSH](#configure-ssh)

- [Configure DNF](#configure-dnf)

- [Create Folders](#create-folders)

### Updating packages

```(shell)
  dnf upgrade
```

### Installing Packages

Install RPM Packages

```(shell)
  sudo dnf install zsh git gnome-boxes wireguard dconf-editor \
                   tlp smartmontools powertop nvtop htop clang \
                   cmake ninja-build gtk3-devel nodejs
```

Remove RPM Packages

```(shell)
  sudo dnf remove totem cheese inkscape rhythmbox eog gnome-characters \
                  gnome-connections gnome-calendar gnome-clocks gnome-contacts \
                  gnome-maps gnome-weather onlyoffice-desktopeditors \
                  power-profiles-daemon vlc
```

Install FlatPak Packages

```(shell)
  sudo flatpak install com.github.eneshecan.WhatsAppForLinux \
                       com.github.IsmaelMartinez.teams_for_linux \
                       com.visualstudio.code cc.arduino.IDE2 \
                       org.gimp.GIMP com.getmailspring.Mailspring \
                       com.github.iwalton3.jellyfin-media-player \
                       com.google.Chrome com.mojang.Minecraft
```

### Remove Unwanted GNOME Extensions

Remove the gnome extensions by removing their folders

```(shell)
cd /usr/share/gnome-shell/extensions

sudo rm -r apps-menu@gnome-shell-extensions.gcompax.github.com
sudo rm -r clipboard-history@alexsaveau.dev
sudo rm -r gamemode@chistian.kellner.me
sudo rm -r gsconnect@andyholmes.github.io
sudo rm -r places-menu@gnome-shell-extensions.gcompax.github.com
sudo rm -r window-list@gnome-shell-extensions.gcompax.github.com
sudo rm -r launch-new-instance@gnome-shell-extensions.gcompax.github.com
sudo rm -r user-theme@gnome-shell-extensions.gcompax.github.com
sudo rm -r just-perfection-desktop@just-perfection
sudo rm -r blur-my-shell@aunetx
sudo rm -r dash-to-dock@micxgx.gmail.com
sudo rm -r pop-shell@system76.com
```

Log out to apply the changes

### Hide Application Desktop Files

Hide some applications from the application list by adding this

```(shell)
NoDisplay=true
```

At the bottom of the desktop files

```(shell)
cd /usr/share/applications

sudo nano unitconv.desktop
sudo nano cgnsview.desktop
sudo nano cgnsplot.desktop
sudo nano cgnsnodes.desktop
sudo nano cgnscalc.desktop

cd ~/.local/share/applications/wine/Programs
```

### Configure SSH

Edit ```/etc/ssh/sshd_config``` to disable password authentication by adding

```(text)
PasswordAuthentication no
```

Generate SSH keys

```(shell)
ssh-keygen -t rsa -b 4096
```

Set the authorized keys for ssh in ```~/.ssh/authorized_keys```.

Restart SSH daemon

```(shell)
systemctl restart sshd
```

### Configure DNF

Edit ```/etc/dnf/dnf.conf``` to set max parallel downloads by adding

```(text)
max_parallel_downloads=10
```

### Remove YUM repos

In the folder ```/etc/yum.repos.d``` remove "onlyoffice" and other unwanted repos.

### Create Folders

Create personal folders for installers, devtools, and projects.

```(shell)
mkdir ~/.install-scripts
mkdir ~/.devtools
mkdir ~/Projects
```

</br>

[Top](#laptop)
