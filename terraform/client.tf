resource "kubernetes_pod" "cliente_pod" {
  metadata {
    name = "cliente-pod"
  }

  spec {
    container {
      name  = "cliente-container"
      image = "curlimages/curl:latest"
      command = ["sleep", "infinity"]
    }
  }
}