# Router Satellite (RouterOS) (Concept)

- Compatibility
  - `RouterOS` v7.x
    - [Upgrading RouterOS](https://wiki.mikrotik.com/wiki/Manual:Upgrading_RouterOS)
    - [MikroTik download archive](https://mikrotik.com/download/archive)
  - USB drive connected to MikroTik device
    - `ext4` file system
    - 500MB free space
    - Check if the connected drive is mounted as `usb1-disk1` in Files section of RouterOS

- Run
  - _(Optional)_ Backup device
  - Install `container` RouterOS package [(guide)](https://systemzone.net/how-to-install-extra-packages-in-mikrotik/)
  - Add all scripts from `routeros-scripts` into `Scripts` RouterOS menu
  - Run `register` script
  - Run `login` script

- Todo
  - Move parameters reading from _RouterOS Scripts_ into _Container_ and get this data via ssh to router directly instead of parsing files passed to volume

- Notes
  - There is a problem with sending magic packets from hosts under VPN. This solution helps to send magic packets from router to almost guarantee the delivery.
