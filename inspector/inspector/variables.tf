variable "inspector-group-tags" {
  type        = map(string)
  description = "tags for creating inspector resource group"
}

variable "assessment_target_name" {
  type        = string
  description = "name for creating assessment target"
}

variable "assessment_template_name" {
  type        = string
  description = "name for creating assessment template"
}

variable "inspector_run_duration" {
  type        = number
  description = "running duration"
}

variable "rules_package_arns" {
  type        = list(string)
  description = "the rules to be used during the run"
}

variable "enable_inspector_classic" {
  type        = bool
  description = "either to enable/disable inspector classic"
  default     = false
}

variable "enable_inspector_v2" {
  type        = bool
  description = "either to enable/disable inspector v2"
  default     = false
}


variable "account_ids" {
  type        = list(string)
  description = "Set of account IDs"
  default     = null
}

variable "delegated_admin_account_id" {
  type        = string
  description = "delegated admin account id"
  default     = null
}

variable "member_account_id" {
  type        = string
  description = "member account id"
  default     = null
}