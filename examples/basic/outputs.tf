output "domain" {
  description = "The configured domain."
  value       = module.cdn_cache.domain
}

output "last_updated" {
  description = "Last update timestamp."
  value       = module.cdn_cache.last_updated
}
