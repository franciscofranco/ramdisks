# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# EDIFY properties
kernel.string=franco.Kernel by franciscofranco @ xda-developers
do.devicecheck=1
do.initd=0
do.modules=0
do.cleanup=1
device.name1=mako

# shell variables
block=/dev/block/platform/msm_sdcc.1/by-name/boot;
is_slot_device=0;

## end setup

# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;

## AnyKernel install
dump_boot;

# begin ramdisk changes

# init.hammerhead.rc
insert_line init.mako.rc "init.fk" before "import init.mako.usb.rc" "import init.fk.rc";
insert_line init.mako.rc "performance_profiles" before "import init.mako.usb.rc" "import init.performance_profiles.rc";
replace_section init.mako.rc "service mpdecision" "disabled" "#service mpdecision /system/bin/mpdecision --no_sleep --avg_comp\n#   class main\n#   user root\n#   group root system\n#   disabled";
replace_section init.mako.rc "service thermald /system/bin/thermald" "group radio system" "#service thermald /system/bin/thermald\n#    class main\n#    group radio system"

# end ramdisk changes

write_boot;

## end install


