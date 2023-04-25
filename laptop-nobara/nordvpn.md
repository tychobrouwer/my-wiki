# NordVPN

[Back](./README.md)

## Install NordVPN

Install NordVPN using [instructions](https://support.nordvpn.com/Connectivity/Linux/1325531132/Installing-and-using-NordVPN-on-Debian-Ubuntu-Raspberry-Pi-Elementary-OS-and-Linux-Mint.htm).

Get NordVPN installer

```(shell)
wget -O ~/.install-scripts/install_nordvpn.sh \
    https://downloads.nordcdn.com/apps/linux/install.sh
```

Run installer

```(shell)
chmod +x ~/.install-scripts/install_nordvpn.sh

~/.install-scripts/install_nordvpn.sh
```

Add user to nordvpn group to allow the user to use nordvpn without sudo.

```(shell)
usermod -a -G nordvpn tycho 
```

## Log Into NordVPN

Log into NordVPN with the command line [callback feature](https://www.reddit.com/r/nordvpn/comments/rp59mn/log_in_to_nordvpn_in_the_terminal/).

```(shell)
nordvpn login
```

Then paste the link of the "Continue" button into the following command.

```(shell)
nordvpn login --callback "nordvpn://link"
```

## Connect to Server

Connect to a NordVPN [server](https://nordvpn.com/servers/tools/).

```(shell)
nordvpn connect nl892
nordvpn connect us8380
```
