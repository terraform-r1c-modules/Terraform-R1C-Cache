################################################################################
# Basic Example - ArvanCloud CDN Cache Module
################################################################################

terraform {
  required_version = ">= 1.5"

  required_providers {
    arvancloud = {
      source  = "terraform.arvancloud.ir/arvancloud/arvancloud"
      version = ">= 0.2.2"
    }
  }
}

provider "arvancloud" {
  api_key = var.arvancloud_api_key
}

module "cdn_cache" {
  source = "../../"

  domain = var.domain
}
