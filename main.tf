resource "arvancloud_cdn_domain_caching" "this" {
  domain            = var.domain
  developer_mode    = var.developer_mode
  consistent_uptime = var.consistent_uptime
  max_size          = var.max_size

  lifecycle {
    # Prevent accidental destruction as this resource requires import
    prevent_destroy = true
  }
}
