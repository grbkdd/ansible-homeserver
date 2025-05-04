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

## Ansible

Configure the system using Ansible. Use the following command to execute a playbook:

```shell
  ansible-playbook playbooks/<playbook>.yml
```

### Playbooks

| Playbook                      | Description                                    | Comments                                                                                                                                            |
|-------------------------------|------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|
| playbooks/setup-sudo.yml      | Enable passwordless sudo for the user.         | Execute this playbook first. Use "--ask-become-pass" or "-K" option to provide password to sudo.                                                    |
| playbooks/upgrade-system.yml  | Upgrade all packages in the system.            | Equivalent of "apt update && apt dist-upgrade".                                                                                                     |
| playbooks/setup-system.yml    | Install and configure basics.                  |                                                                                                                                                     |
| playbooks/setup-zfs.yml       | Install ZFS support and import existing pools. | During execution the server will get rebooted. Follow instructions [here](https://github.com/dell/dkms#secure-boot) to complete MOK key enrollment. |
| playbooks/setup-backup.yml    | Configure backup.                              |                                                                                                                                                     |
| playbooks/setup-docker.yml    | Install Docker.                                |                                                                                                                                                     |
| playbooks/setup-samba.yml     | Install and configure Samba.                   |                                                                                                                                                     |
| playbooks/setup-tailscale.yml | Install and configure Tailscale.               |                                                                                                                                                     |
| playbooks/setup-nextdns.yml   | Install and configure NextDNS.                 |                                                                                                                                                     |

## TODO

* Review and test all playbooks thoroughly
* Migrate Docker containers
* Set up Mailrise for Pushover notifications
* Use Ansible Vault for secrets
