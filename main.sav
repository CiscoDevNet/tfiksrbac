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


data "external" "host" {
  program = ["bash", "./scripts/gethost.sh"]
  query = {
    url = local.kube_config.clusters[0].cluster.server
  }
}



output "host" {
  value = data.external.host.result["host"]
}

#provider "kubernetes" {
#    host = local.kube_config.clusters[0].cluster.server
#    client_certificate = base64decode(local.kube_config.users[0].user.client-certificate-data)
#    client_key = base64decode(local.kube_config.users[0].user.client-key-data)
#    cluster_ca_certificate = base64decode(local.kube_config.clusters[0].cluster.certificate-authority-data)
#}

variable "org" {
  type = string
}
variable "ikswsname" {
  type = string
}
variable "privatekey" {
  type = string
}

#resource "kubernetes_namespace" "appd" {
#  metadata {
#    name = "appdynamics"
#  }
#}

resource "null_resource" "vm_node_init" {

  provisioner "file" {
    source = "scripts/"
    destination = "/tmp"
    connection {
      type = "ssh"
      host = data.external.host.result["host"]
      user = "iksadmin"
      private_key = "${file(var.privatekey)}"
      agent = false
    }
  }
}

locals {
  kube_config = yamldecode(data.terraform_remote_state.iksws.outputs.kube_config)
  kube_config_str = data.terraform_remote_state.iksws.outputs.kube_config
}

