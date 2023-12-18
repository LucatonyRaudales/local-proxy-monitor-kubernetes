module "nginx-controller" {
  source  = "terraform-iaac/nginx-controller/helm"
  version = "2.3.0"
}

resource "kubernetes_ingress_v1" "example_ingress" {
  metadata {
    name = "my-ingress"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
      "nginx.ingress.kubernetes.io/auth-type" = "basic"
      "nginx.ingress.kubernetes.io/auth-secret" = kubernetes_secret.auth.metadata[0].name
      "nginx.ingress.kubernetes.io/auth-realm" = "Authentication Required"
    }
  }
  spec {
    rule {
        host = "web-app.kubernetes.local"
      http {
        path {
          backend {
            service {
              name = "web-app"
              port {
                number = 80
              }
            }
          }
          path = "/"
        }
      }
    }
  }
}