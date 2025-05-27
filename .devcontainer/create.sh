#!/bin/bash

# Immediately catch all errors
set -eo pipefail

# Uncomment for debugging
# set -x
# env

cd /home/vscode/XARM

. /opt/ros/humble/setup.sh
colcon build 