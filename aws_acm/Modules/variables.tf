variable "create_self_signed_certificate" {
  type        = bool
  default     = false
  description = "true/false to create self signed certificate"
}
variable "domain_name" {
  type        = string
  default     = null
  description = "domain name for creating certificate"
}
variable "organization_name" {
  type        = string
  default     = null
  description = "organization name for creating self signed certificate"
}
variable "validity_period_hours" {
  type        = number
  default     = 12
  description = "validity hour for self signed certificate"
}
variable "private_key" {
  type        = string
  default     = null
  description = "private key file"
}
variable "certificate_chain" {
  type        = string
  default     = null
  description = "certificate chain file"
}
variable "validation_method" {
  type        = string
  default     = "DNS"
  description = "validation method DNS/EMAIL"
}
variable "subject_alternative_names" {
  type        = list(string)
  default     = []
  description = "subject alternative names for domain name"
}
variable "transparency_logging_preference" {
  type        = string
  default     = "DISABLED"
  description = "Whether certificate details should be added to a certificate transparency log"
}
variable "private_certificate_authority_arn" {
  type        = string
  default     = null
  description = "ARN of an ACM PCA"
}

variable "validation_option" {
  type = list(object({
    domain_name       = string
    validation_domain = string
  }))
  default     = []
  description = "Domain name that you want ACM to use to send you validation emails"
}

variable "tags" {
  type        = map(string)
  description = "tag value for ACM"
}

variable "key_algorithm" {
  type        = string
  default     = "RSA_2048"
  description = "Specifies the algorithm of the public and private key pair that your Amazon issued certificate uses to encrypt data"
}
variable "enable_aws_to_issue_cert" {
  type        = bool
  default     = true
  description = "true/false to determine whether aws issue the certificate"
}

variable "enable_import_certificate" {
  type        = bool
  default     = false
  description = "true/false to determine whether aws issue the certificate"
}