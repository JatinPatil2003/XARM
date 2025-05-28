#!/bin/bash

# Immediately catch all errors
set -eo pipefail

# Uncomment for debugging
# set -x
# env

echo "Running post-create script..."

echo "Finished post-create script."

# echo 'source /home/vscode/Nav2/install/setup.bash' >> ~/.bashrc && echo 'if [ -f ~/.bashrc ]; then . ~/.bashrc; fi' >> ~/.bash_profile