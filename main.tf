data "external" "appd" {
  program = ["bash", "./scripts/getappd.sh"]
  query = {
    #nbrapm = "${var.nbrapm}"
    #nbrma = "${var.nbrma}"
    #nbrsim  = "${var.nbrsim}"
    #nbrnet = "${var.nbrnet}"
    nbrapm = 8
    nbrma = 1
    nbrsim  = 0
    nbrnet = 0
  }
}


variable "nbrapm" {
  type = string
}
variable "nbrma" {
  type = string
}
variable "nbrsim" {
  type = string
}
variable "nbrnet" {
  type = string
}

output "accesskey" {
  value = data.external.appd.result["accesskey"]
}



