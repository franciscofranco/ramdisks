#!/system/bin/sh

################################################################################
# helper functions to allow Android init like script

function write() {
    echo -n $2 > $1
}

function copy() {
    cat $1 > $2
}

# macro to write pids to system-background cpuset
function writepid_sbg() {
    until [ ! "$1" ]; do
        echo -n $1 > /dev/cpuset/system-background/tasks;
        shift;
    done;
}

function writepid_top_app() {
    until [ ! "$1" ]; do
        echo -n $1 > /dev/cpuset/top-app/tasks;
        shift;
    done;
}
################################################################################

{

sleep 10

# display kcal calibration
chmod 0664 /sys/devices/platform/kcal_ctrl.0/kcal
chmod 0664 /sys/devices/platform/kcal_ctrl.0/kcal_cont
chmod 0664 /sys/devices/platform/kcal_ctrl.0/kcal_hue
chmod 0664 /sys/devices/platform/kcal_ctrl.0/kcal_sat
chmod 0664 /sys/devices/platform/kcal_ctrl.0/kcal_val

# cpu
chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor

# gpu
chmod 0664 /sys/class/kgsl/kgsl-3d0/devfreq/max_freq
chmod 0664 /sys/class/kgsl/kgsl-3d0/devfreq/min_freq

write /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay 0
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load 100
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq 0
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads "70 672000:45 825600:50 1036800:60 1248000:70 1478400:85"
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time 40000
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate 30000

write /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load 99
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq 1574400
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay "19000 1400000:39000 1700000:19000 2100000:79000"
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads "85 1728000:80 2112000:90 2342400:95"
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate 30000
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time 19000
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis 39000

write /sys/module/cpu_boost/parameters/input_boost_freq "0:1036800 4:729600"
write /sys/module/cpu_boost/parameters/input_boost_ms 1500

sleep 20

QSEECOMD=`pidof qseecomd`
THERMAL-ENGINE=`pidof thermal-engine`
TIME_DAEMON=`pidof time_daemon`
IMSQMIDAEMON=`pidof imsqmidaemon`
IMSDATADAEMON=`pidof imsdatadaemon`
DASHD=`pidof dashd`
CND=`pidof cnd`
DPMD=`pidof dpmd`
RMT_STORAGE=`pidof rmt_storage`
TFTP_SERVER=`pidof tftp_server`
NETMGRD=`pidof netmgrd`
IPACM=`pidof ipacm`
QTI=`pidof qti`
LOC_LAUNCHER=`pidof loc_launcher`
QSEEPROXYDAEMON=`pidof qseeproxydaemon`
IFAADAEMON=`pidof ifaadaemon`
LOGCAT=`pidof logcat`
LMKD=`pidof lmkd`
PERFD=`pidof perfd`
IOP=`pidof iop`
MSM_IRQBALANCE=`pidof msm_irqbalance`
SEEMP_HEALTHD=`pidof seemp_healthd`
ESEPMDAEMON=`pidof esepmdaemon`
WPA_SUPPLICANT=`pidof wpa_supplicant`
SEEMPD=`pidof seempd`

writepid_sbg $QSEECOMD
writepid_sbg $THERMAL-ENGINE
writepid_sbg $TIME_DAEMON
writepid_sbg $IMSQMIDAEMON
writepid_sbg $IMSDATADAEMON
writepid_sbg $DASHD
writepid_sbg $CND
writepid_sbg $DPMD
writepid_sbg $RMT_STORAGE
writepid_sbg $TFTP_SERVER
writepid_sbg $NETMGRD
writepid_sbg $IPACM
writepid_sbg $QTI
writepid_sbg $LOC_LAUNCHER
writepid_sbg $QSEEPROXYDAEMON
writepid_sbg $IFAADAEMON
writepid_sbg $LOGCAT
writepid_sbg $LMKD
writepid_sbg $PERFD
writepid_sbg $IOP
writepid_sbg $MSM_IRQBALANCE
writepid_sbg $SEEMP_HEALTHD
writepid_sbg $ESEPMDAEMON
writepid_sbg $WPA_SUPPLICANT
writepid_sbg $SEEMPD

}&
