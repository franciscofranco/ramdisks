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
device.name1=tissot
device.name2=Mi A1
device.name3=tissot_sprout
} # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=1;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;


## AnyKernel install
dump_boot;

# begin ramdisk changes
# sepolicy
$bin/magiskpolicy --load sepolicy --save sepolicy \
  "allow init rootfs file execute_no_trans" \
;

if [ -d $ramdisk/.subackup -o -d $ramdisk/.backup ]; then
  patch_cmdline "skip_override" "skip_override";
else
  patch_cmdline "skip_override" "";
fi;

if [ -d $ramdisk/.backup ]; then
  overlay=$ramdisk/overlay;
elif [ -d $ramdisk/.subackup ]; then
  overlay=$ramdisk/boot;
fi;

list="init.rc";
for rdfile in $list; do
  rddir=$(dirname $rdfile);
  mkdir -p $overlay/$rddir;
  test ! -f $overlay/$rdfile && cp -rp /system/$rdfile $overlay/$rddir/;
done;

insert_line $overlay/init.rc "init.fk.rc" before "import /init.usb.rc" "import /init.fk.rc";
insert_line $overlay/init.rc "performance_profiles" before "import /init.usb.rc" "import /init.performance_profiles.rc";

# end ramdisk changes

write_boot;

## end install

