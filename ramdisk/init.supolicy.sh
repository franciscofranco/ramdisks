#!/system/bin/sh

SULIBS="/su/lib:/sbin/supersu/lib:/system/lib64:/system/lib"

for SUPOLICY in `which supolicy sepolicy-inject`;
do
	LD_LIBRARY_PATH=$SULIBS $SUPOLICY --live \
        "allow shell dalvikcache_data_file file { write create }" \
        "allow shell dalvikcache_data_file dir { add_name create relabelfrom relabelto remove_name rename reparent rmdir search setattr write }" \
        "allow mediaserver mediaserver_tmpfs file { read write execute }" \
        "allow isolated_app app_data_file dir search" \
        "allow untrusted_app kernel dir search" \
        "allow untrusted_app sysfs_mmi_touch dir search" \
        "allow untrusted_app healthd_service service_manager find" \
        "allow untrusted_app kernel file { ioctl read write getattr append open }" \
        "allow untrusted_app sysfs_cpuboost dir search" \
        "allow untrusted_app sysfs_cpuboost file { open read getattr }" \
	"allow untrusted_app sysfs file { read write getattr open }" \
        "allow untrusted_app sysfs dir { read write getattr open }" \
        "allow init sysfs_cpuboost file getattr" \
        "allow init kernel security load_policy" \
	"allow platform_app { untrusted_app init system_app shell kernel ueventd logd vold healthd lmkd servicemanager surfaceflinger tee adbd netd debuggerd rild drmserver mediaserver installd keystore qmux netmgrd ims zygote gatekeeperd camera atfwd cnd fingerprintd system_server sdcardd wpa nfc radio isolated_app mdm_helper sensors adspd thermald bridge time dex2oat } dir search" \
        "allow platform_app { untrusted_app init system_app shell kernel ueventd logd vold healthd lmkd servicemanager surfaceflinger tee adbd netd debuggerd rild drmserver mediaserver installd keystore qmux netmgrd ims zygote gatekeeperd camera atfwd cnd fingerprintd system_server sdcardd wpa nfc radio isolated_app mdm_helper sensors adspd thermald bridge time dex2oat } file { open read getattr }" \
	"allow shell shell capability dac_override" \
	"allow dalvikcache_data_file shell file unlink" \
	"allow system_server system_server unix_stream_socket ioctl"
done
