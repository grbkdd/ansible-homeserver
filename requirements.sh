#!/bin/bash

echo "Installing required roles..."
ansible-galaxy role install -r requirements.yml -p .galaxy-roles
echo "Installing required collections..."
ansible-galaxy collection install -r requirements.yml -p .galaxy-collections
echo "Done."
