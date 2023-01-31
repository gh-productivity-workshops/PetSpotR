@description('The kube config for the target Kubernetes cluster.')
@secure()
param kubeConfig string

@description('Address of the container registry where container resides')
param containerRegistry string

@description('Tag of container to use')
param containerTag string = 'latest'

@description('Azure Service Bus namespace connection string')
@secure()
param serviceBusNamespaceConnectionString string

import 'kubernetes@1.0.0' with {
  kubeConfig: kubeConfig
  namespace: 'default'
}

resource backendDeployment 'apps/Deployment@v1' = {
  metadata: {
    name: 'backend'
    labels: {
      app: 'backend'
    }
  }
  spec: {
    replicas: 1
    selector: {
      matchLabels: {
        app: 'backend'
      }
    }
    template: {
      metadata: {
        labels: {
          app: 'backend'
        }
        annotations: {
          'dapr.io/enabled': 'true'
          'dapr.io/app-id': 'backend'
          'dapr.io/app-port': '5000'
        }
      }
      spec: {
        containers: [
          {
            name: 'backend'
            image: '${containerRegistry}/backend:${containerTag}'
            imagePullPolicy: 'Always'
            env: [
              {
                name: 'SERVICEBUS_CONNECTIONSTRING'
                valueFrom: {
                  secretKeyRef: {
                    name: serviceBusSecret.metadata.name
                    key: 'connectionString'
                  }
                }
              }
            ]
          }
        ]
      }
    }
  }
}

resource serviceBusSecret 'core/Secret@v1' = {
  metadata: {
    name: 'servicebus'
  }
  stringData: {
    connectionString: serviceBusNamespaceConnectionString
  }
}