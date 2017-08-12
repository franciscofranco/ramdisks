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
device.name1=OnePlus5
device.name2=cheeseburger
}

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;

## end setup

# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;

## AnyKernel install
dump_boot;

# begin ramdisk changes

# init.qcom.rc
insert_line init.qcom.rc "init.performance_profiles.rc" after "import init.qcom.usb.rc" "import init.performance_profiles.rc";
insert_line init.qcom.rc "init.fk.rc" after "import init.qcom.usb.rc" "import init.fk.rc";
insert_line default.prop "ro.sys.fw.bg_apps_limit=60" before "ro.secure=1" "ro.sys.fw.bg_apps_limit=60";

# end ramdisk changes

write_boot;

## end install
