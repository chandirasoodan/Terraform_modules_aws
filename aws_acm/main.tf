## module for amazon certificate manager
module "certificate" {
  source                          = "./Modules"
  create_self_signed_certificate  = var.create_self_signed_certificate
  enable_import_certificate       = var.enable_import_certificate
  enable_aws_to_issue_cert        = var.enable_aws_to_issue_cert
  domain_name                     = var.domain_name
  validation_method               = var.validation_method
  transparency_logging_preference = var.transparency_logging_preference
  validation_option               = var.validation_option
  key_algorithm                   = var.key_algorithm
  tags                            = var.tags
}