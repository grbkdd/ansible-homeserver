# Homelab Setup

## General

### Upgrade the system after the installation:
```
sudo apt update
sudo apt dist-upgrade
```

### Set up terminal fonts:
```
sudo apt install fonts-terminus
sudo dpkg-reconfigure console-setup
```

### Switch default editor to Vim:
```
sudo update-alternatives --config editor
```

### Install mDNS server:
```
sudo apt install avahi-daemon
```

### Configure sudo not to ask for password anymore:
```
echo "grabka ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/admin
```

### Import existing ZFS volumes:
```
sudo apt install zfsutils-linux
sudo zpool import -a
```

### Extend LVM volumes:
```
sudo lvextend -l +100%FREE /dev/mapper/ubuntu--vg-ubuntu--lv
sudo resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv
```

### Disable built-in DNS server:
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

### Configure power button
```
sudo apt install acpid
mkdir -p /etc/systemd/logind.conf.d/
echo "HandlePowerKey=poweroff" | sudo tee /etc/systemd/logind.conf.d/poweroff.conf
```

### Set up backups

```
sudo apt install sshpass
sudo cp -a backup /opt
sudo cat > /opt/backup/.env << EOF
RSYNC_PASSWORD=
APP_TOKEN=
USER_TOKEN=
EOF
sudo crontab -e
```

Use the following configuration:
```
45 6 * * * /opt/backup/rsync-docker 2>&1 | /usr/bin/logger -t BACKUP
0 7 * * * /opt/backup/rsync-disk 2>&1 | /usr/bin/logger -t BACKUP
```

## Docker
[Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)


## Portainer
[Install Portainer CE with Docker on Linux](https://docs.portainer.io/start/install-ce/server/docker/linux)

[Restore Portainer configuration from backup](https://docs.portainer.io/admin/settings#restoring-from-a-local-file)

## Tailscale
[Install Tailscale](https://tailscale.com/kb/1347/installation)

[Configure tailnet's DNS](https://tailscale.com/kb/1114/pi-hole)

[Set up a subnet router](https://tailscale.com/kb/1019/subnets)
