# PetSpotR

## 🛠️ 如果您需要参加 Workshop，请跳转到 [workshop](workshop/README_CN.md) 文件夹开始！ 🛠️

---

PetSpotR 允许您使用高级人工智能模型来报告和寻找丢失的宠物。 它是一个示例应用程序，使用 Azure 机器学习来训练模型来检测图像中的宠物。

它还利用流行的开源项目（例如 Dapr 和 Keda）来提供可扩展且有弹性的云原生架构。

![Logo](./img/logo.svg)

## 涉及的相关技术

- [Bicep](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview) - Infrastructure as code
- [Bicep extensibility Kubernetes provider](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/bicep-extensibility-kubernetes-provider) - Model Kubernetes resources in Bicep
- [Azure Kubernetes Service](https://docs.microsoft.com/en-us/azure/aks/intro-kubernetes)
- [Azure Blob Storage](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blobs-introduction)
- [Azure Cosmos DB](https://docs.microsoft.com/en-us/azure/cosmos-db/introduction)
- [Azure Service Bus](https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-messaging-overview)
- [Azure Machine Learning](https://learn.microsoft.com/en-us/azure/machine-learning/overview-what-is-azure-machine-learning)
- [Hugging Face](https://huggingface.co) - AI model community
- [Azure Load Testing](https://docs.microsoft.com/en-us/azure/load-testing/) - Application load testing
- [Blazor](https://dotnet.microsoft.com/apps/aspnet/web-apps/blazor) - Frontend web application
- [Python Flask](https://pypi.org/project/Flask/) - Backend server
- [Dapr](https://dapr.io) - Microservice building blocks
- [KEDA](https://keda.sh) - Kubernetes event-driven autoscaling

## 架构

> **注意**：此应用程序是一个演示应用程序，不打算在生产中使用。 它旨在演示如何使用 Azure 机器学习和其他 Azure 服务来构建可扩展且有弹性的应用程序。 使用风险自负。

### 本地架构

![local architecture](./img/petspotr-local.png)

### 云端架构

从本地迁移到云端就像将本地 Dapr 组件替换为云端组件一样简单：

![cloud architecture](./img/petspotr-cloud.png)

### 微服务

PetSpotR 是一个微服务应用程序，它使用 [Azure 机器学习](https://learn.microsoft.com/en-us/azure/machine-learning/overview-what-is-azure-machine-learning) 来训练模型以 检测图像中的宠物。 它还使用 Azure Blob 存储来存储图像，使用 Azure Cosmos DB 来存储元数据，利用 [Dapr](https://dapr.io) 绑定和状态管理来抽象底层基础设施。

前端是一个 [.NET Blazor 应用程序](https://learn.microsoft.com/en-us/aspnet/core/blazor/?view=aspnetcore-7.0)，允许用户上传图像并查看结果。 后端是一个 [Python Flask 应用程序](https://pypi.org/project/Flask/)，它使用 Azure 机器学习来训练和评分模型。

### AI模型训练

该应用程序使用 [Azure 机器学习](https://learn.microsoft.com/en-us/azure/machine-learning/overview-what-is-azure-machine-learning) 训练模型来检测图像中的宠物 . 该模型来自 [Hugging Face](https://huggingface.co)，这是一个由 AI 研究人员和开发人员组成的社区。 该模型使用 [Azure 机器学习计算实例](https://docs.microsoft.com/en-us/azure/machine-learning/concept-compute-instance) 进行训练，这是一个面向数据科学家的托管计算环境 和人工智能开发者。

### 状态管理

该应用程序使用 [Dapr](https://dapr.io) 状态管理 API 来抽象底层基础设施。 当应用程序在本地运行时，状态存储在一个轻量级的 Redis 容器中。 当应用程序在云中运行时，状态存储在 Azure Cosmos DB 中。

### 发布和订阅消息

该应用程序使用 [Dapr](https://dapr.io) pub/sub API 来抽象底层基础设施。 当应用程序在本地运行时，消息通过轻量级 Redis 容器发送。 当应用程序在云端运行时，消息通过 Azure 服务总线发送。

### 绑定

该应用程序使用 [Dapr](https://dapr.io) 绑定 API 来抽象底层基础设施。 当应用程序在本地运行时，图像存储在本地文件系统中。 当应用程序在云中运行时，绑定存储在 Azure Blob 存储中。

###缩放

该应用程序使用 [KEDA](https://keda.sh) 进行扩展，它允许您根据队列中的消息数量进行扩展。 该应用程序使用 Azure 服务总线将消息排队供后端处理，利用 [Dapr](https://dapr.io) pub/sub 抽象出底层基础设施。

### 负载测试

[Azure Load Testing](https://learn.microsoft.com/en-us/azure/load-testing/overview-what-is-azure-load-testing)用于模拟大量用户上传图片到 应用程序，它允许我们测试应用程序的可扩展性。

## 运行 PetSpotR

### 环境配置

- [Azure subscription](https://azure.microsoft.com/free/)
- **注意**：此应用程序将创建 <font color=red>** 会产生费用** </font> 的 Azure 资源。 您还需要为 Azure ML 工作区手动请求“标准 NCSv3 系列集群专用 vCPU”的配额，因为默认配额为 0。
- [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli)
- [Dapr CLI](https://docs.dapr.io/getting-started/install-dapr-cli/)
- [Helm](https://helm.sh/docs/intro/install/)
- [Docker](https://docs.docker.com/get-docker/)
- [Python 3.8](https://www.python.org/downloads/)
- [Dotnet SDK](https://dotnet.microsoft.com/download/dotnet/)
- [Bicep extensibility](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/bicep-extensibility-kubernetes-provider#enable-the-preview-feature)

### 在 Codespace 中运行

您可以在 [GitHub Codespace](https://docs.github.com/en/codespaces/developing-in-codespaces/creating-a-codespace) 中运行此应用程序。 这对于开发和测试很有用。 机器学习训练和评分将在 Azure 订阅的 Azure 机器学习工作区内运行。

1. 点击`Code`按钮并选择`Open with Codespaces`
1.等待创建Codespace
1. 按“F5”或打开“运行和调试”选项卡并选择“✅ 使用 Dapr 调试”

### 本地运行

此应用程序中的服务可以使用 Dapr CLI 在本地运行。 这对于开发和测试很有用。 ML 训练和评分将在 Azure 订阅的 Azure 机器学习工作区内运行。

1. 安装 [Dapr CLI](https://docs.dapr.io/getting-started/install-dapr-cli/)
2. 初始化 Dapr
   ```bash
   dapr init
   ```
3. 为 Windows 或 Mac 配置你的 Dapr 镜像组件
   1. 打开 ./iac/dapr/local/images.yaml
   2. 取消注释适用于您的操作系统的部分，并注释掉其他部分
   
4. 部署 Azure 上所需要的资源
   ```bash
   az deployment group create --resource-group myrg --template-file ./iac/infra.bicep --parameters mode=dev
   ```
5. 后端运行
   ```bash
   cd src/backend
   dapr run --app-id backend --app-port 6002 --components-path ../../iac/dapr/local -- python app.py
   ```
6. 前端运行
   ```bash
   cd src/frontend/PetSpotR
   dapr run --app-id frontend --app-port 5114 --components-path ../../../iac/dapr/local -- dotnet watch
   ```
7. 跳转到 http://localhost:5114

### 通过命令行部署应用到 Azure

1. 确保您有权访问 Azure 订阅并安装了 Azure CLI
    ```bash
    az login
    az account set --subscription “我的订阅”
    ```
2. 克隆这个存储库
    ```bash
    git clone https://github.com/azure-samples/petspotr.git
    cd petspotr
    ```
3. 部署基础设施
    ```bash
    az deployment group deployment create --resource-group myrg --template-file ./iac/infra.json
    ```
4. 部署配置
    ```bash
    az deployment group deployment create --resource-group myrg --template-file ./iac/config.json
    ```
5. 获取AKS凭证
    ```bash
    az aks get-credentials --resource-group myrg --name petspotr
    ```
6. 安装 Helm Charts
   ```bash
   helm repo add dapr https://dapr.github.io/helm-charts/
   helm repo add kedacore https://kedacore.github.io/charts
   helm repo update
   helm upgrade dapr dapr/dapr --install --version=1.10 --namespace dapr-system --create-namespace --wait
   helm upgrade keda kedacore/keda --install --version=2.9.4 --namespace keda --create-namespace --wait
   ```

7. 登录到 Azure 容器注册表
    您可以从 Azure 门户中的资源组获取注册表名称
   ```bash
   az acr login --name myacr
   ```

8. 构建并推送容器
    ```bash
    docker build -t myacr.azurecr.io/backend:latest ./src/backend
    docker build -t myacr.azurecr.io/frontend:latest ./src/frontend
    docker push myacr.azurecr.io/petspotr:latest
    docker push myacr.azurecr.io/frontend:latest
    ```

9. 部署应用
    ```bash
    az deployment group deployment create --resource-group myrg --template-file ./iac/app.json
    ```
10. 获取您的前端网址
    ```狂欢
    kubectl 获取 svc
    ```
11. 导航到您的前端网址


此应用程序中的服务可以使用 Dapr CLI 在本地运行。 这对于开发和测试很有用。 机器学习训练和评分将在 Azure 订阅的 Azure 机器学习工作区内运行。
