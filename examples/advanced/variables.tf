variable "arvancloud_api_key" {
  description = "ArvanCloud API key for authentication"
  type        = string
  sensitive   = true
}

variable "domain" {
  description = "The CDN domain name."
  type        = string
  default     = "api.example.com"
}

variable "environment" {
  description = "Environment name (production, staging, development)."
  type        = string
  default     = "production"

  validation {
    condition     = contains(["production", "staging", "development"], var.environment)
    error_message = "Environment must be one of: production, staging, development."
  }
}

variable "cache_size_mb" {
  description = "Maximum cache size in megabytes."
  type        = number
  default     = 100

  validation {
    condition     = var.cache_size_mb >= 1 && var.cache_size_mb <= 2048
    error_message = "Cache size must be between 1 and 2048 MB."
  }
}
