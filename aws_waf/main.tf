module "waf" {
  source = "./Modules"
  ip_set_name = var.ip_set_description 
  ip_set_description = var.ip_set_description
  ip_set_scope = var.ip_set_scope
  ip_address_version = var.ip_address_version
  ip_addresses = var.ip_addresses
  ip_set_tags = var.ip_set_tags
  regex_pattern_name = var.regex_pattern_name
  regex_pattern_description = var.regex_pattern_description
  regex_pattern_scope = var.regex_pattern_scope
  regex_string = var.regex_string
  regex_tags = var.regex_tags
  rule_group_capacity = var.rule_group_capacity
  rule_group_name = var.rule_group_name
  rule_group_scope = var.rule_group_scope
  web_acl_name = var.web_acl_name
  web_acl_scope = var.web_acl_scope
  web_acl_tags = var.web_acl_tags
  country_codes = var.country_codes
}