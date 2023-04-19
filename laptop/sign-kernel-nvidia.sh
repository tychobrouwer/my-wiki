#!/bin/bash
# A script to sign the kernel and the NVIDIA kernel modules

read -p 'Key directory path: ' keypath

# Sign the kernel with the db key
sbsign --key $keypath/db.key --cert $keypath/db.crt --output /boot/vmlinuz-$(uname -r) /boot/vmlinuz-$(uname -r)

# Unzip the NVIDIA kernel modules
unxz /lib/modules/$(uname -r)/extra/nvidia-drm.ko.xz
unxz /lib/modules/$(uname -r)/extra/nvidia.ko.xz 
unxz /lib/modules/$(uname -r)/extra/nvidia-modeset.ko.xz
unxz /lib/modules/$(uname -r)/extra/nvidia-peermem.ko.xz
unxz /lib/modules/$(uname -r)/extra/nvidia-uvm.ko.xz

# Sign the NVIDIA kernel modules with the db key
/usr/src/kernels/$(uname -r)/scripts/sign-file sha256 $keypath/db.key $keypath/db.crt /lib/modules/$(uname -r)/extra/nvidia-drm.ko

/usr/src/kernels/$(uname -r)/scripts/sign-file sha256 $keypath/db.key $keypath/db.crt /lib/modules/$(uname -r)/extra/nvidia.ko

/usr/src/kernels/$(uname -r)/scripts/sign-file sha256 $keypath/db.key $keypath/db.crt /lib/modules/$(uname -r)/extra/nvidia-modeset.ko

/usr/src/kernels/$(uname -r)/scripts/sign-file sha256 $keypath/db.key $keypath/db.crt /lib/modules/$(uname -r)/extra/nvidia-peermem.ko

/usr/src/kernels/$(uname -r)/scripts/sign-file sha256 $keypath/db.key $keypath/db.crt /lib/modules/$(uname -r)/extra/nvidia-uvm.ko

# Rezip the NVIDIA kernel modules`
xz /lib/modules/$(uname -r)/extra/nvidia-drm.ko
xz /lib/modules/$(uname -r)/extra/nvidia.ko
xz /lib/modules/$(uname -r)/extra/nvidia-modeset.ko
xz /lib/modules/$(uname -r)/extra/nvidia-peermem.ko
xz /lib/modules/$(uname -r)/extra/nvidia-uvm.ko
