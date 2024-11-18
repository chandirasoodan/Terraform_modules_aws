## tls resource for creating private key
resource "tls_private_key" "tls" {
  count     = var.create_self_signed_certificate == true ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

## tls resource for creating self signed certificate
resource "tls_self_signed_cert" "cert" {
  count           = var.create_self_signed_certificate == true ? 1 : 0
  private_key_pem = tls_private_key.tls[0].private_key_pem

  subject {
    common_name  = var.create_self_signed_certificate == true ? var.domain_name : null
    organization = var.organization_name
  }

  validity_period_hours = var.create_self_signed_certificate == true ? var.validity_period_hours : 12

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

## resource to import certificate
resource "aws_acm_certificate" "import" {
  count             = var.create_self_signed_certificate == true || var.enable_import_certificate == true ? 1 : 0
  private_key       = var.create_self_signed_certificate == true ? tls_private_key.tls[0].private_key_pem : var.private_key
  certificate_body  = var.create_self_signed_certificate == true ? tls_self_signed_cert.cert[0].cert_pem : var.private_key
  certificate_chain = var.create_self_signed_certificate == true ? null : var.certificate_chain
}

## resource to create certificate in aws
resource "aws_acm_certificate" "cert" {
  count                     = var.enable_aws_to_issue_cert == true ? 1 : 0
  domain_name               = var.domain_name #"letzfinish.info"
  validation_method         = var.validation_method
  subject_alternative_names = var.subject_alternative_names
  #early_renewal_duration = "7"
  dynamic "validation_option" {
    for_each = [for i in var.validation_option : i]
    content {
      domain_name       = validation_option.value.domain_name
      validation_domain = validation_option.value.validation_domain #"letzfinish.info"
    }
  }
  options {
    certificate_transparency_logging_preference = var.transparency_logging_preference #"ENABLED"
  }
  certificate_authority_arn = var.private_certificate_authority_arn
  key_algorithm             = var.key_algorithm
  tags                      = var.tags
}