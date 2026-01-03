variable "domain" {
  description = "UUID or the name of the CDN domain. This is required and used to identify the domain for cache settings."
  type        = string

  validation {
    condition     = length(var.domain) > 0
    error_message = "The domain must not be empty."
  }
}

variable "developer_mode" {
  description = <<-EOT
    Enable or disable developer mode for the CDN domain.
    When enabled, cache is bypassed which is useful during development.
    Should be disabled in production environments.
  EOT
  type        = bool
  default     = false
}

variable "consistent_uptime" {
  description = <<-EOT
    Enable or disable consistent uptime mode.
    When enabled, helps maintain availability by serving stale content
    if the origin server is unavailable.
  EOT
  type        = bool
  default     = true
}

variable "max_size" {
  description = <<-EOT
    Maximum size of cacheable content in bytes.
    Valid range is 0 to 2147483648 bytes (2GB).
    Content larger than this size will not be cached.
  EOT
  type        = number
  default     = 104857600 # 100MB default

  validation {
    condition     = var.max_size >= 0 && var.max_size <= 2147483648
    error_message = "The max_size must be between 0 and 2147483648 bytes (2GB)."
  }
}
