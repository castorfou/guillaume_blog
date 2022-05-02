---
title: "Headless raspberry pi: create a wifi to ethernet bridge"
description: setup headless raspberry pi to bridge wifi (tethering from phone) to ethernet (for my home wifi-router)
toc: true
comments: true
layout: post
categories: [raspberry pi]
image: https://my.raspberrypi.org/favicon.ico
---



After my internet provider router stopped unexpectedly yesterday, I had to find a solution with internet access from phones and raspberry pi to broadcast internet to full home devices.



## Headless raspberry pi

**Installation on SD from ubuntu**

for a reason, *raspberry pi imager* snap doesn't work (due to a bug linked to QT+wayland).

I download deb ubuntu version (imager_1.6_amd64.deb) from [https://www.raspberrypi.org/software](https://www.raspberrypi.org/software) and install with dpkg. (`sudo dpkg -i imager_1.6_amd64.deb`)

With `rpi-imager`, I can install by selecting the default OS (raspberry Pi OS 32-bit), and SD card as storage.

**Headless wifi**

As explained in [https://www.raspberrypi.org/documentation/configuration/wireless/headless.md](https://www.raspberrypi.org/documentation/configuration/wireless/headless.md)

Create (touch) `wpa_supplicant.conf` in `/boot` of SD card and paste this content:

```
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=FR

network={
 ssid="AndroidAP"
 psk="<Password for your wireless LAN>"
}
```

**Headless ssh**

As explained in [https://www.raspberrypi.org/documentation/remote-access/ssh/README.md](https://www.raspberrypi.org/documentation/remote-access/ssh/README.md)

Create (touch) `ssh` in `/boot` of SD card

If it is found, SSH is enabled and the file is deleted. The content of  the file does not matter; it could contain text, or nothing at all.

## Test installation

Boot. After a couple of minutes, I have a notification on phone saying a device is connected on my phone hotspot.

![](/home/explore/git/guillaume/blog/images/raspberrypi_hotspot.jpg)

And ssh raspberry (default username/password are pi/raspberry)

```bash
$ ssh -l pi 192.168.43.179
pi@192.168.43.179's password: 
Linux raspberrypi 5.4.83-v7+ #1379 SMP Mon Dec 14 13:08:57 GMT 2020 armv7l

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Thu Mar 25 06:23:17 2021

SSH is enabled and the default password for the 'pi' user has not been changed.
This is a security risk - please login as the 'pi' user and type 'passwd' to set a new password.
```

Headless raspberry is ready to be used.

## Wifi to ethernet bridge

I will use [https://willhaley.com/blog/raspberry-pi-wifi-ethernet-bridge/](https://willhaley.com/blog/raspberry-pi-wifi-ethernet-bridge/)



The only  package that is needed is dnsmasq however from a clean install it is a  good idea to make sure everything is up-to-date:



**get up-to-date system**

```bash
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install rpi-update dnsmasq -y
sudo rpi-update
```





**Option 1 - Same Subnet**

Save this script as a [file](/guillaume_blog/files/bridge.sh) named `bridge.sh` on your Pi.

```bash
#!/usr/bin/env bash

set -e

[ $EUID -ne 0 ] && echo "run as root" >&2 && exit 1

##########################################################
# You should not need to update anything below this line #
##########################################################

# parprouted  - Proxy ARP IP bridging daemon
# dhcp-helper - DHCP/BOOTP relay agent

apt update && apt install -y parprouted dhcp-helper

systemctl stop dhcp-helper
systemctl enable dhcp-helper

# Enable ipv4 forwarding.
sed -i'' s/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/ /etc/sysctl.conf

# Service configuration for standard WiFi connection. Connectivity will
# be lost if the username and password are incorrect.
systemctl restart wpa_supplicant.service

# Enable IP forwarding for wlan0 if it's not already enabled.
grep '^option ip-forwarding 1$' /etc/dhcpcd.conf || printf "option ip-forwarding 1\n" >> /etc/dhcpcd.conf

# Disable dhcpcd control of eth0.
grep '^denyinterfaces eth0$' /etc/dhcpcd.conf || printf "denyinterfaces eth0\n" >> /etc/dhcpcd.conf

# Configure dhcp-helper.
cat > /etc/default/dhcp-helper <<EOF
DHCPHELPER_OPTS="-b wlan0"
EOF

# Enable avahi reflector if it's not already enabled.
sed -i'' 's/#enable-reflector=no/enable-reflector=yes/' /etc/avahi/avahi-daemon.conf
grep '^enable-reflector=yes$' /etc/avahi/avahi-daemon.conf || {
  printf "something went wrong...\n\n"
  printf "Manually set 'enable-reflector=yes in /etc/avahi/avahi-daemon.conf'\n"
}

# I have to admit, I do not understand ARP and IP forwarding enough to explain
# exactly what is happening here. I am building off the work of others. In short
# this is a service to forward traffic from WiFi to Ethernet.
cat <<'EOF' >/usr/lib/systemd/system/parprouted.service
[Unit]
Description=proxy arp routing service
Documentation=https://raspberrypi.stackexchange.com/q/88954/79866
Requires=sys-subsystem-net-devices-wlan0.device dhcpcd.service
After=sys-subsystem-net-devices-wlan0.device dhcpcd.service

[Service]
Type=forking
# Restart until wlan0 gained carrier
Restart=on-failure
RestartSec=5
TimeoutStartSec=30
# clone the dhcp-allocated IP to eth0 so dhcp-helper will relay for the correct subnet
ExecStartPre=/bin/bash -c '/sbin/ip addr add $(/sbin/ip -4 -br addr show wlan0 | /bin/grep -Po "\\d+\\.\\d+\\.\\d+\\.\\d+")/32 dev eth0'
ExecStartPre=/sbin/ip link set dev eth0 up
ExecStartPre=/sbin/ip link set wlan0 promisc on
ExecStart=-/usr/sbin/parprouted eth0 wlan0
ExecStopPost=/sbin/ip link set wlan0 promisc off
ExecStopPost=/sbin/ip link set dev eth0 down
ExecStopPost=/bin/bash -c '/sbin/ip addr del $(/sbin/ip -4 -br addr show wlan0 | /bin/grep -Po "\\d+\\.\\d+\\.\\d+\\.\\d+")/32 dev eth0'

[Install]
WantedBy=wpa_supplicant.service
EOF

systemctl daemon-reload
systemctl enable parprouted
systemctl start parprouted dhcp-helper
```

**Step 2:** Execute the script on your Pi like so.

```bash
sudo bash bridge.sh
```

**Step 3:** Reboot.

```bash
sudo reboot
```

**Done!**