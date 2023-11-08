@description('The kube config for the target Kubernetes cluster.')
@secure()
param kubeConfig string

@description('DNS name of the HTTP Application Routing AddOn')
param HTTPApplicationRoutingZoneName string

provider 'kubernetes@1.0.0' with {
  kubeConfig: kubeConfig
  namespace: 'default'
}

resource ingress 'networking.k8s.io/Ingress@v1' = {
  metadata: {
    name: 'frontend'
    annotations: {
      'kubernetes.io/ingress.class': 'addon-http-application-routing'
    }
  }
  spec: {
    rules: [
      {
        host: 'app.${HTTPApplicationRoutingZoneName}'
        http: {
          paths: [
            {
              path: '/'
              pathType: 'Prefix'
              backend: {
                service: {
                  name: 'frontend'
                  port: {
                    number: 80
                  }
                }
              }
            }
          ]
        }
      }
    ]
  }
}
