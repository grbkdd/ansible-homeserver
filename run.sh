#!/bin/bash

usage() {
    echo "Usage: $0 -u username"
    exit 1
}

[ $# -eq 0 ] && usage

while getopts "u:h" opt; do
    case ${opt} in
        u)
            username="$OPTARG"
            ;;
        h)
            usage
            ;;
        ?)
            usage
            ;;
    esac
done

ansible-playbook -i inventory -u "$username" site.yml
