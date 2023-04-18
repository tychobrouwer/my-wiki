# **SMB Mounts**

[Back](./README.md)

## **Configure SMB**

Set correct file permissions on mount file

```(shell)
chmod 4755 /usr/sbin/mount.cifs
```

Create cifs password file ```/etc/cifspasswd``` with the contents

```(shell)
username=SAMBA_USER
password=SAMBA_PASSWORD
```

Set owner to root

```(shell)
chown root:root /etc/cifspasswd
```

## **Create Mounts**

Create mount folders

```(shell)
mkdir /mnt/file_share
mkdir /mnt/video_share
mkdir /home/tychob/School
```

Create mount service for the file share ```/etc/systemd/system/mnt-file_share.mount```

```(shell)
[Unit]
Description=file share mount point
RequiresMountsFor=/mnt
Requires=NetworkManager.service dbus.service wpa_supplicant.service
After=NetworkManager.service dbus.service wpa_supplicant.service

[Mount]
What=//192.168.178.104/file_share/
Where=/mnt/file_share
Type=cifs
Options=uid=tychob,gid=tychob,_netdev,nofail,credentials=/etc/cifspasswd
TimeoutSec=10

[Install]
WantedBy=multi-user.target
```

Create mount service for the media share ```/etc/systemd/system/mnt-video_share.mount```

```(shell)
[Unit]
Description=video share mount point
RequiresMountsFor=/mnt
Requires=NetworkManager.service dbus.service wpa_supplicant.service
After=NetworkManager.service dbus.service wpa_supplicant.service

[Mount]
What=//192.168.178.104/video_share/
Where=/mnt/video_share
Type=cifs
Options=uid=tychob,gid=tychob,_netdev,nofail,credentials=/etc/cifspasswd
TimeoutSec=10

[Install]
WantedBy=multi-user.target
```

Create mount service for the school folder ```/etc/systemd/system/home-tychob-School.mount```

```(shell)
[Unit]
Description=school share mount point
RequiresMountsFor=/home/tychob
Requires=NetworkManager.service dbus.service wpa_supplicant.service
After=NetworkManager.service dbus.service wpa_supplicant.service

[Mount]
What=//192.168.178.104/file_share/School
Where=/home/tychob/School
Type=cifs
Options=uid=tychob,gid=tychob,_netdev,nofail,credentials=/etc/cifspasswd
TimeoutSec=10

[Install]
WantedBy=multi-user.target
```

</br>

[Top](#smb-mounts)
