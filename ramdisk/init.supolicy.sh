#!/system/bin/sh

SULIBS="/su/lib:/system/lib64:/system/lib"

for SUPOLICY in `which supolicy sepolicy-inject`;
do
	LD_LIBRARY_PATH=$SULIBS $SUPOLICY --live \
        "allow ssr device dir read" \
        "allow shell dalvikcache_data_file file write" \
        "allow shell dalvikcache_data_file dir { write add_name }" \
        "allow audioserver audioserver_tmpfs file { read write execute }" \
        "allow untrusted_app kernel file { ioctl read write getattr append open }" \
        "allow untrusted_app kernel dir search" \
        "allow isolated_app app_data_file dir search" \
        "allow untrusted_app sysfs_thermal dir search" \
        "allow untrusted_app { sysfs_thermal sysfs } file { open read getattr }" \
        "allow init kernel security load_policy" \
        "allow platform_app { untrusted_app init system_app shell kernel ueventd logd vold healthd lmkd servicemanager surfaceflinger rmt per_mgr tee adbd netd debuggerd rild drmserver mediaserver installd keystore qmux perfd qti netmgrd ims imscm zygote gatekeeperd location camera atfwd cnd fingerprintd system_server sdcardd wpa nfc radio isolated_app } dir search" \
        "allow platform_app { untrusted_app init system_app shell kernel ueventd logd vold healthd lmkd servicemanager surfaceflinger rmt per_mgr tee adbd netd debuggerd rild drmserver mediaserver installd keystore qmux perfd qti netmgrd ims imscm zygote gatekeeperd location camera atfwd cnd fingerprintd system_server sdcardd wpa nfc radio isolated_app } file { open read getattr }" \
	"allow sysfs perfd file write" \
	"allow system_server system_server unix_stream_socket ioctl" \
	"allow priv_app device dir read" \
	"allow adbd security_file dir search" \
	"allow untrusted_app sysfs file { read write getattr open }" \
	"allow untrusted_app sysfs dir { read write getattr open }" \
	"allow priv_app sysfs_mac_address file read" \
	"allow system_server unlabeled file unlink" \
	"allow priv_app sysfs_mac_address file open" \
	"allow shell shell capability dac_override" \
	"allow untrusted_app sysfs_led dir search" \
	"allow untrusted_app sysfs_led file { read getattr open }"
done
