# Install dapr cli
wget -q https://raw.githubusercontent.com/dapr/cli/master/install/install.sh -O - | /bin/bash

# Install python dependencies
pip install -r /workspace/src/backend/requirements.txt

# dotnet restore
dotnet restore /workspace/src/frontend/PetSpotR/PetSpotR.csproj

# Initialize dapr
dapr uninstall # clean if needed
dapr init