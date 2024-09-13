/container/print
delay 2s
/container/stop 0
delay 2s
/container/remove 0
delay 2s
/container/add file=usb1-part1/router-satellite-alpine-linux-arm32.tar interface=veth1 root-dir=usb1-part1/alpine_root envlist=alpine_envs hostname=alpine logging=yes start-on-boot=yes
delay 10s
/container/print
delay 2s
/container/start 0
delay 2s
/container/print