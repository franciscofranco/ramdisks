#!/system/bin/sh

if [ ! -e /dev/socket/pb ]; then

  /sbin/mpdfake&

  sleep 2;

  chown root:system /dev/socket/pb;
  chmod 660 /dev/socket/pb;
  chcon u:object_r:mpdecision_socket:s0 /dev/socket/pb;

  SULIBS="/su/lib:/system/lib64:/system/lib";

  for SUPOLICY in `which supolicy sepolicy-inject`; do
    LD_LIBRARY_PATH=$SULIBS $SUPOLICY --live "allow system_server { init su supersu } unix_dgram_socket sendto";
  done;

fi;

