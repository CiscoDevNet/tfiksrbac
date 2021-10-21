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
data "terraform_remote_state" "host" {
  backend = "remote"
  config = {
    organization = var.org
    workspaces = {
      name = var.hostwsname
    }
  }
}

resource "null_resource" "vm_node_init" {
  provisioner "file" {
    source = "scripts/"
    destination = "/tmp"
    connection {
      type = "ssh"
      host = local.host 
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
variable "hostwsname" {
  type = string
}

variable "privatekey" {
  type = string
}
locals {
  kube_config = yamldecode(data.terraform_remote_state.iksws.outputs.kube_config)
  host = data.terraform_remote_state.host.outputs.host
}

output "host" {
  value = data.external.host.result["host"]
}


