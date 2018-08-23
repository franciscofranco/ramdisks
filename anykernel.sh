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
device.name1=OnePlus5
device.name2=cheeseburger
device.name3=OnePlus5T
device.name4=dumpling
} # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chmod 644 $ramdisk/WCNSS_qcom_cfg.ini;
chmod 644 $ramdisk/modules/*;
chown -R root:root $ramdisk/*;

# Print message and exit
die() {
  ui_print " "; ui_print "$*";
  exit 1;
}


# Don't even think about flashing on non-Treble
treble=$(file_getprop /system/build.prop "ro.treble.enabled");
if [ ! -z $treble -a $treble == "false" ]; then
  die "FrancoKernel is only compatible with Treble stock rom OxygenOS 5.1.5, newer, or recent LineageOS 15.1 roms (or basically any recent rom with Treble support)!";
fi;

## AnyKernel install
# alert of unsupported Android version
android_ver=$(grep "^ro.build.version.release" /system/build.prop | cut -d= -f2);
case "$android_ver" in
  "8.0.0"|"8.1.0") support_status="supported";;
  *) support_status="unsupported";;
esac;
ui_print " ";
ui_print "Running Android $android_ver..."
ui_print "This kernel is $support_status for this version!";

userflavor="$(grep "^ro.build.user" /system/build.prop | cut -d= -f2):$(grep "^ro.build.flavor" /system/build.prop | cut -d= -f2)";
case "$userflavor" in
  "OnePlus:OnePlus5-user"|"OnePlus:OnePlus5T-user")
    os="oos";
    os_string="OxygenOS";;
  *)
    os="custom";
    os_string="a custom ROM";;
esac;
ui_print " ";
ui_print "You are on $os_string!";

dump_boot;

# begin ramdisk changes

insert_line default.prop "ro.sys.fw.bg_apps_limit=60" before "ro.secure=1" "ro.sys.fw.bg_apps_limit=60";

# init.rc
insert_line init.rc "init.performance_profiles.rc" after "import /init.usb.rc" "import init.performance_profiles.rc";
insert_line init.rc "init.fk.rc" after "import /init.usb.rc" "import init.fk.rc";

# If on OOS
if [ "$os" == "oos" ]; then
  # Remove recovery service so that TWRP isn't overwritten
  remove_section init.rc "service flash_recovery" ""
fi;

# end ramdisk changes

write_boot;

## end install

