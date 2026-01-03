################################################################################
# Outputs for Multi-Environment Configuration
################################################################################

output "environments" {
  description = "Cache configuration for all environments."
  value = {
    for env, config in module.cdn_cache : env => {
      domain            = config.domain
      developer_mode    = config.developer_mode
      consistent_uptime = config.consistent_uptime
      max_size_mb       = config.max_size / 1048576
      last_updated      = config.last_updated
    }
  }
}

output "production_domain" {
  description = "Production domain configuration."
  value       = module.cdn_cache["production"].domain
}

output "developer_mode_enabled" {
  description = "Domains with developer mode enabled."
  value = [
    for env, config in module.cdn_cache : config.domain
    if config.developer_mode
  ]
}

################################################################################
# Outputs for Single Domain Configuration
################################################################################

output "single_domain" {
  description = "Single domain cache configuration."
  value = {
    domain            = module.cdn_cache_single.domain
    developer_mode    = module.cdn_cache_single.developer_mode
    consistent_uptime = module.cdn_cache_single.consistent_uptime
    max_size_mb       = module.cdn_cache_single.max_size / 1048576
    last_updated      = module.cdn_cache_single.last_updated
  }
}
