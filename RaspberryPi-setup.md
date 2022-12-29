# RaspberryPi Setup

[Download and install Raspberry Pi Imager](https://www.raspberrypi.com/software)
- Use 64 bit RPi OS for better performance.
- User needs to be created.
- SSH can be enabled.
- WiFi config can be provided.
- Takes around 5 mins.

## 2. Setting up Ethernet over USB-C connection
1. Add `dtoverlay=dwc2` at bottom of `config.txt`
2. Add `modules-load=dwc2,g_ether` between `rootwait` and `quiet` in `cmdline.txt`

References:
- https://howchoo.com/pi/raspberry-pi-gadget-mode

## 3. Setup WiFi later on
Create `/boot/wpa_supplicant.conf` or edit `/etc/wpa_supplicant/wpa_supplicant.conf` and reboot.
```
country=US
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
network={
  ssid="YOURSSID"
  scan_ssid=1
  psk="YOURPASSWORD"
  key_mgmt=WPA-PSK
}
```
