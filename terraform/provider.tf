terraform {
  required_providers {
    twc = {
      source  = "tf.timeweb.cloud/timeweb-cloud/timeweb-cloud"
      version = "~> 1.0"
    }
  }
  required_version = ">= 1.4.4"
}

provider "twc" {
  token = var.timeweb_token
}