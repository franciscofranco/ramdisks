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
device.name1=bullhead
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

# sepolicy
$bin/magiskpolicy --load sepolicy --save sepolicy \
  "allow init rootfs file execute_no_trans" \
;

# begin ramdisk changes

# fstab.bullhead
insert_line fstab.bullhead "data           f2fs" after "data           ext4" "/dev/block/platform/soc.0/f9824900.sdhci/by-name/userdata     /data           f2fs    rw,nosuid,nodev,noatime,nodiratime,inline_xattr wait,formattable,encryptable=/dev/block/platform/soc.0/f9824900.sdhci/by-name/metadata";
insert_line fstab.bullhead "cache          f2fs" after "cache          ext4" "/dev/block/platform/soc.0/f9824900.sdhci/by-name/cache        /cache          f2fs    rw,nosuid,nodev,noatime,nodiratime,inline_xattr wait,check,formattable";
patch_fstab fstab.bullhead none swap flags "zramsize=533413200" "zramsize=1066826400";

# init.bullhead.rc
insert_line init.bullhead.rc "init.fk.rc" after "import init.bullhead.ramdump.rc" "import init.fk.rc";
insert_line init.bullhead.rc "performance_profiles" after "import init.bullhead.ramdump.rc" "import init.performance_profiles.rc";
replace_string init.bullhead.rc "#    verity_load_state" "    verity_load_state" "#    verity_load_state";
replace_string init.bullhead.rc "#    verity_update_state" "    verity_update_state" "#    verity_update_state";
replace_section init.bullhead.rc "service atfwd" " " "service atfwd /system/bin/ATFWD-daemon\n    disabled\n    class late_start\n    user system\n    group system radio\n";
replace_section init.bullhead.rc "service thermal-engine" " " "service thermal-engine /system/bin/thermal-engine\n    class main\n    user root\n    socket thermal-send-client stream 0666 system system\n    socket thermal-recv-client stream 0660 system system\n    socket thermal-recv-passive-client stream 0666 system system\n    writepid /dev/cpuset/system-background/tasks\n    group root\n";

# end ramdisk changes

write_boot;

## end install

