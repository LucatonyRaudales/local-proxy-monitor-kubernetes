# main.tf
terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "2.12.1"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"  # Ajusta la ruta según tu configuración
}
/*
resource "kubernetes_manifest" "ip_address_pool" {
  manifest = {
    apiVersion = "metallb.io/v1beta1"
    kind       = "IPAddressPool"
    metadata   = {
      name      = "default"
      namespace = "metallb-system"
    }
    spec       = {
      protocol = "layer2"
      addresses = ["192.168.1.220-192.168.1.230"]
    }
  }
}
*/
resource "kubernetes_deployment" "example" {
  metadata {
    name = "hello-app"
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        role = "hello-app"
      }
    }
    template {
      metadata {
        labels = {
          role = "hello-app"
        }
      }

      spec {
        container {
          image = "gcr.io/google-samples/hello-app:1.0"
          name  = "hello-app"

          port {
            container_port = 8080
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 8080

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "example" {
  metadata {
    name = "hello-lb"
    annotations = {
      "metallb.universe.tf/address-pool" = "default"
    }
  }
  spec {
    selector = {
      role = "hello-app"
    }
    session_affinity = "ClientIP"
    port {
      port        = 8080
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}