variable "ip_set_name" {
  type = string
  default = null
  description = "ip set name"
}
variable "ip_set_description" {
  type = string
  default = null
  description = "appropriate description for ip set"
}
variable "ip_set_scope" {
  type = string
  default = "REGIONAL"
  description = "specifies whether this is for an AWS CloudFront distribution or for a regional application"
}
variable "ip_address_version" {
  type = string
  default = "IPV4"
  description = "ip address version"
}
variable "ip_addresses" {
  type = list(string)
  default = []
  description = "list of ip addresses"
}
variable "ip_set_tags" {
  type = map(string)
  default = null
  description = "tags for ipset"
}

variable "regex_pattern_name" {
  type = string
  default = null
  description = "appropriate name for regex pattern"
}
variable "regex_pattern_description" {
  type = string
  default = null
  description = "appropriate description for regex pattern"
}
variable "regex_pattern_scope" {
  type = string
  default = null
  description = "specifies whether this is for an AWS CloudFront distribution or for a regional application"
}
variable "regex_string" {
  type = string
  default = null
  description = "regex pattern string"
}
variable "regex_tags" {
  type = map(string)
}
variable "rule_group_name" {
  type = string
  default = null
  description = "appropriate name for rule group"
}
variable "rule_group_scope" {
  type = string
  default = null
  description = "specifies whether this is for an AWS CloudFront distribution or for a regional application"
}
variable "rule_group_capacity" {
  type = number
  default = 2
  description = "rule group capacity"
}
variable "country_codes" {
  type = list(string)
  default = null
  description = "country codes in list of string"
}
variable "web_acl_name" {
  type = string
  default = null
  description = "appropriate dname for web acl"
}
variable "web_acl_scope" {
  type = string
  default = null
  description = "specifies whether this is for an AWS CloudFront distribution or for a regional application"
}
variable "web_acl_tags" {
  type = map(string)
}