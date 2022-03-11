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
data "terraform_remote_state" "global" {
  backend = "remote"
  config = {
    organization = var.org
    workspaces = {
      name = var.globalwsname
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
      private_key = local.privatekey
      port = "22"
      agent = false
    }
  }

  provisioner "remote-exec" {
    inline = [
        "chmod +x /tmp/rbac.sh",
        "/tmp/rbac.sh ${local.nbrapm} ${local.nbrma} ${local.nbrsim} ${local.nbrnet}",
	"sudo docker login ${local.dockerrepo} -u ${local.dockeruser} -p ${local.dockerpass}",
    ]
    connection {
      type = "ssh"
      host = local.host
      user = "iksadmin"
      private_key = local.privatekey
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

variable "globalwsname" {
  type = string
}
locals {
  kube_config = yamldecode(data.terraform_remote_state.iksws.outputs.kube_config)
  host = data.terraform_remote_state.host.outputs.host
  nbrapm = data.terraform_remote_state.global.outputs.nbrapm
  nbrma = data.terraform_remote_state.global.outputs.nbrma
  nbrsim = data.terraform_remote_state.global.outputs.nbrsim
  nbrnet = data.terraform_remote_state.global.outputs.nbrnet
  #privatekey = data.terraform_remote_state.global.outputs.privatekey
  privatekey = base64decode(data.terraform_remote_state.global.outputs.privatekey)
  dockeruser = data.terraform_remote_state.global.outputs.dockeruser
  dockerpass = data.terraform_remote_state.global.outputs.dockerpass
  dockerrepo = data.terraform_remote_state.global.outputs.dockerrepo
}



