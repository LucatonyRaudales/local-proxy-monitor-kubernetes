resource "kubernetes_pod" "nginx_lb_pod" {
  metadata {
    name = "nginx-lb-pod"
  }

  spec {
    container {
      image = "nginx:latest"
      name  = "nginx-lb-container"
      port {
        container_port = 80
      }
    }
  }
}