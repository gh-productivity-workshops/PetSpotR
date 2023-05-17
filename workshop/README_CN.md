# 通过 GitHub Copilot 和 Codespaces 提升您的生产力

👋 热烈欢迎你的参与!

在本次 workshop 中 ,您将会学习到围绕 GitHub Codespaces 和 GitHub Copilot 的相关技能

## 👩‍💻 GitHub Codespaces

云计算在过去十多年里呈爆发式增长。 云计算不仅可以用于运行生产工作负载, 也还可以托管您的开发环境！

[GitHub Codespaces](https://github.com/features/codespaces) 让您几乎可以在任何地方进行编码，为您提供由高性能 虚拟机支持的 Visual Studio Code，这些虚拟机可在几秒钟内启动，并且可以自定义相关的开发环境和插件，从而无缝对接您的代码。

与本地开发相比，使用 Codespaces 的优势有很多。 您可以对项目里的一组依赖项进行标准化，对于新入职的人员可以在几秒钟内启动完整的开发环境并投入工作。

🤯 _有趣的事实：GitHub 团队就在使用 Codespaces 来开发和维护 GitHub 的功能！ 新工程师可以在大约 10 秒内准备好所有的环境设定投入工作。 这是在 11GB 的 GitHub 代码库上！_

  在本次 workshop 中，您将学习到：

- 了解什么是 Codespace 及其优势
- 创建一个新的 Codespace 
- 在 Codespace 中运行和调试多进程应用程序
- 了解开发容器
- 为您的 Codespace 进行配置更改


## 🤖 GitHub Copilot

2023 年，人工智能 (AI) 工具呈爆炸式增长，成为主流，有望提高生产力并消除繁重的工作。 [GitHub Copilot](https://github.com/features/copilot) 是您的人工智能辅助程序员，也是首批基于大型语言模型 (LLM) 的商用工具之一。 它于 2021 年 6 月首次作为技术预览版发布，在一年后的 2022 年 6 月面向个人正式发布。

GitHub Copilot 可以作为代码建议和全功能辅助您更快地编写代码，让您更专注于业务逻辑而不是刻板的文件，成为一名更快乐、更高效的开发人员！

在本次 workshop 中，您将学习到：

- 在您的 Codespace 中使用 GitHub Copilot
- 在 GitHub Copilot 的帮助下添加涉及应用程序各部分的新功能
- 使用 GitHub Copilot 编写测试用例
- 学习如果通过有效上下文的关联从 GitHub Copilot 获得最佳结果

# 👟 一起来学习吧!

通过上面的介绍，您已经知道将在本次 workshop 中学到什么，让我们一步步来完成这些内容。

我们将使用一款名为 PetSpotR 的人工智能宠物失物招领应用程序。 这个网络应用程序使用 C# 和 Python，并使用 Dapr、Kubernetes 和 Keda、Bicep、Azure 机器学习以及大量其他框架和技术。

😨 _如果您不了解这些技术，请不要担心。 这就是 Codespaces 和 GitHub Copilot 可以提供帮助的地方！_

## 1. 启动一个新的 Codespaces 

让我们首先创建一个新的 Codespace ，其中已经安装了所有依赖项和工具。

1. 通过浏览器进入 https://github.com/gh-productivity-workshops/PetSpotR。

2. 单击“<> Code”按钮，然后单击“Codespaces”选项卡。

3. 确保您可以看到底部的注释 - “此存储库的代码空间使用由 *gh-productivity-workshops* 付费。如果您看不到，请告知 Workshop 的导师或者现场工作人员！
![new codespace](images/1-new-codespace.png)

4. 单击此窗口顶部的省略号 (...)，然后选择“+ New with options...”

![new codespace options](images/2-new-codespace-options.png)

1. 单击*Machine type* 的下拉菜单并查看选项。 您会注意到只有一个可用。 这已由组织管理员设置为策略！
![machine type](images/3-new-codespace-machines.png)

1. 点击“Create codespace”按钮，观察您的 Codespace 构建过程

_您的讲师将在您等待 Codespace 启动时谈论设置策略。_

## 2. 在 Codespace 中运行和调试

1. 导航到运行和调试窗格 (![运行和调试](images/run-and-debug.png))

2. 确保顶部的下拉菜单设置为“✅ Debug with Dapr”配置，然后单击绿色播放按钮。
![运行和调试](images/4-run-and-debug.png)

_应用程序的后端和前端组件都和其他更多服务一起启动。 这可能需要一分钟或更长时间。 运行时，您可以使用下拉列表查看正在调试哪些进程。_

![调试](images/5-debugging.png)

3. 导航到编辑器底部的端口窗格，查看已打开的端口以暴露正在运行的组件。 大约会有 10 个。
![开放端口](images/6-ports.png)

_您可以更改这些端口的可见性 - 将它们向您组织中的其他人开放，甚至将它们公开。_

4. 将鼠标悬停在端口 5114 的本地地址上，然后单击“在浏览器中打开”图标 (![在浏览器中打开](images/open-in-browser.png)) 在浏览器中打开您的应用程序。

5. 返回资源管理器窗口 (![Explorer](images/explorer.png))，然后找到并打开 `src/backend/app.py`。

6. 在第 45 行设置断点（`print(f'Pet state retrieved', flush=True)`）

7. 在您的浏览器中运行的应用程序中，转到*I lost my pet*并填写表格。 您可以在您的机器上使用任何图像，我们实际上并不处理它们！

8. 在您的 Codespaces 浏览器选项卡中，注意已选中断点！ 您可以在浏览器的 VSCode 中检查 `data` 对象。
![代码空间中的断点](images/7-breakpoint.png)

8. 单击调试窗格中的停止按钮停止正在运行的调试器。 您需要执行两次(每个正在运行的进程一次。)
![调试](images/5-debugging.png)

## 3. 指定 Codespaces 需要什么

在资源管理器窗格中，打开 .devcontainer/devcontainer.json 文件并进行浏览。 重点关注以下内容：
   - `image` - 这是 Codespace 使用的 docker - 您还可以使用自己的 dockerfile，或拥有用于多阶段构建的 docker compose 文件。
   - `onCreateCommand` - 这让我们可以在创建 Codespace 时运行我们自己的脚本。 如果您需要等到一切准备就绪，还有 `postCreateCommand`。
   - `features` - 这是向 Codespace 添加更广泛功能的最简单方法。 在我们的例子中，我们添加了 python 和 docker-in-docker（这允许我们在代码空间内运行多个容器！）。 您可以在 https://containers.dev/features 上找到更多信息
   - `customizations.vscode.extensions` - 这些是您在启动 Codespace 时希望 VSCode 具有的扩展。

如果您更改 Codespace 中的 devcontainer，您每次都需要重新编译和查看更改（一分钟内完成）。 但是，如果您提交并推送到您的存储库，那么之后任何人创建的每个 Codespace 都可以使用这个 devcontainer 规范。

您还可以拥有多个 devcontainer 并选择将哪个用于您的 Codespace。 当我们一开始创建 Codespace 时，您可能已经看到了该选项。

## 4. 更改 devcontainer

现在您已经启动并运行 Codespace，让我们来准备使用 GitHub Copilot！

让我们添加 GitHub Copilot 插件,我们将它添加到 devcontainer 而不是仅仅安装它。

1. 打开“插件”(![Extensions](images/extensions.png)) 面板

2. 搜索“Copilot”并选择 GitHub Copilot 插件
![GitHub Copilot Extensions](images/8-copilot-extension.png)

3. 不要点击绿色的“Install in Codespaces”按钮！ 相反，单击齿轮图标 (⚙️) 并选择“添加到 devcontainer.json”。
![Add devcontainer Extensions](images/9-copilot-extension-devcontainer.png)

4. 返回 `devcontainer.json` 文件并查看更改。 请注意，此时您的 Codespace 中尚未安装该扩展程序。
![devcontainer Changes](images/10-copilot-devcontainer-change.png)

_要查看更改，我们需要重建代码空间。_

6. 使用键盘，按 `Ctrl/Cmd-Shift-P`，然后键入“rebuild”以找到“Codespaces: Rebuild Container”选项。 选择它并按回车键，或用鼠标单击它。
![重建你的代码空间](images/11-rebuild-codespace.png)

7. 单击“Rebuild”确认您的选择并等待您的 Codespace 重新加载。
![确认重建](images/12-rebuild-codespace-confirm.png)

  _这可能比您的第一次构建需要更长的时间！ 这是因为我们正在利用一个名为 Prebuilds 的功能。 您的讲师将向您展示如何设置它们并解释它们为何有用。_

8. 重新加载后，您将能够看到 GitHub Copilot 已安装 - 在“插件”窗格中以及通过状态栏右下角的位置有 GitHub Copilot 徽标！

![副驾驶标志](images/13-copilot-icon.png)

## 5. 使用 GitHub Copilot 添加丢失的宠物表单

让我们在丢失的宠物表格中添加更多详细信息。 我们还想追踪最后一次看到宠物的位置。 我们来看看丢失的宠物页面。

⚠️ _注意：GitHub Copilot 是不确定的！ 它专门为您合成代码，因此您可能会看到与您旁边的人不同的建议！ 稍后我们将讨论如何充分利用 Copilot。_

1. 在资源管理器窗格中，转到 `LostPet.razor` 文件（您可以使用 `Ctrl/Cmd-P` 快速到达那里，然后输入文件名）

2. 使用状态栏右侧的图标确保 GitHub Copilot 已打开。 您可以单击此图标以打开或关闭 GitHub Copilot。

![副驾驶标志](images/13-copilot-icon.png)

3. 转到第 50 行，在 `</div>` 之后但在 `@if (isLoading)` 之前添加一个新行

4. 输入以下 HTML 注释，解释我们接下来要做什么。 这是帮助 GitHub Copilot 帮助我们的一个很好的提示！

```<!-- Step 2.5 - pet's last location h2 element followed by a dropdown -->```

5. 按回车键转到下一行。

6. GitHub Copilot 提示应该用灰色的 `h2` 标题建议。 点击 `Tab` 接受建议。
![GitHub Copilot Ghost 文本](images/14-copilot-h2-suggestion.png)

🤔 _我们将这种建议机制称为“幽灵文本”。 您可以按 Tab 键接受建议，或者直接忽略它并继续输入。_

7. 在下一行中，写下以下注释并按 Enter。

```<!-- Dropdown menu with location -->```

8. GitHub Copilot 应该会建议一个包含多个位置的 HTML 下拉列表
![带城市的下拉菜单](images/15-copilot-dropdown-suggestion.png)

_在这种情况下，GitHub Copilot 很有帮助，但它们不是我们需要的城市，所以可以提供更多上下文。_

9. 返回并更新下面的评论，将 [your city] 替换为您所在城市的名称，然后再次按 Enter。

   ```<!-- Dropdown menu with 5 locations in [your city] -->```

10. GitHub Copilot 应该提出一些更准确的建议。 点击 Tab 接受。
![更新城市下拉列表](images/16-copilot-better-dropdown.png)

11. 进行进一步的更改以确保 HTML 有效并且所有 `div` 元素都已关闭。 您可能需要进行一些小的修改，GitHub Copilot 也可能在此处提供帮助。

## 6. 添加到 PetModel

您可能会注意到 `PetModel` 中没有 `Location` 字段（红色波浪线表示存在错误），所以让我们修复它。
![位置属性错误](images/17-location-error.png)

1. 使用 `Ctrl/Cmd-P` 搜索 `PetModel.cs` 并打开该文件。

2. 在第 13 行后添加新行 (`public List<string> Images { get; set; }`)

3. 添加`public string Location { get; 放; }`。 GitHub Copilot 可能会在某个时候开始帮助你，但如果没有，别担心，继续输入吧！

4. 在第 25 行之后添加一个新行 (`Images = new();`)。 GitHub Copilot 几乎肯定会填写我们需要的内容 (`Location = "";`)，所以点击 Tab 接受。
![Updated cities dropdown](images/18-copilot-petmodel-suggestion.png)

## 7. 让我们来看更多的变化

我们在 GitHub Copilot 的帮助下做了一些更改，让我们看看结果吧！

1. 确保您已保存已编辑的文件。 您可以通过按键盘上的 CTRL+S 来执行此操作。

2. 导航到“运行和调试”窗格 (![运行和调试](images/run-and-debug.png)) 并再次使用“✅ Debug with Dapr”配置进行调试。

3. 再次单击端口窗格中的“在浏览器中打开”图标 (![在浏览器中打开](images/open-in-browser.png)) 打开应用程序。

3. 转到“I lost my pet”页面，您应该会看到所做的更改。
![上次查看页面更新](images/19-last-seen-update.png)

## 可选（时间相关）后端更改

如果 workshop 期间有时间，或者您已于课堂上的提前完成了内容，请尝试这个可选步骤。

到目前为止，我们只对前端进行了更改，额外的数据不会保留在后端。 看看您是否也可以使用 GitHub Copilot 来帮助您进行后端更改！

_🔎 提示：在 `petspotr.py` 和 `app.py` 中寻找添加有关宠物最后已知位置的详细信息的位置_

## 8. 使用 GitHub Copilot 编写测试

最后，我们将使用 GitHub Copilot 来帮助我们围绕页面编写一些测试。 此应用程序已使用 Playwright 进行测试，因此让我们在此基础上进行构建。

1. 在 `src/tests/playwright/tests` 文件夹中，创建一个名为 `lostpage.spec.ts` 的新文件
![新测试文件](images/20-new-test-file.png)

2. 在该文件中，写下一条注释：

```// create playwright tests for LostPet.razo```

_ℹ️ 请注意，您应该在 VSCode 中打开 LostPet.razor 文件，以便提供更好的上下文！_

_GitHub Copilot 使用其他打开的文件来构建有用的信息来发送回服务器。 这种“快速制作”可以使您获得的结果大不相同。_

3. 在下一行中，写下以下注释并按 Enter

```//import dependencies```

4. GitHub Copilot 应该建议类似 `import { test, expect } from @playwright/test` 的东西。 如果这不起作用，请尝试打开另一个测试文件以获得更好的上下文。

5. 在下面写下评论，然后按 Enter。

```// test that h2 element with the words "Step 1: Tell us about your pet and how to contact you" renders```

_GitHub Copilot 应该会很好地为您提供测试功能，尽管它可能会逐行提供给您。 点击 Tab 键接受，直到您满意为止。_

7. 写下以下内容的评论，然后按 Enter

```// test that dropdown menu renders```

8. GitHub Copilot 再次做得很好——它甚至可能会建议在下拉列表中寻找“Dog”！

9. 最后，尝试在下面添加评论并按 Enter。

```// test that you can upload images when you click Choose Files button```

😖 _注意最后一个生成可能会不太准确，需要额外提示。 你应该得到类似于以下内容的结果。_
![副驾驶的新测试](images/21-copilot-test-suggestions.png)

#🥳恭喜！

  您出色地完成了！ 你已经完成了 workshop 。 您已了解如何使用 Codespaces 和 GitHub Copilot 来提高开发人员的工作效率。

通过本次学习，你掌握了：
1. 能够编辑和调试具有多个移动部分和一系列框架和技术的全新应用程序。 所有的工作都在几分钟内完成！
2. 了解如何自定义基于云的开发环境以最大限度地减少入职配置时间，让您可以在任何地方工作，和您所在的团队提供一致性的开发体验
3. 通过 GitHub Copilot 帮助您的应用程序创建新功能。
4. 通过 GitHub Copilot 帮助您编写测试 - 使用您以前不熟悉的框架！

当然，不可能在一个简短的 workshop 上了解这些功能的所有内容，但我们希望您已经学到了足够多的知识，可以看到这些技术的强大功能以及它如何提高您的工作效率和日常幸福感。

# 后续

这个 Repo 是公开的，即使您完成了 workshop ，也可以随时回来再做一次，或者与您的同事分享！

如果您不是 Codespaces 或 Copilot 的当前用户，您最多可以使用[每月 60 小时的免费 Codespaces 访问](https://github.com/features/codespaces#pricing)，和注册一个 [ 免费 GitHub Copilot 试用](https://github.com/github-copilot/signup)。