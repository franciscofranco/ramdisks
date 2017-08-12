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

## end setup

# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;

## AnyKernel install
dump_boot;

# begin ramdisk changes

# init.shamu.power.rc
insert_line init.shamu.rc "init.fk.rc" after "import init.shamu.diag.rc" "import init.fk.rc";
insert_line init.shamu.rc "performance_profiles" after "import init.shamu.diag.rc" "import init.performance_profiles.rc";
replace_section init.shamu.rc "service mpdecision" " " "#service mpdecision /system/bin/mpdecision --avg_comp\n#   class main\n#   user root\n#   group root readproc\n#    writepid /dev/cpuset/system-background/tasks\n#   disabled\n";
replace_string init.shamu.rc "#    verity_load_state" "    verity_load_state" "#    verity_load_state"
remove_line init.shamu.power.rc "on property:dev.bootcomplete=1"
# end ramdisk changes

write_boot;

## end install
