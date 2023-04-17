# **TLP**

[Back](./README.md)

## **Install TLP**

Install [TLP package](https://linrunner.de/tlp/installation/fedora.html)

```(shell)
dnf install tlp
```

Remove conflicting power-profiles-daemon.

```(shell)
dnf remove power-profiles-daemon
```

## **Configure TLP**

Enable and start TLP service

```(shell)
sudo systemctl enable tlp
sudo systemctl start tlp
```

Copy the template config

```(shell)
cp /etc/tlp.d/00-template.conf /etc/tlp.d/01-config.conf
```

In the config ```/etc/tlp.d/01-config.conf``` edit the settings for power and battery care

```(shell)
RUNTIME_PM_DRIVER_DENYLIST="mei_me"

START_CHARGE_THRESH_BAT0=85
STOP_CHARGE_THRESH_BAT0=90
```

Apply changes made using

```(shell)
sudo tlp start
```
