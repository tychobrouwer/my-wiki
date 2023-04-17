# **Laptop**

[Back](../README.md)

## **Navigate**

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

- [Setup ZSH](./zsh.md)

- [Install MatLab](./matlab.md)

- [Install Windows Programs](./windows-programs.md)

- [Setup dconf Settings](./dconf.md)

- [Setup Secure Boot](./secure-boot.md)

## **Laptop Setup**

- [Updating Packages](#updating-packages)

- [Installing Packages](#installing-packages)

- [Configure SSH](#configure-ssh)

- [Configure DNF](#configure-dnf)

- [Create Folders](#create-folders)

### **Updating packages**

```(shell)
  dnf upgrade
```

### **Installing Packages**

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

### **Configure SSH**

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

### **Configure DNF**

Edit ```/etc/dnf/dnf.conf``` to set max parallel downloads by adding

```(text)
max_parallel_downloads=10
```

### **Remove YUM repos**

In the folder ```/etc/yum.repos.d``` remove "onlyoffice" and other unwanted repos.

### **Create Folders**

Create personal folders for installers, devtools, and projects.

```(shell)
mkdir ~/.install-scripts
mkdir ~/.devtools
mkdir ~/Projects
```

</br>

[Top](#laptop)
