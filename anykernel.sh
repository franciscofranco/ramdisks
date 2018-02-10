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
device.name1=angler
} # end properties

# shell variables
block=/dev/block/platform/soc.0/f9824900.sdhci/by-name/boot;
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

# fstab.angler
insert_line fstab.angler "data           f2fs" after "data           ext4" "/dev/block/platform/soc.0/f9824900.sdhci/by-name/userdata     /data           f2fs    rw,nosuid,nodev,noatime,nodiratime,inline_xattr wait,formattable,encryptable=/dev/block/platform/soc.0/f9824900.sdhci/by-name/metadata";
insert_line fstab.angler "cache          f2fs" after "cache          ext4" "/dev/block/platform/soc.0/f9824900.sdhci/by-name/cache        /cache          f2fs    rw,nosuid,nodev,noatime,nodiratime,inline_xattr wait,check,formattable";
patch_fstab fstab.angler none swap flags "zramsize=533413200" "zramsize=1066826400";
patch_fstab fstab.angler /system ext4 flags "wait,verify=/dev/block/platform/soc.0/f9824900.sdhci/by-name/metadata" "wait";
patch_fstab fstab.angler /vendor ext4 flags "wait,verify=/dev/block/platform/soc.0/f9824900.sdhci/by-name/metadata" "wait";
patch_fstab fstab.angler /data ext4 flags "wait,check,forcefdeorfbe=/dev/block/platform/soc.0/f9824900.sdhci/by-name/metadata" "wait,check,encryptable=/dev/block/platform/soc.0/f9824900.sdhci/by-name/metadata";

# init.angler.rc
insert_line init.angler.rc "init.fk.rc" after "import init.angler.sensorhub.rc" "import init.fk.rc";
insert_line init.angler.rc "performance_profiles" after "import init.angler.sensorhub.rc" "import init.performance_profiles.rc";
replace_string init.angler.rc "#    verity_load_state" "    verity_load_state" "#    verity_load_state";
replace_string init.angler.rc "#    verity_update_state" "    verity_update_state" "#    verity_update_state";
replace_section init.angler.rc "service atfwd" " " "service atfwd /system/bin/ATFWD-daemon\n    disabled\n    class late_start\n    user system\n    group system radio\n";

$bin/sepolicy-inject -s init -t rootfs -c file -p execute_no_trans -P sepolicy;

# end ramdisk changes

write_boot;

## end install
