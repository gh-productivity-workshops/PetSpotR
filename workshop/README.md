# Increasing Developer Productivity with GitHub Copilot and Codespaces

👋 Welcome to the workshop!

In this workshop, you'll learn lots of exciting skills around some of our most popular products. These include GitHub Codespaces and GitHub Copilot.

### Codespaces

Cloud computing has exploded in the past few decades. No longer do we need high spec computers with lots of credentials. Instead, we can code from almost anywhere in the world. [GitHub Codespaces](https://github.com/features/codespaces) is a fully configured development environment. You can spin up a Codespace in seconds, and all you need is an internet connection and a browser. In this workshop you'll learn how to:

- Start a new Codespace
- Understand what a Codespace is and its benefits
- Run and Debug in a Codespace- use the "✅ Debug with Dapr" configuration
- Understand the details around Codespaces
- Understand the `.devcontainer/devcontainer.json` file and explore it
- Make a devcontainer change

### GitHub Copilot

In the past few months artifically intelligent (AI) programs have exploded. Everyone is using them for increased productivity. [GitHub Copilot](https://github.com/features/copilot) is your AI pair programmer. It can help you write, synthese, understand, and explain code. In this workshop you will learn how to:

- Use GitHub Copilot in the devcontainer
- Add more detail to your pages using GitHub Copilot 
- Debug using GitHub Copilot - you'll see the changes!
- Run and debug applications
- Use GitHub Copilot to write tests
- Write comments using GitHub Copilot
- (optional) use GitHub Copilot for backend changes

## Workshop

So now you know what you'll learn in this workshop, let's walk through the steps.

#### 1. Start a new Codespace

1. Listen to explaination around Codespaces and the benefits
2. Instead of clikcing "Create", click "Create with options"
3. See the available machine sizes and talk about policies
4. Click "Create with options", and watch your Codespace build
5. Listen to instructor talk about policies while you're waiting for your Codespace to spin up

#### 2. Run and Debug in a Codespace

1. Use the "✅ Debug with Dapr" configuration
2. Listen to instructor talk about ports and what's happening, port visibility
3. In the file `src/backend/app.py`, put a breakpoint on line 45 (`print(f'Pet state retrieved', flush=True)`)
4. Open app on port 5114
5. Go to *I lost my pet* and fill out the form. Use any image, we don't actually process them.
6. Notice the breakpoint has been hit and you can examine the `data` object.
7. Stop the running debuggers

#### 3. Understand the details around Codespaces

Open the `.devcontainer/devcontainer.json` file and explore. Focus on the following:
    - `image` - this is the docker image the Codespace uses. You can also create your own, and have a docker compose file for multi-stage builds.
    - `onCreateCommand` - this lets us run our own scripts when the Codespace is created. There's also `postCreateCommand` if you need to wait until everything is ready to go.
    - `features` - the easiest way to add broader features to your Codespace. In our case we've added python and docker-in-docker (allows us to run multiple containers inside our Codespace!). You can find out more at https://containers.dev/features
    - `customizations.vscode.extensions` - These are the extensions you want VSCode to have when you start a Codespace.
  - Your instructor should point out that if you change this devcontainer in your Codespace, you can rebuild and see the changes. But if you commit and push to your repository, every Codespace created after that point will use this definition. You can also have multiple devcontainers and choose which to use for your Codespace - as seen when we created one with options.

### GitHub Copilot

Now that you're up and running with Codespaces, let's start using GitHub Copilot!

#### 4. Make changes to the devcontainer using GitHub Copilot

Now, we're about to use GitHub Copilot, so let's add that extension - not just to VSCode, but to the devcontainer.

1. Open the "Extensions" pane
2. Search for "Copilot" and select the GitHub Copilot extension (don't click Install!)
3. Rather than clicking install, click the cog icon and select "Add to devcontainer.json".
4. Go back to the `devcontainer.json` file and see the change. Note that the extension hasn't been installed at this point!
5. Reload your Codespace and see the changes.
6. Using your keyboard, press Ctrl/Cmd-Shift-P, then type "rebuild" to find it.
7. Click the "Codespaces: Rebuild Container" option.
8. Confirm your choice by clicking "Rebuild" and wait for it to reload.
9. Once reloaded, you'll be able to see GitHub Copilot installed - both in the Extensions pane, as well as via the Copilot logo bottom right!
(Note: This may take a little while. While it's running, your instructor will explain why - we were using Prebuilds before!)

#### 5. More more detail to the form using GitHub Copilot

Let's add some more details to our lost pets form. For example, where the pet was last seen. Let's take a look at the Lost Pet page.

1.  Go to LostPet.razor (you can get there quickly with `Ctrl/Cmd-P`, then typing the filename)
2.  Ensure Copilot is turned on using the icon at the right of the status bar - explain you can turn it on or off here
NOTE: Copilot is non-deterministic, it syntheses code just for you. So you will probably see something different on your screen thn the person next to you.
3.  Go to line 50 and add a new line after the `</div>` but before `@if (isLoading)`
4.  Type `<!-- Step 2.5 - pet's last location h2 element followed by a dropdown -->` - this is an HTML comment explaining what we want
5.  Press Enter to go to the next line
6.  GitHub Copilot should make a suggestion with an `h2` heading. Hit Tab to accept the suggestion.
7.  On the next line, write `<!-- Dropdown menu with location -->` and hit Enter.
8.  GitHub Copilot should suggest an HTML dropdown with several locations, but they're probably not the right ones for us, so let's provide more context.
9.  Update the comment to `<!-- Dropdown menu with 5 locations in [your city] -->` - replace [your city] with the name of your city and hit Enter again
10.  GitHub Copilot should make some more accurate suggestions. Hit Tab to accept.
11.  Make further changes to ensure `div` elements are closed, and modify as needed - Copilot is likely to help here as well.

#### 6. Add to the PetModel

Now you might notice that there's no Location field in PetModel (the red squiggles), so let's fix that

1. Use `Ctrl/Cmd-P` to search for `PetModel.cs` and go to that file
2. Add a new line after line 13 (`public List<string> Images { get; set; }`)
3. Add `public string Location { get; set; }`. Copilot may start helping you at some point, but if not, don't worry!
4. Add a new line after line 25 (`Images = new();`). Copilot will almost certainly fill in what we need (`Location = "";`), so hit Tab to accept.

#### 7. Debugging using GitHub Copilot

Let's start will some debugging. In this section, you should be able to see the changes.

1. Save the files you've edited. You can do this by pressing CTRL+S on the keyboard
2. Use "Run and Debug" to debug the application again. You can find this by (DAMO ADD THIS STEP IN HERE)
3. You should now see the new field.

#### OPTIONAL (time dependent) Back end changes

If there's time during the workshop, or you're ahead of the class, try out this optional step. Up until this point, we've only been using GitHub Copilot to make front-end changes. See if you can use GitHub Copilot to help you make backend changes as well!

Hint: look or where to add details about the location to `petspotr.py` and `app.py`

#### 8. Use GitHub Copilot to write tests

1. In the `src/tests/playwright/tests` folder, create a new file called `lostpage.spec.ts`
2. In that file, write a comment saying `// create playwright tests for LostPet.razor`
(Note that you should leave the LostPet.razor file open in VSCode so Copilot can see this context!)
3. On the next line, write a comment that says `// import dependencies` and hit Enter
4. GitHub Copilot should suggest something like `import { test, expect } from @playwright/test`. If this doesn't work, try opening another test file for context - this is a good opportunity for your instructor to explain a little about how GitHub Copilot gets its context)
5. Write a comment saying `// test that h2 element with the words "Step 1: Tell us about your pet and how to contact you" renders` and hit Enter
6. GitHub Copilot should do a good job of giving you the test function, although it may give it to you line by line. Hit Tab to accept until you're happy.
7. Write a comment that says `// test that dropdown menu renders` and hit Enter
8. GitHub Copilot again should do a good job - in my case it even suggests looking for `Dog` in the dropdown!
9. Finally, try adding a comment saying, `// test that you can upload images when you click Choose Files button`
(Note that last one is more temperamental and might need extra prompting. Lead people to something similar to the screenshot)

Congrats 🥳 now you've completed the workshop. You've learn how to use Codespaces and GitHub Copilot!
