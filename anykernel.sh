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
device.name1=OnePlus3
device.name2=oneplus3
}

# shell variables
block=/dev/block/platform/soc/624000.ufshc/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;

## end setup

# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;

## AnyKernel install
dump_boot;

# begin ramdisk changes

# init.qcom.rc
insert_line init.rc "init.fk.rc" after "import /init.usb.rc" "import init.fk.rc";
insert_line init.rc "performance_profiles" after "import /init.usb.rc" "import init.performance_profiles.rc";
insert_line default.prop "ro.sys.fw.bg_apps_limit=60" before "ro.oxygen.version" "ro.sys.fw.bg_apps_limit=60";

# end ramdisk changes

write_boot;

## end install
