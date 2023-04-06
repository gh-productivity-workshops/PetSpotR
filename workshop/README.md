# Increasing Developer Productivity with GitHub Copilot and Codespaces

👋 Welcome to the workshop!

In this workshop, you'll learn lots of exciting skills around some of our most popular products. These include GitHub Codespaces and GitHub Copilot.

### Codespaces

Cloud computing has exploded in the past few decades. No longer do we need high spec computers with lots of credentials. Instead, we can code from almost anywhere in the world. [GitHub Codespaces](https://github.com/features/codespaces) is a fully configured development environment. You can spin up a Codespace in seconds, and all you need is an internet connection and a browser. In this workshop you'll learn how to:

- Start a new Codespace
  - (What is a Codespace and the benefits?)
  - Rather than create, go to create with options
  - See the available machine sizes and talk about policies
  - Create and watch it happening
  - (talk about policies while setup is going on)
- Run and Debug in a Codespace- use the "✅ Debug with Dapr" configuration
  - (Talk about ports and what's happening, port visibility)
  - In `src/backend/app.py`, put a breakpoint on line 45 (`print(f'Pet state retrieved', flush=True)`)
  - Open app on port 5114
  - Go to *I lost my pet* and fill out the form. Use any image, we don't actually process them.
  - Notice the breakpoint has been hit and you can examine the `data` object.
  - Stop the running debuggers
- Understand the details around Codespaces
  - Open the `.devcontainer/devcontainer.json` file and explore. (Focus on the following):
    - `image` - this is the docker image the Codespace uses. You can also create your own, and have a docker compose file for multi-stage builds.
    - `onCreateCommand` - this lets us run our own scripts when the Codespace is created. There's also `postCreateCommand` if you need to wait until everything is ready to go.
    - `features` - the easiest way to add broader features to your Codespace. In our case we've added python and docker-in-docker (allows us to run multiple containers inside our Codespace!). You can find out more at https://containers.dev/features
    - `customizations.vscode.extensions` - These are the extensions you want VSCode to have when you start a Codespace.
  - (Point out that if you change this devcontainer in your Codespace, you can rebuild and see the changes. But if you commit and push to your repository, every Codespace created after that point will use this definition. You can also have multiple devcontainers and choose which to use for your Codespace - as seen when we created one with options)
  - Make a devcontainer change - We're about to use Copilot, so let's add that extension - not just to VSCode, but to the devcontainer
    - Open the Extensions pane
    - Search for "Copilot" and select the GitHub Copilot extension (don't click Install!)
    - Rather than clicking install, click the cog icon and select "Add to devcontainer.json".
    - Go back to the `devcontainer.json` file and see the change. Note that the extension hasn't been installed at this point!
  - Reload your Codespace and see the changes.
    - Ctrl/Cmd-Shift-P, then type "rebuild" to find it. Choose the "Codespaces: Rebuild Container" option. Confirm the dialog by clicking "Rebuild" and wait for it to reload.
    - Once reloaded, you'll be able to see Copilot installed - both in the Extensions pane, as well as via the Copilot logo bottom right!
    - (Note: This may take a little while. While it's running, explain why - we were using Prebuilds before!)

### GitHub Copilot

In the past few months artifically intelligent (AI) programs have exploded. Everyone is using them for increased productivity. [GitHub Copilot](https://github.com/features/copilot) is your AI pair programmer. It can help you write, synthese, understand, and explain code. In this workshop you will learn how to:

- Let's add more detail to our lost pet form using GitHub Copilot - where the pet was last seen
  - Add to the Lost Pet page:
    - Go to LostPet.razor (you can get there quickly with `Ctrl/Cmd-P`, then typing the filename)
    - (Ensure Copilot is turned on using the icon at the right of the status bar - explain you can turn it on or off here)
    - (NOTE: Copilot is non-deterministic, so attendees might get different suggestions. Guide them towards the same end point)
    - Go to line 50 and add a new line after the `</div>` but before `@if (isLoading)`
    - Type `<!-- Step 2.5 - pet's last location h2 element followed by a dropdown -->` - this is an HTML comment explaining what we want. Press Enter to go to the next line
    - Copilot should make a suggestion with an `h2` heading. Hit Tab to accept the suggestion.
    - On the next line, write `<!-- Dropdown menu with location -->` and hit Enter.
    - Copilot should suggest an HTML dropdown with several locations, but they're probably not the right ones for us, so let's provide more context.
    - Update the comment to `<!-- Dropdown menu with 5 locations in [your city] -->` - replace [your city] with the name of your city and hit Enter again.
    - Copilot should make some more accurate suggestions. Hit Tab to accept.
    - Make further changes to ensure `div` elements are closed, and modify as needed - Copilot is likely to help here as well.
  - Add to the PetModel
    - You'll notice that there's no Location field in PetModel (the red squiggles), so let's fix that
    - Again, use `Ctrl/Cmd-P` to search for `PetModel.cs` and go to that file.
    - Add a new line after line 13 (`public List<string> Images { get; set; }`)
    - Add `public string Location { get; set; }`. Copilot may start helping you at some point, but if not, don't worry!
    - Add a new line after line 25 (`Images = new();`). Copilot will almost certainly fill in what we need (`Location = "";`), so hit Tab to accept.

- Debug using GitHub Copilot - you'll see the changes!
  - Save the files you've edited.
  - Use Run and Debug to debug the application again.
  - You'll see the new field.

- (Optional exercise depending on time) Note that we've only made front-end changes. See if Copilot can help you make backend changes as well!
  - Look for where to add details about the location to `petspotr.py` and `app.py`

- Use GitHub Copilot to write tests
  - In the `src/tests/playwright/tests` folder, create a new file called `lostpage.spec.ts`.
  - In that file, write a comment saying `// create playwright tests for LostPet.razor`
  - (Note that you should leave the LostPet.razor file open in VSCode so Copilot can see this context!)
  - On the next line, write a comment that says `// import dependencies` and hit Enter
  - Copilot should suggest something like `import { test, expect } from @playwright/test`;
  - (If this doesn't work, try opening another test file for context - this is a good opportunity to explain a little about how Copilot gets its context)
  - After this, write a comment saying `// test that h2 element with the words "Step 1: Tell us about your pet and how to contact you" renders` and hit Enter
  - Copilot should do a good job of giving you the test function, although it may give it to you line by line. Hit Tab to accept until you're happy.
  - Write a comment that says `// test that dropdown menu renders` and hit Enter
  - Copilot again should do a good job - in my case it even suggests looking for `Dog` in the dropdown!
  - Finally, try adding a comment saying, `// test that you can upload images when you click Choose Files button`
  - (Note that last one is more temperamental and might need extra prompting. Lead people to something similar to the screenshot)
