# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {
kernel.string=franco.Kernel by franciscofranco @ xda-developers
do.devicecheck=1
do.initd=0
do.modules=0
do.cleanup=1
do.cleanuponabort=1
device.name1=hammerhead
} # end properties

# shell variables
block=/dev/block/platform/msm_sdcc.1/by-name/boot;
is_slot_device=0;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel install
dump_boot;

# begin ramdisk changes

# init.hammerhead.rc
insert_line init.hammerhead.rc "init.fk" before "import init.hammerhead.usb.rc" "import init.fk.rc";
insert_line init.hammerhead.rc "performance_profiles" before "import init.hammerhead.usb.rc" "import init.performance_profiles.rc";
insert_line init.hammerhead.rc "    swapon_all ./fstab.hammerhead" before "    restorecon_recursive /persist" "    swapon_all ./fstab.hammerhead"
replace_string init.hammerhead.rc "#write /sys/module/msm_thermal/core_control/enabled" "write /sys/module/msm_thermal/core_control/enabled" "#write /sys/module/msm_thermal/core_control/enabled";
replace_string init.hammerhead.rc "#start mpdecision" "start mpdecision" "#start mpdecision";
replace_section init.hammerhead.rc "service rmt_storage" " " "service rmt_storage /system/bin/rmt_storage\n    class core\n    user root\n    group system wakelock\n";
replace_section init.hammerhead.rc "service qmuxd" " " "service qmuxd /system/bin/qmuxd\n    class main\n    user radio\n    group radio audio bluetooth gps wakelock\n";
replace_section init.hammerhead.rc "service sensors" " " "service sensors /system/bin/sensors.qcom\n    class main\n    user root\n    group root wakelock\n";
replace_section init.hammerhead.rc "service mpdecision" " " "#service mpdecision /system/bin/mpdecision --no_sleep --avg_comp\n#   class main\n#   user root\n#   group root system\n#   disabled\n";
replace_section init.hammerhead.rc "service thermal-engine" " " "#service thermal-engine /system/bin/thermal-engine-hh\n#   class main\n#   user root\n#   group radio system\n";

# end ramdisk changes

write_boot;

## end install


