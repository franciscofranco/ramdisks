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
device.name1=sailfish
device.name2=marlin
}

# shell variables
block=/dev/block/platform/soc/624000.ufshc/by-name/boot;
is_slot_device=1;

## end setup

# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;

## AnyKernel install
dump_boot;

if [ -d $ramdisk/boot/dev ]; then
  patch_cmdline "skip_override" "skip_override";
else
  patch_cmdline "skip_override" "";
fi;

# begin ramdisk changes
# init.sailfish.rc
# init.marlin.rc

# boot/init.sailfish.rc
backup_file boot/init.sailfish.rc;
insert_line boot/init.sailfish.rc "init.fk" before 'import init.${ro.hardware}.nanohub.rc' "import init.fk.rc";
insert_line boot/init.sailfish.rc "performance_profiles" before 'import init.${ro.hardware}.nanohub.rc' "import init.performance_profiles.rc";
# end ramdisk changes

write_boot;

## end install

