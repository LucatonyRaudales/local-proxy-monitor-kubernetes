provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "netdata" {
  name       = "netdata"
  repository = "https://netdata.github.io/helmchart/"
  chart      = "netdata"
}