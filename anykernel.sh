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
device.name1=OnePlus2
device.name2=oneplus2
}

# shell variables
block=/dev/block/platform/soc.0/f9824900.sdhci/by-name/boot;
is_slot_device=0;

## end setup

# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;
## AnyKernel install
dump_boot;

# begin ramdisk changes

# init.qcom.rc
insert_line init.qcom.rc "init.fk.rc" after "import init.qcom.power.rc" "import init.fk.rc";
insert_line init.qcom.rc "performance_profiles" after "import init.qcom.power.rc" "import init.performance_profiles.rc";
insert_line default.prop "ro.sys.sdcardfs=false" before "ro.oxygen.version" "ro.sys.sdcardfs=false";

# end ramdisk changes

write_boot;

## end install
