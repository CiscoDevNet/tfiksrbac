
#Helm install of sample app on IKS
data "terraform_remote_state" "iksws" {
  backend = "remote"
  config = {
    organization = var.org
    workspaces = {
      name = var.ikswsname
    }
  }
}

provider "kubernetes" {
    host = local.kube_config.clusters[0].cluster.server
    client_certificate = base64decode(local.kube_config.users[0].user.client-certificate-data)
    client_key = base64decode(local.kube_config.users[0].user.client-key-data)
    cluster_ca_certificate = base64decode(local.kube_config.clusters[0].cluster.certificate-authority-data)
}

variable "org" {
  type = string
}
variable "ikswsname" {
  type = string
}

resource "kubernetes_namespace" "appd" {
  metadata {
    name = "appdynamics"
  }
}

resource "kubernetes_config_map" "example" {
  metadata {
    name = "my-config"
    namespace = kubernetes_namespace.appd.metadata.name
  }

  data = {
    "devnet-controller-setup.zip" = "${file("${path.module}/scripts/devnet-controller-setup.zip")}"
    "workshop-setup.yaml" = "${file("${path.module}/scripts/workshop-setup.yaml")}"
    "rbac.sh" = "${file("${path.module}/scripts/rbac.sh")}"
  }

}


locals {
  kube_config = yamldecode(data.terraform_remote_state.iksws.outputs.kube_config)
  kube_config_str = data.terraform_remote_state.iksws.outputs.kube_config
}

