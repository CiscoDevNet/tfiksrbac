
data "external" "host" {
  program = ["bash", "./scripts/gethost.sh"]
  query = {
    url = "http://myweb.com:8080"
  }
}



output "host" {
  value = data.external.host.result["host"]
}


