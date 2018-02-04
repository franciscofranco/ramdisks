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
device.name1=mido
device.name2=Redmi Note 4
device.name3=Redmi Note 4x
device.name4=HMNote4x
device.name5=Redmi Note 4X
} # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;

## end setup


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;

## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;


## AnyKernel install
dump_boot;

# begin ramdisk changes

# init.rc
insert_line fstab.qcom "/dev/block/zram0" after "/dev/block/bootdevice/by-name/config		/frp			emmc	defaults							defaults" "/dev/block/zram0                                        none                swap    defaults                    zramsize=536870912,max_comp_streams=4"
insert_line init.rc "init.fk.rc" before "import /init.usb.rc" "import /init.fk.rc";
insert_line init.rc "performance_profiles" before "import /init.usb.rc" "import /init.performance_profiles.rc";

# replace_string init.qcom.rc "service msm_irqbal_lb /system/bin/msm_irqbalance -f /sbin/msm_irqbalance.conf" "service msm_irqbal_lb /system/bin/msm_irqbalance -f /system/vendor/etc/msm_irqbalance_little_big.conf" "service msm_irqbal_lb /system/bin/msm_irqbalance -f /sbin/msm_irqbalance.conf";
# replace_string init.qcom.rc "service msm_irqbal_lb /vendor/bin/msm_irqbalance -f /sbin/msm_irqbalance.conf" "service msm_irqbal_lb /vendor/bin/msm_irqbalance -f /vendor/etc/msm_irqbalance_little_big.conf" "service msm_irqbal_lb /vendor/bin/msm_irqbalance -f /sbin/msm_irqbalance.conf";
# replace_string init.qcom.rc "#start qcom-post-boot" "start qcom-post-boot" "#start qcom-post-boot";
# replace_string init.qcom.rc "#start atfwd" "start atfwd" "#start atfwd";
# replace_string init.qcom.rc "#start config-zram" "start config-zram" "#start config-zram";

# end ramdisk changes

write_boot;

## end install
