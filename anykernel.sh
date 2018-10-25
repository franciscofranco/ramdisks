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
device.name1=oneplus3t
device.name2=OnePlus3T
device.name3=oneplus3
device.name4=OnePlus3
}

# shell variables
block=/dev/block/platform/soc/624000.ufshc/by-name/boot;
is_slot_device=0;

## end setup

# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;

# begin ramdisk changes

## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;

# Alert of unsupported Android version
android_ver=$(grep "^ro.build.version.release" /system/build.prop | cut -d= -f2);
case "$android_ver" in
  "7.1.2"|"8.1.0") support_status="supported";;
  *) support_status="unsupported";;
esac;
ui_print " ";
ui_print "Running Android $android_ver..."
ui_print "This kernel is $support_status for this version!";

## AnyKernel install
dump_boot;

# begin ramdisk changes
# sepolicy
$bin/magiskpolicy --load sepolicy --save sepolicy \
  "allow init rootfs file execute_no_trans" \
;

# init.rc
insert_line init.rc "init.fk.rc" after "import /init.rc" "import /init.fk.rc";
insert_line init.rc "performance_profiles" after "import /init.rc" "import /init.performance_profiles.rc";

# end ramdisk changes

write_boot;

## end install
