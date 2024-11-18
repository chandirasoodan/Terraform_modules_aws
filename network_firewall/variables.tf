variable "vpc" {
  type = list(object({
    vpc_name = string
    cidr_block = string
    tags = map(string) 
  }))
  default = []
}
variable "list-firewalls" {
  type = list(string)
  default = []
}
variable "list-firewall-policies" {
  type = list(string)
  default = []
}
variable "firewall" {
  type        = any
  description = "firewall configurations"
  default = []
}

variable "firewall_policy" {
  type        = any
  description = "firewall policy configurations"
  default = []
}

variable "rule_group" {
  type        = any
  description = "firewall policy configurations"
  default = []
}

variable "stateful_rule" {
  type        = any
  description = "stateful rule"
  default = []
}

variable "firewall_tags" {
  type        = map(string)
  description = "tag values"
  default = { }
}

variable "common_tags" {
  type        = map(string)
  description = "tag values"
  default = { }
}


variable "firewall_policy_tags" {
  type        = map(string)
  description = "tag values"
  default = { }
}

variable "firewall_rule_group_tags" {
  type        = map(string)
  description = "tag values"
  default = { }
}
variable "ipset_variables" {
  type        = any 
  description = "variable sets to define ips and ports" 
  default =  []
}
variable "portset_variables" {
  type        = any 
  description = "variable sets to define ips and ports" 
  default =  []
}

variable "managed_rule_group" {
  type        = list(string)
  description = "list of aws managed rule groups"  
  default =  []
}
variable "logging_configurations" {
  type = any
  default = []
}