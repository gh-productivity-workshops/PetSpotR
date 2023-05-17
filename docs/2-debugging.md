## Run PetSpotR in a GitHub Codespace

In this exercise you'll learn how to run PetSpotR in your GitHub Codespace and debug the application.

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

