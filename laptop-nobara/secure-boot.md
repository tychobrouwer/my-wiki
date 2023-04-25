# Secure Boot ([GUIDE](https://sysguides.com/fedora-uefi-secure-boot-with-custom-keys/))

[Back](./README.md)

## Navigate

- [Prepare BIOS](#prepare-bios)

- [Generating Platform Key Pair](#generating-platform-key-pair)

- [Generate Key Exchange Key Pair](#generate-key-exchange-key-pair)

- [Generate Signature Database Key Pair](#generate-signature-database-key-pair)

- [Enroll Keys in Secure Boot Chain](#enroll-keys-in-secure-boot-chain)

- [Sign the Bootloader](#sign-the-bootloader)

- [Sign the Kernel](#sign-the-kernel)

- [Sign the NVIDIA Kernel Modules](#sign-the-nvidia-kernel-modules)

- [Enable Secure Boot](#enable-secure-boot)

- [Kernel Update](#kernel-update)

## Configure Secure Boot

### Prepare BIOS

Run to enter the BIOS

```(shell)
systemctl reboot --firmware-setup
```

In the BIOS go to "Security" > "Secure Boot",

then "Clear All Secure Boot Keys" and ensure the "Secure Boot Mode" is now "Setup Mode"

Also ensure secure boot is disabled and boot back into the OS.

This can be checked with

```(shell)
sudo bootctl status 2>&1 | grep -E 'Secure|Setup'
```

This should return something resembling

```(shell)
Secure Boot: disabled
 Setup Mode: setup
```

### Generating Platform Key Pair

Create the directory for storing the keys

```(shell)
sudo mkdir /keys
sudo cd /keys
```

Create the key config file ```/keys/PK.config```

```(shell)
[ req ]
default_bits           = 4096
prompt                 = no
string_mask            = utf8only
distinguished_name     = req_distinguished_name
x509_extensions        = my_exts

[ req_distinguished_name ]
countryName            = NL
stateOrProvinceName    = PROVINCE
localityName           = COUNTRY
organizationName       = Tycho
commonName             = Tycho Platform Key
emailAddress           = EMAIL

[ my_exts ]
basicConstraints       = critical,CA:FALSE
keyUsage               = digitalSignature
subjectKeyIdentifier   = hash
authorityKeyIdentifier = keyid
subjectAltName         = URI:https://DOMAIN, email:copy
issuerAltName          = issuer:copy
```

Generate the Platform key pair

```(shell)
sudo openssl req -x509 -new -nodes -utf8 \
    -sha256 -days 3650 -batch -config /keys/PK.config \
    -outform PEM -keyout /keys/PK.key -out /keys/PK.crt
```

### Generate Key Exchange Key Pair

Copy the platform key config and change the common name

```(shell)
sudo cp /keys/PK.config /keys/KEK.config
sudo sed -i 's/Platform Key/Key Exchange Key/g' /keys/KEK.config
```

Generate the Key Exchange key pair

```(shell)
sudo openssl req -x509 -new -nodes -utf8 \
    -sha256 -days 3650 -batch -config /keys/KEK.config \
    -outform PEM -keyout /keys/KEK.key -out /keys/KEK.crt
```

### Generate Signature Database Key Pair

Copy the platform key config and change the common name

```(shell)
sudo cp /keys/PK.config /keys/db.config
sudo sed -i 's/Platform Key/Signature Database/g' /keys/db.config
```

Generate the Signature Database key pair

```(shell)
sudo openssl req -x509 -new -nodes -utf8 \
    -sha256 -days 3650 -batch -config /keys/db.config \
    -outform PEM -keyout /keys/db.key -out /keys/db.crt
```

### Enroll Keys in Secure Boot Chain

Set the permissions on the keys

```(shell)
sudo -R chown root:root /keys
sudo chmod 0700 /keys
sudo chmod 0400 /keys/*
```

Sign the PK AUTH file using the PK private key

```(shell)
sudo cert-to-efi-sig-list -g "$GUID" /keys/PK.crt /keys/PK.esl
sudo sign-efi-sig-list \
    -g "$GUID" \
    -t "$(date +'%F %T')" \
    -k /keys/PK.key \
    -c /keys/PK.crt \
    PK \
    /keys/PK.esl \
    /keys/PK.auth
```

Sign the KEK AUTH file using the PK private key

```(shell)
sudo cert-to-efi-sig-list -g "$GUID" /keys/KEK.crt /keys/KEK.esl
sudo sign-efi-sig-list \
    -g "$GUID" \
    -t "$(date +'%F %T')" \
    -k /keys/PK.key \
    -c /keys/PK.crt \
    KEK \
    /keys/KEK.esl \
    /keys/KEK.auth
```

Sign the db AUTH file using the KEK private key

```(shell)
sudo cert-to-efi-sig-list -g "$GUID" /keys/db.crt /keys/db.esl
sudo sign-efi-sig-list \
    -g "$GUID" \
    -t "$(date +'%F %T')" \
    -k /keys/KEK.key \
    -c /keys/KEK.crt \
    db \
    /keys/db.esl \
    /keys/db.auth
```

Ensure the permissions are set correctly for the new files

```(shell)
sudo chmod 0400 /keys/*
```

Enroll the new keys to the firmware

```(shell)
sudo efi-updatevar -f /keys/db.auth db
sudo efi-updatevar -f /keys/KEK.auth KEK
sudo efi-updatevar -f /keys/PK.auth PK
```

The enrollment can be checked using

```(shell)
sudo bootctl status 2>&1 | grep -E 'Secure|Setup'
```

This should return something resembling

```(shell)
Secure Boot: disabled
 Setup Mode: user
```

### Sign the Bootloader

First remove the current signature from the bootloader

```(shell)
sudo pesign --remove-signature --signature-number=0 \
    --in=/boot/efi/EFI/fedora/shimx64.efi \
    --out=/boot/efi/EFI/fedora/shimx64.efi.empty
```

Sign the bootloader with the keys

```(shell)
sudo sbsign --key /keys/db.key --cert /keys/db.crt \
    --output /boot/efi/EFI/fedora/shimx64.efi \
    /boot/efi/EFI/fedora/shimx64.efi.empty
```

Remove the old bootloader

```(shell)
sudo rm /boot/efi/EFI/fedora/shimx64.efi.empty
```

Reboot

### Sign the Kernel

To show the current certificates with which the kernel is signed

```(shell)
sudo pesign --show-signature \
    --in=/boot/vmlinuz-$(uname -r)
```

Sign the kernel with

```(shell)
sudo sbsign --key /keys/db.key --cert /keys/db.crt \
    --output /boot/vmlinuz-$(uname -r) \
    /boot/vmlinuz-$(uname -r)
```

And to show all the certificates with the added certificate

```(shell)
sudo pesign --show-signature \
    --in=/boot/vmlinuz-$(uname -r)
```

### Sign the NVIDIA Kernel Modules

Find the NVIDIA kernel modules with

```(shell)
cd /lib/modules/$(uname -r)/extra
```

Then decompress the kernel modules

```(shell)
sudo unxz nvidia-drm.ko.xz nvidia.ko.xz nvidia-modeset.ko.xz \
    nvidia-peermem.ko.xz nvidia-uvm.ko.xz v4l2loopback/v4l2loopback.ko.xz
```

Then sign the modules with the db keys

```(shell)
/usr/src/kernels/$(uname -r)/scripts/sign-file \
    sha256 /keys/db.key /keys/db.crt nvidia-drm.ko

/usr/src/kernels/$(uname -r)/scripts/sign-file \
    sha256 /keys/db.key /keys/db.crt nvidia.ko

/usr/src/kernels/$(uname -r)/scripts/sign-file \
    sha256 /keys/db.key /keys/db.crt nvidia-modeset.ko

/usr/src/kernels/$(uname -r)/scripts/sign-file \
    sha256 /keys/db.key /keys/db.crt nvidia-peermem.ko

/usr/src/kernels/$(uname -r)/scripts/sign-file \
    sha256 /keys/db.key /keys/db.crt nvidia-uvm.ko

/usr/src/kernels/$(uname -r)/scripts/sign-file \
    sha256 $keypath/db.key $keypath/db.crt /lib/modules/$(uname -r)/extra/v4l2loopback/v4l2loopback.ko

```

And finally compress the modules back

```(shell)
sudo xz nvidia-drm.ko nvidia.ko nvidia-modeset.ko \
    nvidia-peermem.ko nvidia-uvm.ko v4l2loopback/v4l2loopback.ko
```

Check if the modules have been signed with

```(shell)
sudo modinfo -F signer nvidia-drm.ko.xz nvidia.ko.xz nvidia-modeset.ko.xz \
    nvidia-peermem.ko.xz nvidia-uvm.ko.xz v4l2loopback/v4l2loopback.ko.xz
```

### Enable Secure Boot

Enter the BIOS firmware setup with

```(shell)
systemctl reboot --firmware-setup
```

Enable secure boot in the BIOS at "Security" > "Secure Boot"

Boot back into the OS and check if secure boot is enabled with

```(shell)
sudo bootctl status 2>&1 | grep -E 'Secure|Setup'
```

This should output something like

```(shell)
Secure Boot: enabled
 Setup Mode: user
```

### Kernel Update

After a kernel update the new kernel and kernel modules need to be signed.

First disable secure boot and boot into the new kernel to be signed via the grub menu.

To do this repeat the steps to [sign the kernel](#sign-the-kernel) and signing the [kernel modules](#sign-the-nvidia-kernel-modules), this can be done with [this script](./sign-kernel-nvidia.sh) ran as sudo or root.

A temporary workaround would be to boot into the old kernel (which is still signed) in the grub menu.

</br>

[Top](#secure-boot)
