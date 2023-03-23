# Install dapr cli
wget -q https://raw.githubusercontent.com/dapr/cli/master/install/install.sh -O - | /bin/bash

# Initialize dapr
dapr uninstall # clean if needed
dapr init

# Install python dependencies
pip install -r ./src/backend/requirements.txt

# dotnet restore
dotnet restore ./src/frontend/PetSpotR/PetSpotR.csproj
