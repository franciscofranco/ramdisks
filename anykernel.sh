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
device.name1=shamu
}

# shell variables
block=/dev/block/platform/msm_sdcc.1/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;

## end setup

# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;

## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;

## AnyKernel install
dump_boot;

# begin ramdisk changes

# fstab.shamu
insert_line fstab.shamu "data        f2fs" after "data        ext4" "/dev/block/platform/msm_sdcc.1/by-name/userdata     /data           f2fs    rw,nosuid,nodev,noatime,nodiratime,inline_xattr                 wait,encryptable=/dev/block/platform/msm_sdcc.1/by-name/metadata";
insert_line fstab.shamu "cache       f2fs" after "cache       ext4" "/dev/block/platform/msm_sdcc.1/by-name/cache        /cache          f2fs    rw,nosuid,nodev,noatime,nodiratime,inline_xattr                 wait,check";
patch_fstab fstab.shamu /system ext4 flags "wait,verify=/dev/block/platform/msm_sdcc.1/by-name/metadata" "wait";
patch_fstab fstab.shamu /data ext4 flags  "wait,check,formattable,forceencrypt=/dev/block/platform/msm_sdcc.1/by-name/metadata" "wait,check,formattable,encryptable=/dev/block/platform/msm_sdcc.1/by-name/metadata";

# init.shamu.power.rc
insert_line init.shamu.rc "init.fk.rc" after "import init.shamu.diag.rc" "import init.fk.rc";
insert_line init.shamu.rc "performance_profiles" after "import init.shamu.diag.rc" "import init.performance_profiles.rc";
replace_section init.shamu.rc "service mpdecision" " " "#service mpdecision /system/bin/mpdecision --avg_comp\n#   class main\n#   user root\n#   group root readproc\n#    writepid /dev/cpuset/system-background/tasks\n#   disabled\n";
replace_string init.shamu.rc "#    verity_load_state" "    verity_load_state" "#    verity_load_state";
remove_line init.shamu.power.rc "on property:dev.bootcomplete=1";

# end ramdisk changes

write_boot;

## end install
