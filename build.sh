#!/bin/bash
KERNEL=$(ls /boot/vmlinuz-*-generic | head -n 1)
sudo cp $KERNEL build/vmlinuz
cp /bin/busybox rootfs/bin/
cd rootfs/bin
for cmd in $(./busybox --list); do ln -sf busybox $cmd; done
cd ../..
cp init rootfs/init
chmod +x rootfs/init
cd rootfs
find . | cpio -H newc -o | gzip > ../build/initrd.gz
cd ..
cp syslinux.cfg build/isolinux/isolinux.cfg
cp /usr/lib/ISOLINUX/isolinux.bin build/isolinux/
cp /usr/lib/syslinux/modules/bios/ldlinux.c32 build/isolinux/
xorriso -as mkisofs -o build/GameForgeOS.iso \
  -b isolinux/isolinux.bin \
  -c isolinux/boot.cat \
  -no-emul-boot -boot-load-size 4 -boot-info-table build
