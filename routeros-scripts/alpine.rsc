# Make backup
/system backup save

# Enable containers
/system/device-mode/update container=yes

# Reboot

# Add veth interface for the container:
/interface/veth add address=192.168.88.2/24 gateway=192.168.88.1 name=veth1

# Create a bridge for containers and add veth to it
/interface bridge port add bridge=bridge interface=veth1

# Define environment variables
/container/envs/add name=alpine_envs key=PASSWD value="letmein"

# Define mounts
/container/mounts/add name=alpine_data src=usb1-part1/alpine_data dst=/data

# Set registry-url (for downloading containers from Docker registry)  and set extract directory (tmpdir) to attached USB media
/container/config/set registry-url=https://registry-1.docker.io tmpdir=usb1-part1/container_pull

# Pull & add image
/container/add file=usb1-part1/router-satellite-alpine-linux-arm32.tar interface=veth1 root-dir=usb1-part1/alpine_root envlist=alpine_envs hostname=alpine logging=yes start-on-boot=yes
#/container/add remote-image=alpine:latest interface=veth1 root-dir=usb1-part1/alpine_root envlist=alpine_envs hostname=alpine logging=yes start-on-boot=yes

# Print info
/container/print

# Wait for extracting
delay 8s

# Start container
/container/start 0

# Print info
/container/print
