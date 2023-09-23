# Make backup
#/system backup save

# Enable containers
#/system/device-mode/update container=yes

# Reboot

# Add veth interface for the container:
#/interface/veth/add name=veth1 address=172.17.0.2/24 gateway=172.17.0.1

# Create a bridge for containers and add veth to it
#/interface/bridge/add name=containers
#/ip/address/add address=172.17.0.1/24 interface=containers
#/interface/bridge/port add bridge=containers interface=veth1

# Setup NAT for outgoing traffic:
#/ip/firewall/nat/add chain=srcnat action=masquerade src-address=172.17.0.0/24

# Define environment variables
#/container/envs/add name=alpine_envs key=PASSWD value="letmein"

# Define mounts
#/container/mounts/add name=alpine_data src=usb1-part1/alpine_data dst=/data

# Set registry-url (for downloading containers from Docker registry)  and set extract directory (tmpdir) to attached USB media
/container/config/set registry-url=https://registry-1.docker.io tmpdir=usb1-part1/container_pull

# Pull & add image
/container/add remote-image=alpine:latest interface=veth1 root-dir=usb1-part1/alpine_root envlist=alpine_envs hostname=alpine

# Enable logging
/container/set 0 logging=yes

# Start on boot
/container/set 0 start-on-boot=yes

# Print info
/container/print

# Wait for extracting
#delay 30s

# Start container
#/container/start 0

# Print info
#/container/print
