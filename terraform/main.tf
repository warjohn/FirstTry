# main.tf
data "twc_configurator" "premium_ru1" {
  location      = "ru-1"
  preset_type   = "premium"
}

resource "twc_ssh_key" "diploma_key" {
  name = "diploma-key"
  body = file(var.ssh_public_key_path)
}


data "twc_os" "os" {
  name = "ubuntu"
  version = "22.04"
}

data "twc_projects" "diplom" {
  name = "diplom"
}

resource "twc_server" "diplom" {
  name         = "diplom"
  os_id = data.twc_os.os.id

  ssh_keys_ids = [twc_ssh_key.diploma_key.id]

  project_id = data.twc_projects.diplom.id

  configuration {
    configurator_id = data.twc_configurator.premium_ru1.id
    disk = 20480   
    cpu  = 2
    ram  = 2048     
  }
  cloud_init = file("../scripts/server/dependencies.sh")
}

resource "twc_server_ip" "diplom" {
  source_server_id = twc_server.diplom.id

  type="ipv4"
  ptr = "diplom.com"

}
output "server_public_ip" {
  value = twc_server_ip.diplom.ip
}

output "server_public_ipv6" {
  value = twc_server.diplom.networks[0].ips[0].ip
}