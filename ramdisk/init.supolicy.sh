#!/system/bin/sh

SULIBS="/su/lib:/system/lib64:/system/lib"

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
        "allow init sysfs_cpuboost file getattr" \
        "allow init kernel security load_policy" \
	"allow platform_app { untrusted_app init system_app shell kernel } dir search" \
	"allow platform_app { untrusted_app init system_app shell kernel } file { open read getattr }" \
	"allow untrusted_app { ueventd init proc_sysrq vold healthd lmkd servicemanager surfaceflinger rmt tee netd debuggerd rild drmserver mediaserver installd keystore bridge qmux netmgrd sensors zygote gatekeeperd camera time adbd system_server sdcardd platform_app wpa radio nfc shell system_app device } dir { getattr search read search }" \
	"allow untrusted_app { ueventd init proc_sysrq vold healthd lmkd servicemanager surfaceflinger rmt tee netd debuggerd rild drmserver mediaserver installd keystore bridge qmux netmgrd sensors zygote gatekeeperd camera time adbd system_server sdcardd platform_app wpa radio nfc shell system_app device } file { getattr read open }" \
	"allow platform_app { ueventd vold healthd lmkd servicemanager surfaceflinger rmt tee netd debuggerd rild drmserver } dir search" \
	"allow untrusted_app untrusted_app udp_socket ioctl" \
	"allow untrusted_app kernel dir { getattr }" \
	"allow untrusted_app sysfs file { read open getattr }"
done
