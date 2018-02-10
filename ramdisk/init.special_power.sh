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

################################################################################

{

sleep 10

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


chmod 0664 /sys/devices/platform/kcal_ctrl.0/kcal
chmod 0664 /sys/devices/platform/kcal_ctrl.0/kcal_cont
chmod 0664 /sys/devices/platform/kcal_ctrl.0/kcal_hue
chmod 0664 /sys/devices/platform/kcal_ctrl.0/kcal_invert
chmod 0664 /sys/devices/platform/kcal_ctrl.0/kcal_sat
chmod 0664 /sys/devices/platform/kcal_ctrl.0/kcal_val

chmod 0664 /sys/class/devfreq/fdb00000.qcom,kgsl-3d0/governor
chmod 0664 /sys/class/devfreq/fdb00000.qcom,kgsl-3d0/max_freq
chmod 0664 /sys/class/devfreq/fdb00000.qcom,kgsl-3d0/min_freq

chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor

write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor interactive
write /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor interactive

# Little cluster
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay 0
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load 100
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq 0
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads "85 672000:50 768000:55 864000:60 960000:70 1248000:85 1478400:95"
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate 20000
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time 60000
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/ignore_hispeed_on_notif 1
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis 80000
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack 30000

# big cluster
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay "20000 1248000:40000 1728000:20000"
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load 85
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq 864000
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads "90 1248000:95"
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate 30000
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time 30000
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/ignore_hispeed_on_notif 1
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis 80000
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_slack 30000

# cpu-boost
write /sys/module/cpu_boost/parameters/input_boost_freq "0:960000 4:768000"
write /sys/module/cpu_boost/parameters/input_boost_ms 1500

}&