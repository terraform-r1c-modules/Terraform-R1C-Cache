# Basic Example

This example demonstrates the minimal usage of the ArvanCloud CDN Cache module with default settings.

## Usage

```bash
# Initialize Terraform
terraform init

# Import the existing cache configuration (required)
terraform import 'module.cdn_cache.arvancloud_cdn_domain_cache.this' 'example.ir'

# Plan and apply
terraform plan
terraform apply
```

## Default Values

When using just the domain, the following defaults are applied:

| Setting           | Default Value     |
| ----------------- | ----------------- |
| developer_mode    | false             |
| consistent_uptime | true              |
| max_size          | 104857600 (100MB) |
