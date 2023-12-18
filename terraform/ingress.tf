resource "kubernetes_ingress_v1" "example_ingress" {
  metadata {
    name = "my-ingress"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
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