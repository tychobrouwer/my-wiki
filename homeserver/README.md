# Home Server

[Back](../README.md)

## Navigate

- [Proxmox VE](./proxmox.md)

- [Pi-Hole](./pi-hole.md)

- [Wireguard](./wireguard.md)

- [Portainer](./portainer.md)

- [SMB Share](./portainer.md)

- [Torrent](./portainer.md)

- [Lighttpd Website](./lighttpd-website.md)

- [Media Manager](./media-manager.md)

- [Backup Server](./backup-server.md)

- [Jellyfin](./jellyfin.md)

- [Factorio Server](./factorio-server.md)

- [Minecraft Server](./minecraft-server.md)

- [Ark Survival Server](./ark-survival-server.md)

## Server Initialization

- [Updating Packages](#updating-packages)

- [Installing Packages](#installing-packages)

- [Configure SSH](#configure-ssh)

- [Updating Packages](#updating-packages)

- [Configure Git](#configure-git)

### Updating packages

#### Debian

```(shell)
  apt update && apt upgrade
```

#### Fedora

```(shell)
  dnf upgrade
```

#### Arch

```(shell)
pacman -Syu
```

### Installing Packages

- git
- python3
- python3-pip
- openssh-server
- net-tools

#### Debian

```(shell)
  apt update && apt install "package"
```

#### Fedora

```(shell)
  dnf install "package"
```

#### Arch

```(shell)
  pacman -S "package"
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

### Configure Git

Set the Git variables

```(shell)
git config --global user.name "FIRST_NAME LAST_NAME"
git config --global user.email "EMAIL"
```

Set the default Git branch to main

```(shell)
git config --global init.defaultBranch main
```

</br>

[Top](#home-server)
