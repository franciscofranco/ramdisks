# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {
kernel.string=Franco Kernel by franciscofranco @ xda-developers
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=1
device.name1=kenzo
device.name2=kate
} # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;

## end setup


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;

# remove darkness
if [ -f $ramdisk/init.darkness.rc ]; then
    rm $ramdisk/init.darkness.rc;
fi

## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;


## AnyKernel install
dump_boot;

# begin ramdisk changes

# init.qcom.rc
insert_line init.qcom.rc "init.fk.rc" before "import init.qcom.usb.rc" "import init.fk.rc";
insert_line init.qcom.rc "performance_profiles" before "import init.qcom.usb.rc" "import init.performance_profiles.rc";
replace_string init.qcom.rc "service msm_irqbal_lb /system/bin/msm_irqbalance -f /sbin/msm_irqbalance.conf" "service msm_irqbal_lb /system/bin/msm_irqbalance -f /system/vendor/etc/msm_irqbalance_little_big.conf" "service msm_irqbal_lb /system/bin/msm_irqbalance -f /sbin/msm_irqbalance.conf";
replace_string init.qcom.rc "service msm_irqbal_lb /vendor/bin/msm_irqbalance -f /sbin/msm_irqbalance.conf" "service msm_irqbal_lb /vendor/bin/msm_irqbalance -f /vendor/etc/msm_irqbalance_little_big.conf" "service msm_irqbal_lb /vendor/bin/msm_irqbalance -f /sbin/msm_irqbalance.conf";
replace_string init.qcom.rc "#start qcom-post-boot" "start qcom-post-boot" "#start qcom-post-boot";
replace_string init.qcom.rc "#start atfwd" "start atfwd" "#start atfwd";
replace_string init.qcom.rc "#start config-zram" "start config-zram" "#start config-zram";

# sepolicy
$bin/magiskpolicy --load sepolicy --save sepolicy \
  "allow init rootfs file execute_no_trans" \
;

# end ramdisk changes

write_boot;

## end install
