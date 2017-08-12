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
    echo -n $1 > /dev/cpuset/system-background/tasks
}
################################################################################

sleep 30

MDM_HELPER=`pidof mdm_helper`
BRIDGEMGRD=`pidof bridgemgrd`
QMUXD=`pidof qmuxd`
NETMGRD=`pidof netmgrd`
IMSQMIDAEMON=`pidof imsqmidaemon`
IMSDATADAEMON=`pidof imsdatadaemon`
WPA_SUPPLICANT=`pidof wpa_supplicant`
ADSPD=`pidof adspd`
CHARGER=`pidof charger`
QSEECOMD=`pidof qseecomd`
THERMAL-ENGINE=`pidof thermal-engine`
TIME_DAEMON=`pidof time_daemon`
MDM_HELPER_PROXY=`pidof mdm_helper_proxy`
CND=`pidof cnd`
LOGCAT=`pidof logcat`
LMKD=`pidof lmkd`

writepid_sbg $MDM_HELPER
writepid_sbg $BRIDGEMGRD
writepid_sbg $QMUXD
writepid_sbg $NETMGRD
writepid_sbg $IMSQMIDAEMON
writepid_sbg $IMSDATADAEMON
writepid_sbg $WPA_SUPPLICANT
writepid_sbg $ADSPD
writepid_sbg $CHARGER
writepid_sbg $QSEECOMD
writepid_sbg $THERMAL-ENGINE
writepid_sbg $TIME_DAEMON
writepid_sbg $MDM_HELPER_PROXY
writepid_sbg $CND
writepid_sbg $LOGCAT
writepid_sbg $LMKD
