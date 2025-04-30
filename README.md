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

## Ansible playbooks
* Set up SSH
```shell
  ansible-playbook -u grabka -K playbooks/setup-ssh.yml
```
*This playbook needs to be executed first as it enables passwordless sudo for the admin user*
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
* Enable unattended upgrades
