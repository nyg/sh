## Raspberry Pi 5 – Server

### Waveshare PCIe to M.2 Board (D)

Documentation: [Waveshare PCIe_TO_M.2_Board_(D)][1]

1. Mount board with NVMe
1. Change Rpi5 boot config to enable PCIe, reboot
   ```
   # /boot/firmware/config.txt
   dtparam=pciex1_gen=3
   ```
1. Use Raspberry Pi Imager to install the Raspberry Pi OS on the NVMe
1. Change the boot order with using `raspi-config` (Advanced Options > Boot Order)
1. Reboot, should boot using the NVMe
1. Note: using Gen. 3 once we have booted from the NVMe (i.e. doing step 2.)
   does not appear to work with the Samsung 990 Pro (boot fails).
1. Nice to have: [update the bootloader][2] ([bootloader version][3])
1. Set password, keyboard layout, hostname and timezone (could be set using the Raspberry Pi Imager, along with SSH keys, etc.)
1. Copy authorized_keys and sr.ht SSH keys from SD card
   ```sh
   mkdir ~/sdcard
   sudo mount /dev/mmcblk0p2 ~/sdcard
   cp ~/sdcard/home/user/.ssh/{authorized_keys,git@git.sr.ht*}
   ```

### Post-install

```sh
# Bootstrap
sh <(curl -s https://git.sr.ht/~nyg/sh/blob/master/bootstrap.sh)

./configure/bash.sh
./configure/git.sh

sudo apt install -y vim tree jq
./configure/vim.sh

# disable mDNS
sudo systemctl status avahi-daemon

# disable power management for wlan0
echo -e "[connection]\nwifi.powersave=2" | sudo tee /etc/NetworkManager/conf.d/wifi-powersave.conf > /dev/null
sudo systemctl restart NetworkManager
```

### Updating the bootloader EEPROM

```sh
# To be done once
sudo raspi-config # Advanced Options > Bootloader Version > Latest (Yes, Finish, Reboot)

# For each update
sudo apt update
sudo rpi-eeprom-update # if *** UPDATE AVAILABLE *** is display, run commands below
sudo rpi-eeprom-update -a
sudo reboot
```

### Bitcoin node

- Setup logrotate
- Create aliases
- cleaner config file

Summary of folders/files, proper permissions?



[1]: https://www.waveshare.com/wiki/PCIe_TO_M.2_Board_(D)
[2]: https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#update-the-bootloader-configuration
[3]: https://github.com/raspberrypi/rpi-eeprom/tree/master/firmware-2712/latest
