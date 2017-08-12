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

sleep 10

# interactive
write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor interactive
write /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor interactive
write /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor interactive
write /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor interactive
restorecon_recursive /sys/devices/system/cpu/cpufreq/interactive
write /sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay 0
write /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load 100
write /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq 0
write /sys/devices/system/cpu/cpufreq/interactive/io_is_busy 1
write /sys/devices/system/cpu/cpufreq/interactive/target_loads "85 652800:45 729600:50 960000:55 1190400:60 1497600:70 1728000:75 1958400:85 2265600:95"
write /sys/devices/system/cpu/cpufreq/interactive/min_sample_time 39000
write /sys/devices/system/cpu/cpufreq/interactive/timer_rate 30000
write /sys/devices/system/cpu/cpufreq/interactive/max_freq_hysteresis 99000
write /sys/devices/system/cpu/cpufreq/interactive/timer_slack 30000

# sched
write /dev/cpuctl/cpu.notify_on_migrate 0

# cpu-boost
write /sys/module/cpu_boost/parameters/boost_ms 0
write /sys/module/cpu_boost/parameters/sync_threshold 0
write /sys/module/cpu_boost/parameters/input_boost_freq 1190400
write /sys/module/cpu_boost/parameters/input_boost_ms 250
