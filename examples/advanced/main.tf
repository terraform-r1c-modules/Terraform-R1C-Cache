################################################################################
# Advanced Example - ArvanCloud CDN Cache Module
#
# This example demonstrates:
# - Multiple domain configurations
# - Environment-based settings
# - Dynamic cache size calculation
# - Conditional developer mode
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

locals {
  environments = {
    production = {
      domain            = "prod.example.com"
      developer_mode    = false
      consistent_uptime = true
      max_size_mb       = 500
    }
    staging = {
      domain            = "staging.example.com"
      developer_mode    = false
      consistent_uptime = true
      max_size_mb       = 100
    }
    development = {
      domain            = "dev.example.com"
      developer_mode    = true
      consistent_uptime = false
      max_size_mb       = 50
    }
  }

  # Convert MB to bytes
  mb_to_bytes = 1048576
}

################################################################################
# CDN Cache Modules - One per environment
################################################################################

module "cdn_cache" {
  source   = "../../"
  for_each = local.environments

  domain            = each.value.domain
  developer_mode    = each.value.developer_mode
  consistent_uptime = each.value.consistent_uptime
  max_size          = each.value.max_size_mb * local.mb_to_bytes
}

################################################################################
# Single Domain with Variables
################################################################################

module "cdn_cache_single" {
  source = "../../"

  domain            = var.domain
  developer_mode    = var.environment == "development"
  consistent_uptime = var.environment != "development"
  max_size          = var.cache_size_mb * local.mb_to_bytes
}
