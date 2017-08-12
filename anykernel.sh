# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# EDIFY properties
properties() {
kernel.string=FrancoKernel by franciscofranco @ xda-developers
do.devicecheck=1
do.initd=0
do.modules=0
do.cleanup=1
do.cleanuponabort=1
device.name1=flo
device.name2=deb
}

# shell variables
block=/dev/block/platform/msm_sdcc.1/by-name/boot;
is_slot_device=0;

# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;

## AnyKernel install
dump_boot;

# begin ramdisk changes

# fstab.flo
patch_fstab fstab.flo /data ext4 options "noatime,nosuid,nodev,barrier=1,data=ordered,nomblk_io_submit,errors=panic" "noatime,nosuid,nodev,barrier=1,data=ordered,nomblk_io_submit,errors=panic,noauto_da_alloc";
patch_fstab fstab.flo /cache ext4 options "noatime,nosuid,nodev,barrier=1,data=ordered,nomblk_io_submit,errors=panic" "noatime,nosuid,nodev,barrier=1,data=ordered,nomblk_io_submit,errors=panic,noauto_da_alloc";
insert_line fstab.flo "cache          f2fs" before "cache          ext4" "/dev/block/platform/msm_sdcc.1/by-name/cache        /cache          f2fs    rw,nosuid,nodev,noatime,nodiratime,inline_xattr                                                     wait,check,formattable";
insert_line fstab.flo "data           f2fs" before "data           ext4" "/dev/block/platform/msm_sdcc.1/by-name/userdata     /data           f2fs    rw,nosuid,nodev,noatime,nodiratime,inline_xattr                                                     wait,check,formattable,encryptable=/dev/block/platform/msm_sdcc.1/by-name/metadata";

# init.flo.rc
insert_line init.flo.rc "init.fk" before "import init.flo.usb.rc" "import init.fk.rc";
insert_line init.flo.rc "performance_profiles" before "import init.flo.usb.rc" "import init.performance_profiles.rc";
replace_section init.flo.rc "service thermald" "group radio" "#service thermald /system/bin/thermald\n#    class main\n#    group radio system";
replace_section init.flo.rc "service mpdecision" "group root system" "#service mpdecision /system/bin/mpdecision --no_sleep --avg_comp\n#    class main\n#    user root\n#    group root system";

# end ramdisk changes

write_boot;

## end install
