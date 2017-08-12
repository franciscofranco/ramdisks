#!/system/bin/sh

SUPOLICY=`which supolicy`

$SUPOLICY --live \
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
	"allow platform_app { untrusted_app init system_app shell kernel } file { open read getattr }"
