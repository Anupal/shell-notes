# RaspberryPi Setup

# 1. Flashing image on SD card

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

## 4. Using Raspberry Pi as Access point and MITM for main WiFi connection
```
Laptop --wifi1-- RPi --wifi2-- Router -- Internet
```

### 4.1 Install packages for Access point, DNS and DHCP
```
sudo apt-get install hostapd dnsmasq
```

### 4.2 Add UAP interface which will act as Access point
**Add to bottom of `/etc/dhcpcd.conf`**
- configure static ip
- make sure interface doesn't take config from wap_supplicant files
  ```
  interface uap0
	  static ip_address=192.168.4.1/24
          nohook wpa_supplicant
  ```

### 4.3 DNS and DHCP config for Access point
- create backup of dnsmasq config
```
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
```
- create new dnsmasq config - `/etc/dnsmasq.conf`
```
interface=lo,uap0               #Use interfaces lo and uap0
bind-interfaces                 #Bind to the interfaces
server=8.8.8.8                  #Forward DNS requests to Google DNS
domain-needed                   #Don't forward short names
bogus-priv                      #Never forward addresses in the non-routed address spaces
# Assign IP addresses between 192.168.4.50 and 192.168.4.150 with a 12-hour lease time
dhcp-range=192.168.4.50,192.168.4.150,12h
```

### 4.4 Core config for Access point
- Create `/etc/hostapd/hostapd.conf` - 2.4GHz
  ```
  # Set the channel (frequency) of the host access point
  channel=1
  # Set the SSID broadcast by your access point (replace with your own, of course)
  ssid=yourSSIDhere
  # This sets the passphrase for your access point (again, use your own)
  wpa_passphrase=passwordBetween8and64charactersLong
  # This is the name of the WiFi interface we configured above
  interface=uap0
  # Use the 2.4GHz band (I think you can use in ag mode to get the 5GHz band as well, but I have not tested this yet)
  hw_mode=g
  # Accept all MAC addresses
  macaddr_acl=0
  # Use WPA authentication
  auth_algs=1
  # Require clients to know the network name
  ignore_broadcast_ssid=0
  # Use WPA2
  wpa=2
  # Use a pre-shared key
  wpa_key_mgmt=WPA-PSK
  wpa_pairwise=TKIP
  rsn_pairwise=CCMP
  driver=nl80211
  # I commented out the lines below in my implementation, but I kept them here for reference.
  # Enable WMM
  #wmm_enabled=1
  # Enable 40MHz channels with 20ns guard interval
  #ht_capab=[HT40][SHORT-GI-20][DSSS_CCK-40]
  ```
- Create `/etc/hostapd/hostapd.conf` - 5GHz
  ```
  # Set the channel (frequency) of the host access point
  channel=36
  # Set the SSID broadcast by your access point (replace with your own, of course)
  ssid=yourSSIDhere
  # This sets the passphrase for your access point (again, use your own)
  wpa_passphrase=passwordBetween8and64charactersLong
  
  # IEEE stuff
  country_code=IN
  # limit the frequencies used to those allowed in the country
  ieee80211d=1
  # 802.11n support
  ieee80211n=1
  # 802.11ac support
  ieee80211ac=1
  
  # This is the name of the WiFi interface we configured above
  interface=uap0
  # Use the 5GHz band
  hw_mode=a
  # Accept all MAC addresses
  macaddr_acl=0
  # Use WPA authentication
  auth_algs=1
  # Require clients to know the network name
  ignore_broadcast_ssid=0
  # Use WPA2
  wpa=2
  # Use a pre-shared key
  wpa_key_mgmt=WPA-PSK
  wpa_pairwise=TKIP
  rsn_pairwise=CCMP
  
  # Enable WMM
  wmm_enabled=1
  # Enable 40MHz channels with 20ns guard interval
  #ht_capab=[HT40][SHORT-GI-20][DSSS_CCK-40]
  ```
- make hostapd use above config by editing `/etc/default/hostapd`.
  ```
  DAEMON_CONF="/etc/hostapd/hostapd.conf"
  ```

### 4.5 Bringup UAP interface
```
sudo systemctl stop hostapd.service
sudo systemctl stop dnsmasq.service
sudo systemctl stop dhcpcd.service
sudo iw dev wlan0 interface add uap0 type __ap
sudo sysctl net.ipv4.ip_forward=1
sudo iptables -t nat -A  POSTROUTING -o wlan0 -j MASQUERADE
sudo ifconfig uap0 up
sudo systemctl start hostapd.service
sudo systemctl start dhcpcd.service
sudo systemctl start dnsmasq.service
```

### Reference
- https://forums.raspberrypi.com/viewtopic.php?t=211542
- https://raspberrypi-guide.github.io/networking/create-wireless-access-point
