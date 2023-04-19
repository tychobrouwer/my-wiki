# Proxmox VE

[Back](./README.md)

## Navigate

- [Disable Services](#disable-services)

- [Install Packages](#install-packages)

- [Setup Email Notifications](#setup-email-notifications)

- [Setup iCloud Photo Downloader](#setup-icloud-photo-downloader)

- [Disable Subscription Warning](#disable-subscription-warning)

- [Configurations for SMB](#configurations-for-smb)

- [Setup Proxmox Backup Client](#setup-proxmox-backup-client)

- [Installing NVIDIA Drivers](#installing-nvidia-drivers)

## Configure Proxmox

### Disable Services

Disable HA (High Availability) and other services to reduce disk writes from logging.

- pve-ha-lrm
- pve-ha-crm
- pvesr.timer
- corosync.service

```(shell)
systemctl stop "service"
systemctl disable "service"
```

### Install Packages

- neofeth
- htop
- iotop
- ifupdown2

```(shell)
apt install "service"
```

### Setup Email Notifications

Install the necessary packages

- libsasl2-modules
- mailutils

Set the credentials for postfix in ```/etc/postfix/sasl_passwd``` to

#### Gmail

```(shell)
smtp.gmail.com "EMAIL":"PASSWORD"
```

Create the hash database for postfix

```(shell)
postmap hash:/etc/postfix/sasl_passwd
```

Configure postfix by adding to ```/etc/postfix/main.cf```

```(shell)
relayhost = smtp.gmail.com:587
smtp_use_tls = yes
smtp_sasl_auth_enable = yes
smtp_sasl_security_options =
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_tls_CAfile = /etc/ssl/certs/Entrust_Root_Certification_Authority.pem
smtp_tls_session_cache_database = btree:/var/lib/postfix/smtp_tls_session_cache
smtp_tls_session_cache_timeout = 3600s
```

Reload Postfix

```(shell)
postfix reload
```

### Setup iCloud Photo Downloader

Install [iCloudPD](https://github.com/icloud-photos-downloader/icloud_photos_downloader) for syncing iCloud photo library using pip

```(shell)
pip3 install icloudpd
```

Synchronize photos

```(shell)
icloudpd -d /share/file-share/Pictures/ -u "EMAIL" -p "PASSWORD" \
    --folder-structure {:%Y/%m} \
    --recent 200 \
    --auto-delete
chown -R shareuser:sharegroup /media/file-share/Pictures
```

### Disable Subscription Warning

Change in ```/usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js```

```(javascript)
Ext.Msg.show({
  title: gettext('No valid subscription'),
```

to

```(javascript)
void({ //Ext.Msg.show({
  title: gettext('No valid subscription'),
```

Restart pveproxy to take affect

```(shell)
systemctl restart pveproxy
```

### Configurations for PBS

Create PBS user

```(shell)
groupadd -g 3510 pbsuser
useradd -u 1010 -g pbsuser pbsuser
```

Ensure backup directory is present

```(shell)
mkdir /mnt/data1/pbs-dumps
```

### Configurations for SMB

Create user and group for SMB

```(shell)
groupadd -g 3500 sharegroup
groupadd -g 3501 shareuser
useradd -u 1000 -g shareuser -G sharegroup shareuser

usermod -a -G sharegroup root
```

Create SMB directories

```(shell)
mkdir /media
mkdir /media/file-share
mkdir /mnt/data0/video-share

chown -R shareuser:sharegroup /media/file-share
chown -R shareuser:sharegroup /mnt/data0/video-share
```

### Setup Proxmox Backup Client

Install PBS repository by adding the repository in ```/etc/apt/sources.list```

```(shell)
deb http://download.proxmox.com/debian/pbs-client bullseye main
```

Install PBC (Proxmox Backup Client) with apt

```(shell)
wget -qO - http://download.proxmox.com/debian/proxmox-release-bullseye.gpg | sudo apt-key add -
apt update && apt install proxmox-backup-client

usermod -a -G sharegroup backup
```

Create a shell script for backing up certain directories

```(shell)
#!/bin/sh
export PBS_PASSWORD="PBS_PASSWORD"
export PBS_FINGERPRINT="PBS_FINGERPRINT"
export PBS_LOG="warn"
export PXAR_LOG="warn"

/usr/bin/proxmox-backup-client backup \
    file-share.pxar:/media/file-share \
    lxc-config.pxar:/etc/pve/lxc \
    --repository root@pam@192.168.178.108:main
```

Create a cron job by adding to ```/var/spool/cron/crontabs/root```

```(shell)
0 2,8,17,22 * * * /root/pbs-proxmox-backup.sh
```

### Installing NVIDIA Drivers

Used [guide](https://theorangeone.net/posts/lxc-nvidia-gpu-passthrough/).

Install proxmox headers

```(shell)
apt install pve-headers-$(uname -r)
```

Download the NVIDIA drivers from the [website](https://www.nvidia.com/en-us/drivers/unix/), installing this way ensures version compatibility between the host and containers.

```(shell)
wget -O ~/NVIDIA-Linux-x86_64-525.89.02.run \
    https://us.download.nvidia.com/XFree86/Linux-x86_64/525.89.02/NVIDIA-Linux-x86_64-525.89.02.run
```

Run the installer

```(shell)
~/NVIDIA-Linux-x86_64-525.89.02.run -asq
```

Create udev rules for the driver by creating ```/etc/udev/70-nvidia.rules``` with the contents

```(shell)
KERNEL=="nvidia", RUN+="/bin/bash -c '/usr/bin/nvidia-smi -L && /bin/chmod 666 /dev/nvidia*'"
KERNEL=="nvidia_uvm", RUN+="/bin/bash -c '/usr/bin/nvidia-modprobe -c0 -u && /bin/chmod 0666 /dev/nvidia-uvm*'"
```

Add the nvidia modules to the loaded modules at boot in ```/etc/modules-load.d/modules.conf``` by adding

```(shell)
nvidia
nvidia_uvm
```

Update the initramfs image

```(shell)
update-initramfs -u
```

</br>

[Top](#proxmox-ve)
