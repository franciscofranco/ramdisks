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
device.name1=A0001
device.name2=bacon
}

# shell variables
block=/dev/block/platform/msm_sdcc.1/by-name/boot;
is_slot_device=0;

## end setup

# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;

## AnyKernel install
dump_boot;

# begin ramdisk changes

# init.onyx.rc
insert_line init.bacon.rc "init.fk" before "import /init.qcom.usb.rc" "import init.fk.rc";
insert_line init.bacon.rc "performance_profiles" before "import /init.qcom.usb.rc" "import init.performance_profiles.rc";
replace_section init.bacon.rc "service mpdecision" " " "#service mpdecision /system/bin/mpdecision --avg_comp\n#    class main\n#    user root\n#    group root readproc\n#    disabled\n"
# end ramdisk changes

write_boot;

## end install


