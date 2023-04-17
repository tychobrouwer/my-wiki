# **Howdy**

[Back](./README.md)

## **Navigate**

- [Install Howdy](#install-howdy)

- [Enable IR Emitter](#enable-ir-emitter)

- [Enable Howdy for sudo](#enable-howdy-for-sudo)

- [Enable Howdy for GDM](#enable-howdy-for-gdm)

## Install and Configure Howdy

### **Install Howdy**

Install [Howdy](https://github.com/boltgolt/howdy) from principis/howdy.

```(shell)
sudo dnf copr enable principis/howdy
sudo dnf --refresh install howdy
```

### **Configure Howdy**

Change the config file for Howdy, open with ```sudo howdy config```.

```(ini)
[core]
detection_notice = false
no_conformation = true

[video]
certainty = 4
timeout = 2
device_path = /dev/video2
max_height = 200
dark_threshold = 70
```

Add faces to howdy with

```(shell)
sudo howdy add
```

### **Enable IR Emitter**

Get [linux-enable-ir-emitter](https://github.com/EmixamPP/linux-enable-ir-emitter)

```(shell)
wget -O ~/.install-scripts \
    https://github.com/EmixamPP/linux-enable-ir-emitter/releases/download/4.5.0/linux-enable-ir-emitter-4.5.0.tar.gz
```

Install linux-enable-ir-emitter into correct directories.

```(shell)
sudo tar -C / --no-same-owner -h -xzf \
    ~/.install-scripts/linux-enable-ir-emitter-4.5.0.tar.gz
```

Enable the IR Emitter

```(shell)
sudo linux-enable-ir-emitter configure
```

### **Enable Howdy for sudo**

Edit ```/etc/pam.d/sudo``` to add the following as the first entry

```(shell)
auth       sufficient   pam_python.so /lib64/security/howdy/pam.py
```

### **Enable Howdy for GDM**

Edit ```/etc/pam.d/gdm-password``` to add the following

```(shell)
auth        sufficient    pam_python.so /lib64/security/howdy/pam.py
```

after the line

```(shell)
auth     [success=done ignore=ignore default=bad] pam_selinux_permit.so
```

</br>

[Top](#howdy)
