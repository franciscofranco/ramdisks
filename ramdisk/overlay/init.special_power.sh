#!/system/bin/sh

################################################################################
# helper functions to allow Android init like script

function write() {
    echo -n $2 > $1
}

function copy() {
    cat $1 > $2
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

# gpu
chmod 0664 /sys/class/kgsl/kgsl-3d0/devfreq/max_freq
chmod 0664 /sys/class/kgsl/kgsl-3d0/devfreq/min_freq

write /sys/devices/system/cpu/cpufreq/interactive/enable_prediction 1
write /sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay 0
write /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load 100
write /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq 0
write /sys/devices/system/cpu/cpufreq/interactive/target_loads "75 1401600:60 1689600:70 1958400:85 2016000:95"
write /sys/devices/system/cpu/cpufreq/interactive/timer_rate 30000
write /sys/devices/system/cpu/cpufreq/interactive/min_sample_time 30000
write /sys/devices/system/cpu/cpufreq/interactive/ignore_hispeed_on_notif 0
write /sys/devices/system/cpu/cpufreq/interactive/io_is_busy 1

write /sys/module/cpu_boost/parameters/input_boost_freq "0:1401600"
write /sys/module/cpu_boost/parameters/input_boost_ms 1500

}&
