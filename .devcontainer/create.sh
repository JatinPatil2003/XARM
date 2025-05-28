#!/bin/bash

# Immediately catch all errors
set -eo pipefail

# Uncomment for debugging
# set -x
# env

cd /home/ubuntu/XARM

. /opt/ros/humble/setup.sh

if [ -f install/setup.bash ]; then
    . install/setup.bash
    colcon build --symlink-install
else
    colcon build --symlink-install --executor sequential
fi