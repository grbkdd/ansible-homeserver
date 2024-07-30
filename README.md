# Homelab

## Setup instructions
Upgrade the system after the installation:
```
sudo apt update
sudo apt dist-upgrade
```

Set up terminal fonts:
```
sudo apt install fonts-terminus
sudo dpkg-reconfigure console-setup
```

Switch default editor to VI:
```
sudo update-alternatives --config editor
```

Install mDNS server:
```
sudo apt install avahi-daemon
```

Configure sudo not to ask for password anymore:
```
echo "grabka ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/admin
```

Import existing ZFS volumes:
```
sudo apt install zfsutils-linux
sudo zpool import -a
```

Extend LVM volumes:
```
sudo lvextend -l +100%FREE /dev/mapper/ubuntu--vg-ubuntu--lv
sudo resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv
```

Disable built-in DNS server:
```
sudo mkdir -p /etc/systemd/resolved.conf.d
sudo cat > /etc/systemd/resolved.conf.d/adguardhome.conf << EOF
[Resolve]
DNS=127.0.0.1
DNSStubListener=no
EOF
sudo rm -f /etc/resolv.conf
sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
sudo systemctl reload-or-restart systemd-resolved
```

## Tailscale configuration
### DNS
[Use Homelab's DNS over Tailscale](https://tailscale.com/kb/1114/pi-hole)
### Subnet router
[Set up a subnet router](https://tailscale.com/kb/1019/subnets)

## Backups
### Install dependencies
```
sudo apt install sshpass
```
### Enable separate cron logs:
```
sudo sed -i '/^#cron\.\*.*/s/^#//' /etc/rsyslog.d/50-default.conf
sudo service rsyslog restart
```
### Copy backup scripts
```
sudo cp ~/homelab/backup/*.sh /etc/cron.daily/
```