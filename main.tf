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
    #url = "https://10.88.168.175:6443"
    #url = "http://myweb.com:8080"
    url = local.kube_config.clusters[0].cluster.server
  }
}

resource "null_resource" "vm_node_init" {
  provisioner "file" {
    source = "scripts/"
    destination = "/tmp"
    connection {
      type = "ssh"
      host = data.external.host.result["host"] 
      user = "iksadmin"
      private_key = var.privatekey
      port = "22"
      agent = false
    }
  }
}

variable "org" {
  type = string
}
variable "ikswsname" {
  type = string
}

variable "privatekey" {
  type = string
}
locals {
  kube_config = yamldecode(data.terraform_remote_state.iksws.outputs.kube_config)
}

output "host" {
  value = data.external.host.result["host"]
}


