# Ansible Home Server

## System installation

Install Ubuntu Server following the steps below.

### Ubuntu Server installation steps

* Language
    * Select "English"
* Keyboard configuration
    * Leave defaults
* Type of installation
    * Select "Ubuntu Server"
    * Enable "Search for third-party drivers"
* Network configuration
    * Review and leave defaults
* Proxy configuration
    * Leave blank
* Ubuntu archive mirror configuration
    * Review and leave defaults
* Guided storage configuration
    * Select "Use an entire disk"
    * Disable "Set up this disk as an LVM group"
* Storage configuration
    * Review and leave defaults
    * Select "Continue" when asked to confirm
* Profile configuration
    * Provide admin user details
    * Provide server's name
* Ubuntu Pro
    * Select "Skip for now"
* SSH configuration
    * Enable "Install OpenSSH server"
* Third-party drivers
    * Install, if any
* Featured server snaps
    * Skip installing snaps for now

### Post-install instructions

Copy SSH keys to the machine.

```shell
  ssh-copy-id <hostname>
```

Login over SSH.

```shell
  ssh <hostname>
```

Upgrade packages on the system to the latest version.

```shell
  sudo apt update && sudo apt dist-upgrade
```

Reboot

```shell
  sudo reboot
```

## Ansible

Configure the system using Ansible.

### Command

Use the following command to execute a playbook:

```shell
  ansible-playbook playbooks/<playbook>.yml
```

### Playbooks

| Playbook             | Description                                | Comments                                                                |
|----------------------|--------------------------------------------|-------------------------------------------------------------------------|
| playbooks/sudo.yml   | Enable passwordless sudo for default user. | Use first. Use "--ask-become-pass" or "-K" to provide password to sudo. |
| playbooks/system.yml | Configure system.                          | Use second.                                                             |
| playbooks/docker.yml | Deploy Docker applications.                | Use third.                                                              |
| playbooks/all.yml    | Run everything in one shot.                | Use instead of the other playbooks.                                     |

