output "domain" {
  description = "The domain name or UUID for which caching settings are configured."
  value       = arvancloud_cdn_domain_caching.this.domain
}

output "developer_mode" {
  description = "Whether developer mode is enabled for the domain."
  value       = arvancloud_cdn_domain_caching.this.developer_mode
}

output "consistent_uptime" {
  description = "Whether consistent uptime mode is enabled for the domain."
  value       = arvancloud_cdn_domain_caching.this.consistent_uptime
}

output "max_size" {
  description = "Maximum size of cacheable content in bytes."
  value       = arvancloud_cdn_domain_caching.this.max_size
}

output "last_updated" {
  description = "The timestamp of the last update to the caching settings (RFC3339 format)."
  value       = arvancloud_cdn_domain_caching.this.last_updated
}

