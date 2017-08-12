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
device.name1=kenzo
device.name2=kate
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
# cleaning up because nitrogen fucked things up
# needs fix after I fix the bootloader
remove_line init.qcom.rc "import init.fk.rc";
remove_line init.qcom.rc "import init.performance_profiles.rc";
remove_line init.qcom.rc "init.qcom.power.rc";

insert_line init.qcom.rc "init.qcom.power.rc" before "import init.qcom.usb.rc" "import init.qcom.power.rc";
insert_line init.qcom.rc "init.fk.rc" before "import init.qcom.usb.rc" "import init.fk.rc";
insert_line init.qcom.rc "performance_profiles" before "import init.qcom.usb.rc" "import init.performance_profiles.rc";
insert_line default.prop "ro.sys.sdcardfs=false" before "ro.secure=0" "ro.sys.sdcardfs=false";
replace_string init.qcom.rc "service msm_irqbal_lb /system/bin/msm_irqbalance -f /sbin/msm_irqbalance.conf" "service msm_irqbal_lb /system/bin/msm_irqbalance -f /system/vendor/etc/msm_irqbalance_little_big.conf" "service msm_irqbal_lb /system/bin/msm_irqbalance -f /sbin/msm_irqbalance.conf";
replace_section init.qcom.rc "on property:sys.boot_completed=1" "    start config-zram" "#on property:sys.boot_completed=1\n    #start qcom-post-boot\n    #start atfwd\n    #start config-zram";

# end ramdisk changes

write_boot;

## end install
