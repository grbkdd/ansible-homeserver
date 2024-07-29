#!/bin/bash
echo "Upgrading..."
sudo apt update
sudo apt dist-upgrade
echo "Setting up console..."
sudo apt install fonts-terminus
sudo dpkg-reconfigure console-setup
sudo update-alternatives --config editor
echo "Installing mDNS server..."
sudo apt install avahi-daemon
echo "Configuring sudo..."
echo "grabka ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/admin
echo "Importing ZFS volumes..."
sudo apt install zfsutils-linux
sudo zpool import -a
echo "Extending LVM volumes..."
sudo lvextend -l +100%FREE /dev/mapper/ubuntu--vg-ubuntu--lv
sudo resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv
echo "Configuring systemd-resolved..."
mkdir -p /etc/systemd/resolved.conf.d
cat > /etc/systemd/resolved.conf.d/adguardhome.conf << EOF
[Resolve]
DNS=127.0.0.1
DNSStubListener=no
EOF
rm -f /etc/resolv.conf
ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
systemctl reload-or-restart systemd-resolved
echo "Configuring tailscale..."
sudo tailscale set --accept-dns=false

