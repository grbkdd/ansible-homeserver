# Homelab Setup

## System installation
* Install Debian
  * Disable root account.
  * Set up LVM with default partitioning scheme.
  * Install only required packages + SSH server.
* Install Python
```shell
  sudo apt install python3 python3-pip python3-pexpect
```
* Copy SSH keys
```shell
  ssh-copy-id zapodaj.local
```

## Ansible playbooks
* Set up SSH
```shell
  ansible-playbook -K playbooks/setup-access.yml
```
*This playbook should be executed first as it enables passwordless sudo for the user.*
* Upgrade system
```shell
  ansible-playbook playbooks/upgrade-system.yml
```
* Set up system
```shell
  ansible-playbook playbooks/setup-system.yml
```
* Set up ZFS
```shell
  ansible-playbook playbooks/setup-zfs.yml
```
*During execution of this playbook the server will get restarted. Follow the instructions [here](https://github.com/dell/dkms#secure-boot) to complete MOK key enrollment.*

## TODO
* Create playbook for backups
* Create playbook for Docker
* Create playbook for Tailscale
* Create playbook for NextDNS
* Set up Mailrise for Pushover notifications
* Use Ansible Vault for secrets
