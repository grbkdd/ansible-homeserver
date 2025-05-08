#!/usr/bin/python3
import argparse
import sys
import requests
import yaml
import subprocess
import logging
from pathlib import Path
import os

PUSHOVER_URL = 'https://api.pushover.net/1/messages.json'


def get_etc_path():
    script_path = Path(__file__).resolve()
    return script_path.parent.parent / 'etc'


def get_rsync_passwd_path():
    etc_path = get_etc_path()
    return etc_path / 'rsync-passwd.txt'


def load_config():
    etc_path = get_etc_path()
    config_path = etc_path / 'rsync-backup.yml'
    return yaml.safe_load(config_path.read_text())


def build_command(args, config, task):
    cmd = ['sshpass', '-f', str(get_rsync_passwd_path())]
    cmd += ['rsync', '-e', 'ssh', '-ahH', '--delete']
    cmd += args
    if 'exclude' in task:
        cmd += ['--exclude', *task['exclude']]
    cmd += [task['path'], f'{config['rsync_user']}@{config['rsync_host']}::{config['rsync_module']}']
    return cmd


def build_title():
    username = os.environ.get('USERNAME')
    hostname = os.environ.get('HOSTNAME')
    title = f'{username}@{hostname}'
    return title


def push_notification(message):
    title = build_title()
    config = load_config()
    requests.post(PUSHOVER_URL, data={
        'title': title,
        'message': message,
        'user': config['pushover_user_token'],
        'token': config['pushover_app_token'],
    })


def main():
    logging.basicConfig(level=logging.INFO)
    logger = logging.getLogger('rsync-backup')
    args = sys.argv[1:]
    if "-h" in args or "--help" in args:
        print("Usage: rsync-backup [options]")
        print("All options passed to this script are passed to rsync.")
        sys.exit(0)
    logger.info('Loading configuration...')
    config = load_config()
    backup_tasks = config['backup_tasks']
    for task in backup_tasks:
        try:
            logger.info(f'Starting backup of {task['path']}')
            command = build_command(args, config, task)
            logger.info(f'Running command: {" ".join(command)}')
            subprocess.run(command, check=True)
            message = f'Backup of {task['path']} finished successfully.'
            logger.info(message)
            push_notification(message)
        except subprocess.CalledProcessError:
            message = f'Backup of {task['path']} failed.'
            logger.error(message)
            push_notification(message)


if __name__ == '__main__':
    main()
