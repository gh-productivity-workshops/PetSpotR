## Run PetSpotR in a GitHub Codespace

Cloud computing has exploded in the past few decades. But the cloud can be used for more than just running production workloads - it can host your development environments as well!

[GitHub Codespaces](https://github.com/features/codespaces) allow you to code from almost anywhere in the world, giving you Visual Studio Code backed by high performance VMs that start in seconds and can be customized to perfectly suit the code you're working on.

The advantages of using Codespaces over local development are many. You can standardize on a set of dependencies for a project, onboard a new developer in seconds rather than days, and spin up and tear down context-aware Codespaces at a moment's notice.

>[!knowledge] 🤯 Fun Fact: GitHub itself uses Codespaces to develop GitHub! New engineers can go from zero to ready to code in about 10 seconds. And that's on an 11GB codebase!

Your first task is to launch a GitHub Codespace, customize it, and then launch PetSpotR within it.

### 1.1 Launch a GitHub Codespace

You'll begin by launching a new GitHub Codespace. This will give you a pre-configured environment with all the tools you need to run PetSpotR.

1. Navigate to the [PetSpotR GitHub repository](https://github.com/Azure-Samples/PetSpotR/tree/build-2023-lab), and make sure you are on the `build-2023-lab` branch
2. Sign into GitHub with your GitHub account
3. Click the `<> Code` button and select the `Codespaces` tab
   ![New Codespace with Options](./images/1-new-codespace.png)
4. Click the `+` button to launch a new Codespace on the `build-2023-lab` branch
   - If you're unable to launch a Codespace please talk to a lab assistant. We'll need to add you to the org so we can bill the Codespace to the lab.

You should now drop directly into a Codespace with the PetSpotR repository cloned and ready to go.

### 1.2 Explore the Codespace

1. In the Codespace terminal, run `ls -1 -a` to list the files in the repository:
    
    ```bash
    $ ls -1 -a
    ```
    > Note: The `-1` flag will list the files one per line, and the `-a` flag will list all files, including hidden files.

    You should see the following files:

    ```
    .
    ..
    .devcontainer
    docs
    .git
    .github
    .gitignore
    iac
    img
    LICENSE
    README.md
    src
    tests
    .vscode
    ```

    Important directories to note are:

    - `.devcontainer` contains the configuration for this Codespace environment.
    - `docs` contains the documentation for the application, including this lab guide.
    - `iac`  contains the Bicep infrastructure as code (IaC) for the application. We'll revisit this directory later in the lab.
    - `src`  contains the source code for the application's backend and frontend services.
    - `.vscode` contains the configuration for both the Codespace and Visual Studio Code.

2. Your Codespace also can run Docker containers inside of it! Run `docker ps` to list the running containers:
    
    ```bash
    docker ps
    ```

    You should see the following containers:

    ```
    CONTAINER ID   IMAGE                COMMAND                 ...
    57e30aa3124c   openzipkin/zipkin    "start-zipkin"          ...
    570e831d9299   daprio/dapr:1.10.5   "./placement"           ...
    ff778032cc52   redis:6              "docker-entrypoint.s…"  ...
    ```

    These are the default Dapr containers for Zipkin, Dapr placement service, running in the Codespace. They will be used when you run PetSpotR locally later on.
3. Let's take a look at how to customize your Codespace. Open `.devcontainer/devcontainer.json` to see the Codespace definition:

   ```bash
   code .devcontainer/devcontainer.json
   ```

   You'll notice some important properties:
   
   - `image` - The Docker image used to create the Codespace
   - `onCreateCommand` - The command to run when the Codespace is created, which can be used to install dependencies or other setup tasks
   - `features` - A list of [features](https://github.com/devcontainers/features) to install in the Codespace, such as Python support, the Azure CLI, or Docker-in-Docker support
   - `customizations.vscode.extensions` - A list of Visual Studio Code extensions to install in the Codespace

### 1.3 Customize your Codespace

Now that you're up and running with your Codespace, let's get ready to use GitHub Copilot!

Let's add the GitHub Copilot extension, but let's add it to the devcontainer rather than just install it.

1. Open the "Extensions" (![Extensions](images/extensions.png)) pane
2. Search for "Copilot" and select the GitHub Copilot extension
![GitHub Copilot extension](images/8-copilot-extension.png)
3. Don't click the green "Install in Codespaces" button! Instead, click the cog icon (⚙️) and select "Add to devcontainer.json".
![Add extension to devcontainer](images/9-copilot-extension-devcontainer.png)
4. Go back to the `devcontainer.json` file and see the change. Note that the extension hasn't been installed in your Codespace at this point.
![Extension added to the devcontainer](images/10-copilot-devcontainer-change.png)

To see the change, we'll need to rebuild our Codespace.

6. Using your keyboard, press `Ctrl/Cmd-Shift-P`, then type "rebuild" to find the "Codespaces: Rebuild Container" option. Select it and press Enter, or click it with the mouse.
![Rebuilding your Codespace](images/11-rebuild-codespace.png)
7. Confirm your choice by clicking "Rebuild" and wait for your Codespace to reload.
![Confirm the rebuild](images/12-rebuild-codespace-confirm.png)
 _This may take a little longer than your first build! This is because we're taking advantage of a feature called Prebuilds. Your instructor will show you how to set these up and explain why they're useful._
8. Once reloaded, you'll be able to see GitHub Copilot installed - both in the Extensions pane, as well as via the GitHub Copilot logo at the bottom right of the status bar!

   ![Copilot Logo](images/13-copilot-icon.png)

### 1.4 Run PetSpotR locally

Now that you are familiar with the Codespace, you can run PetSpotR locally.

1. Open `.vscode/launch.json` to see the launch configurations for the Codespace. You'll use these to run PetSpotR locally:

    ```bash
    code .vscode/launch.json
    ```

    You should see launch configurations for:

    - `frontend with Dapr` - Launches the frontend service with Dapr
    - `backend with Dapr` - Launches the backend service with Dapr

    You'll also see a compound launch configuration called `✅ Debug with Dapr` that will launch both the frontend and backend services with Dapr.

1. Select the `Run and Debug` (![](images/debug.png)) tab in the left-hand pane of the Codespace.
2. Make sure the launch configuration is set to `✅ Debug with Dapr`
3. Click the `Start Debugging` button (▶️) to launch PetSpotR locally

You'll now see the PetSpotR application launch in a new browser tab. You can use this application to explore the functionality of PetSpotR.

### 1.5 Explore PetSpotR

You can now explore the PetSpotR application which is running in your Codespace.

> **Note**: Codespaces automatically forwards local ports and makes them available in the browser. The URL which was automatically opened uses `...app.github.dev` to connect you to your Codespace. You can also use the `PORTS` tab in the Codespace to find the port that was forwarded to the application.

1. Visit the `Lost` and `Found` pages to see the application's interface. Dapr has not been added to the application yet, so you'll see errors in the browser console if you try to fill out the form.
2. Return to your Codespace and take a look at your frontend logs. You'll see print statements for the `Lost` and `Found` pages, where calls to Dapr need to be added.
3. Stop the debuggers by clicking the `Stop Debugging` button (⏹️) in the top debug bar. You'll need to stop both the frontend and backend debuggers.

Done! You now have a Codespace with PetSpotR running locally. You can now use GitHub Copilot to add Dapr to the application.

_The instructor will now demonstrate how to use GitHub Copilot to add Dapr to the application. You can wait to follow along, or you can continue with the exercises below._

