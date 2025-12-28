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

data "twc_software" "softs" {
  name = "Docker"
}

resource "twc_server" "server" {
  name         = "server"
  os_id        = data.twc_os.os.id
  ssh_keys_ids = [twc_ssh_key.diploma_key.id]
  project_id   = data.twc_projects.diplom.id
  software_id  = data.twc_software.softs.id

  configuration {
    configurator_id = data.twc_configurator.premium_ru1.id
    disk = 20480
    cpu  = 4
    ram  = 8192
  }

  cloud_init = file("scripts/cloud-init.sh")

}

resource "twc_server_ip" "master_ipv4" {
  source_server_id = twc_server.server.id
  type             = "ipv4"
}

