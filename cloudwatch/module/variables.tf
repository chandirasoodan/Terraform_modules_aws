variable create_metric_alarm {
    type = bool
    default = false
}
variable "alarm_name"{
    type = string
    default = null
}          
variable "comparison_operator"{
    type = string
    default = null
}
variable "evaluation_periods"{
  type = number
  default = 0
}
variable "metric_name"{
    type = string
    default = null
}
variable "namespace"{
    type = string
    default = null
}       
variable "period"{
    type = number
    default = 0
}             
variable "statistic"{
    type = string
    default = null
}           
variable "threshold"{
    type = number
    default = 0
}        
variable "alarm_description"{
        type = string
    default = null
}
variable "alarm_tags"{
    type = map(string)
    default = null
}          


variable "create_cloudwatch_event" {
  type = bool
  default = false
}
variable "event_rule_name" {
  type = string
  default = "false"
}
variable "event_rule_description" {
  type = string
  default = "event rule"
}
variable "event_rule_tags" {
  type = map(string)
  default = null
}
variable "create_sns" {
  type = bool
  default = false
}
variable "sns_name" {
  type = string
  default = null
}
variable "sns_tags" {
  type = map(string)
  default = null
}
variable "sns_endpoint" {
  type = list(string)
  default = null
}
variable "sns_protocol" {
  type = string
  default = null
}

variable "create_log_group" {
  type = bool
  default = false
}
variable "log_group_name" {
  type = string
  default = null
}
variable "log_group_class" {
  type = string
  default = "STANDARD"
}
variable "retention_in_days" {
  type = number
  default = 0
}
variable "kms_key_id" {
  type = string
  default = null
}
variable "log_group_tags" {
  type = map(string)
  default = null
}