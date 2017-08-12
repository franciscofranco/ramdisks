#!/system/bin/sh

################################################################################
# helper functions to allow Android init like script

function write() {
    echo -n $2 > $1
}

function copy() {
    cat $1 > $2
}

function get-set-forall() {
    for f in $1 ; do
        cat $f
        write $f $2
    done
}

# macro to write pids to system-background cpuset
function writepid_sbg() {
    echo -n $1 > /dev/cpuset/system-background/tasks
}

################################################################################

# devfreq
get-set-forall /sys/class/devfreq/qcom,cpubw*/governor bw_hwmon
restorecon -R /sys/class/devfreq/qcom,cpubw*
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/sample_ms 4
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/io_percent 34
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/hist_memory 20
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/hyst_length 10
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/low_power_ceil_mbps 0
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/low_power_io_percent 34
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/low_power_delay 20
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/guard_band_mbps 0
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/up_scale 250
get-set-forall /sys/class/devfreq/qcom,cpubw*/bw_hwmon/idle_mbps 1600
get-set-forall /sys/class/devfreq/qcom,mincpubw*/governor cpufreq

sleep 20

LOGCAT=`pidof logcat`
RMT_STORAGE=`pidof rmt_storage`
QMUXD=`pidof qmuxd`
QTI=`pidof qti`
NETMGRD=`pidof netmgrd`
THERMAL-ENGINE=`pidof thermal-engine`
WPA_SUPPLICANT=`pidof wpa_supplicant`
LOC_LAUNCHER=`pidof loc_launcher`
CNSS-DAEMON=`pidof cnss-daemon`
QSEECOMD=`pidof qseecomd`
TIME_DAEMON=`pidof time_daemon`
CND=`pidof cnd`
IMSQMIDAEMON=`pidof imsqmidaemon`
IMSDATADAEMON=`pidof imsdatadaemon`
FINGERPRINTD=`pidof fingerprintd`

writepid_sbg $LOGCAT
writepid_sbg $RMT_STORAGE
writepid_sbg $QMUXD
writepid_sbg $QTI
writepid_sbg $NETMGRD
writepid_sbg $THERMAL-ENGINE
writepid_sbg $WPA_SUPPLICANT
writepid_sbg $LOC_LAUNCHER
writepid_sbg $CNSS-DAEMON
writepid_sbg $QSEECOMD
writepid_sbg $TIME_DAEMON
writepid_sbg $CND
writepid_sbg $IMSQMIDAEMON
writepid_sbg $IMSDATADAEMON
writepid_sbg $FINGERPRINTD
