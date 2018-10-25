# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {
kernel.string=FrancoKernel by franciscofranco @ xda-developers
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=1
device.name1=hammerhead
} # end properties

# shell variables
block=/dev/block/platform/msm_sdcc.1/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;

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

# init.hammerhead.rc
insert_line fstab.hammerhead "cache          f2fs" before "cache          ext4" "/dev/block/platform/msm_sdcc.1/by-name/cache        /cache          f2fs    rw,nosuid,nodev,noatime,nodiratime,inline_xattr                                                     wait,check,formattable";
insert_line fstab.hammerhead "data           f2fs" before "data           ext4" "/dev/block/platform/msm_sdcc.1/by-name/userdata     /data           f2fs    rw,nosuid,nodev,noatime,nodiratime,inline_xattr                                                     wait,check,formattable,encryptable=/dev/block/platform/msm_sdcc.1/by-name/metadata"

insert_line init.hammerhead.rc "init.fk" before "import init.hammerhead.usb.rc" "import init.fk.rc";
insert_line init.hammerhead.rc "performance_profiles" before "import init.hammerhead.usb.rc" "import init.performance_profiles.rc";
replace_section init.hammerhead.rc "service thermal-engine" " " "#service thermal-engine /system/bin/thermal-engine-hh\n#   class main\n#   user root\n#   group radio system\n";

# end ramdisk changes

write_boot;

## end install


