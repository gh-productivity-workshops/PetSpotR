@description('The kube config for the target Kubernetes cluster.')
@secure()
param kubeConfig string

@description('Address of the container registry where container resides')
param containerRegistry string

@description('Tag of container to use')
param containerTag string = 'latest'

import 'kubernetes@1.0.0' with {
  kubeConfig: kubeConfig
  namespace: 'default'
}

resource frontendDeployment 'apps/Deployment@v1' = {
  metadata: {
    name: 'frontend'
    labels: {
      app: 'frontend'
    }
  }
  spec: {
    replicas: 1
    selector: {
      matchLabels: {
        app: 'frontend'
      }
    }
    template: {
      metadata: {
        labels: {
          app: 'frontend'
        }
        annotations: {
          'dapr.io/enabled': 'true'
          'dapr.io/app-id': 'frontend'
          'dapr.io/app-port': '80'
        }
      }
      spec: {
        containers: [
          {
            name: 'frontend'
            image: '${containerRegistry}/frontend:${containerTag}'
            imagePullPolicy: 'Always'
          }
        ]
      }
    }
  }
}

resource frontendService 'core/Service@v1' = {
  metadata: {
    name: 'frontend'
    labels: {
      app: 'frontend'
    }
  }
  spec: {
    selector: {
      app: 'frontend'
    }
    ports: [
      {
        port: 80
        targetPort: '80'
        protocol: 'TCP'
      }
    ]
    type: 'LoadBalancer'
  }
}
