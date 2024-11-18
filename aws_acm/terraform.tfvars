create_self_signed_certificate  = false
enable_import_certificate       = false
enable_aws_to_issue_cert        = true
domain_name                     = "letzfinish.info"
validation_method               = "DNS"
transparency_logging_preference = "ENABLED"
validation_option = [{
  domain_name       = "letzfinish.info"
  validation_domain = "letzfinish.info"
}]
key_algorithm = "RSA_2048"
tags = {
  Name = "Nothing"
}