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
* Set up access
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
* Set up Samba
```shell
  ansible-playbook playbooks/setup-samba.yml
```
* Set up backup
```shell
  ansible-playbook playbooks/setup-backup.yml
```
* Set up Docker
```shell
  ansible-playbook playbooks/setup-docker.yml
```
* Set up Tailscale
```shell
  ansible-playbook playbooks/setup-tailscale.yml
```

## TODO
* Create playbook for NextDNS
* Migrate Docker containers
* Set up Mailrise for Pushover notifications
* Use Ansible Vault for secrets
