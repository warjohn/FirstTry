# main.tf
data "twc_configurator" "premium_ru1" {
  location      = "ru-1"
  preset_type   = "premium"
}

data "twc_os" "ubuntu_22" {
  name    = "ubuntu"
  version = "22.04"
}

resource "twc_ssh_key" "diploma_key" {
  name = "diploma-key"
  body = file(var.ssh_public_key_path)
}

data "twc_software" "docker_on_ubuntu" {
  name = "Docker"

  os {
    name    = "ubuntu"
    version = "22.04"
  }
}

resource "twc_server" "diplom" {
  name         = "diplom"
  os_id        = data.twc_os.ubuntu_22.id
  software_id  = data.twc_software.docker_on_ubuntu.id
  
  ssh_keys_ids = [twc_ssh_key.diploma_key.id]

  configuration {
    configurator_id = data.twc_configurator.premium_ru1.id
    disk = 20480   
    cpu  = 2
    ram  = 2048     
  }

}

# output "server_ip" {
#   value = twc_server.diploma_vm.networks[0].ip
# }