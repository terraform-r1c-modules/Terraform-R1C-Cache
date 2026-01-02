# Terraform ArvanCloud CDN Cache Module

![Terraform](https://img.shields.io/badge/Terraform-%3E%3D1.5-623CE4?logo=terraform)
![Version](https://img.shields.io/github/v/release/terraform-r1c-modules/terraform-r1c-cdn-cache?logo=github&color=red&label=Version)
![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)

Terraform module to manage ArvanCloud CDN Cache resource.

## Requirements

| Name                                                                             | Version  |
| -------------------------------------------------------------------------------- | -------- |
| [terraform](https://developer.hashicorp.com/terraform)                           | >= 1.5   |
| [arvancloud](https://git.arvancloud.ir/arvancloud/terraform-provider-arvancloud) | >= 0.2.2 |

## Important Notes

> [!WARNING]
> **Import Required**: This resource cannot be created from scratch. The caching settings already exist for your domain. You must **import** the existing resource before applying changes.
>
> **No Deletion**: Due to API limitations, destroying this resource will remove it from Terraform state but will not delete the actual caching settings.

## Usage

### Basic Usage

```hcl
module "cache" {
  source = "git@github.com:terraform-r1c-modules/Terraform-R1C-CDN-Cache.git?ref=main"

  domain            = "example.ir"
  developer_mode    = false
  consistent_uptime = true
  max_size          = 104857600  # 100MB
}
```

### Import Existing Resource

Before using this module, you must import the existing caching configuration:

```bash
# Import using the module path
terraform import 'module.cache.arvancloud_cdn_domain_caching.this' 'example.ir'

# Or import using UUID
terraform import 'module.cache.arvancloud_cdn_domain_caching.this' '<domain-uuid>'
```

### Production Configuration

```hcl
module "cdn_cache" {
  source = "git@github.com:terraform-r1c-modules/Terraform-R1C-CDN-Cache.git?ref=main"

  domain            = "production.example.ir"
  developer_mode    = false     # Keep disabled in production
  consistent_uptime = true      # Serve stale content if origin is down
  max_size          = 524288000 # 500MB - adjust based on your content
}
```

### Development Configuration

```hcl
module "cdn_cache" {
  source = "git@github.com:terraform-r1c-modules/Terraform-R1C-CDN-Cache.git?ref=main"

  domain            = "dev.example.ir"
  developer_mode    = true      # Bypass cache for testing
  consistent_uptime = false
  max_size          = 10485760  # 10MB
}
```

## Inputs

| Name                | Description                                                 | Type     | Default     | Required |
| ------------------- | ----------------------------------------------------------- | -------- | ----------- | :------: |
| `domain`            | UUID or the name of the CDN domain                          | `string` | n/a         |   Yes    |
| `developer_mode`    | Enable or disable developer mode (bypasses caching)         | `bool`   | `false`     |    No    |
| `consistent_uptime` | Enable consistent uptime mode for improved availability     | `bool`   | `true`      |    No    |
| `max_size`          | Maximum size of cacheable content in bytes (0 - 2147483648) | `number` | `104857600` |    No    |

## Outputs

| Name                | Description                                                        |
| ------------------- | ------------------------------------------------------------------ |
| `domain`            | The domain name or UUID for which caching settings are configured  |
| `developer_mode`    | Whether developer mode is enabled for the domain                   |
| `consistent_uptime` | Whether consistent uptime mode is enabled for the domain           |
| `max_size`          | Maximum size of cacheable content in bytes                         |
| `last_updated`      | The timestamp of the last update to the caching settings (RFC3339) |

## Cache Size Reference

| Size   | Bytes      |
| ------ | ---------- |
| 10 MB  | 10485760   |
| 50 MB  | 52428800   |
| 100 MB | 104857600  |
| 250 MB | 262144000  |
| 500 MB | 524288000  |
| 1 GB   | 1073741824 |
| 2 GB   | 2147483648 |

## Examples

```hcl
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
  source = "git@github.com:terraform-r1c-modules/Terraform-R1C-CDN-Cache.git?ref=main"

  domain            = "example.ir"
  developer_mode    = false
  consistent_uptime = true
  max_size          = 104857600
}

output "cdn_cache_last_updated" {
  value = module.cdn_cache.last_updated
}
```

## License

Apache 2.0 Licensed. See [LICENSE](LICENSE) for full details.
