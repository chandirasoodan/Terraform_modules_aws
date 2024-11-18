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

variable "transparency_logging_preference" {
  type        = string
  default     = "DISABLED"
  description = "Whether certificate details should be added to a certificate transparency log"
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