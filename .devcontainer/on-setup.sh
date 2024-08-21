# Install dapr cli
wget -q https://raw.githubusercontent.com/dapr/cli/master/install/install.sh -O - | /bin/bash

# Initialize dapr
dapr uninstall --all # clean if needed

scripts/setup
