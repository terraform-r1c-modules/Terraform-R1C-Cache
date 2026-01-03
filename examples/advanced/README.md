# Advanced Example

This example demonstrates advanced usage patterns of the ArvanCloud CDN Cache module including:

- **Multi-environment configuration** using `for_each`
- **Dynamic settings** based on environment type
- **Megabyte-based cache size** with automatic conversion to bytes
- **Conditional logic** for developer mode
- **Rich outputs** with computed values

## Features Demonstrated

### 1. Multi-Environment Setup

Configure cache for multiple environments (production, staging, development) with different settings:

```hcl
module "cdn_cache" {
  source   = "../../"
  for_each = local.environments

  domain            = each.value.domain
  developer_mode    = each.value.developer_mode
  consistent_uptime = each.value.consistent_uptime
  max_size          = each.value.max_size_mb * local.mb_to_bytes
}
```

### 2. Environment-Based Configuration

Automatically set developer mode based on environment:

```hcl
developer_mode    = var.environment == "development"
consistent_uptime = var.environment != "development"
```

### 3. Human-Readable Cache Sizes

Specify cache size in megabytes instead of bytes:

```hcl
max_size = var.cache_size_mb * 1048576
```

## Usage

### Import All Environments

Before applying, import all existing cache configurations:

```bash
terraform init

# Import each environment
terraform import 'module.cdn_cache["production"].arvancloud_cdn_domain_cache.this' 'prod.example.ir'
terraform import 'module.cdn_cache["staging"].arvancloud_cdn_domain_cache.this' 'staging.example.ir'
terraform import 'module.cdn_cache["development"].arvancloud_cdn_domain_cache.this' 'dev.example.ir'
terraform import 'module.cdn_cache_single.arvancloud_cdn_domain_cache.this' 'api.example.ir'

# Apply configuration
terraform plan
terraform apply
```

### Custom Variables

```bash
terraform apply \
  -var="domain=custom.example.ir" \
  -var="environment=staging" \
  -var="cache_size_mb=250"
```

## Environment Settings

| Environment | Developer Mode | Consistent Uptime | Cache Size |
| ----------- | -------------- | ----------------- | ---------- |
| Production  | false          | true              | 500 MB     |
| Staging     | false          | true              | 100 MB     |
| Development | true           | false             | 50 MB      |
