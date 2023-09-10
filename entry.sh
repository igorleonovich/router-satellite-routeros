#!/bin/sh
set -e

PASSWD=${PASSWD:-letmein}

echo "Initializing env..."
mkdir -p /data/ssh /data/root /data/log
touch /var/log/wtmp
chmod 0664 /var/log/wtmp
chown root:utmp /var/log/wtmp

echo "Generating server keys..."
ssh-keygen -A

echo "Setting password for root user..."
echo "Password: $PASSWD"
echo "root:${PASSWD}" | chpasswd

echo "Starting ssh server..."
/usr/sbin/sshd -eD -f /sshd_config
