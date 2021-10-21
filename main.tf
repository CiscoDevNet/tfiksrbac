
data "external" "host" {
  program = ["bash", "./scripts/gethost.sh"]
  query = {
    url = "https://10.88.168.175:6443"
    #url = "http://myweb.com:8080"
  }
}



output "host" {
  value = data.external.host.result["host"]
}


