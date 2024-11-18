resource "aws_wafv2_ip_set" "ip_set" {
  name               = var.ip_set_name
  description        = var.ip_set_description
  scope              = var.ip_set_scope
  ip_address_version = var.ip_address_version
  addresses          = var.ip_addresses
  tags               = var.ip_set_tags
}

resource "aws_wafv2_regex_pattern_set" "regex" {
  name        = var.regex_pattern_name
  description = var.regex_pattern_description
  scope       = var.regex_pattern_scope
  regular_expression {
    regex_string = var.regex_string
  }
  tags = var.regex_tags
}


resource "aws_wafv2_rule_group" "rule-group" {
  name     = var.rule_group_name
  scope    = var.rule_group_scope
  capacity = var.rule_group_capacity

  rule {
    name     = "rule-1"
    priority = 1

    action {
     allow {} 
    }

    statement {

      geo_match_statement {
        country_codes = var.country_codes
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "friendly-rule-metric-name"
      sampled_requests_enabled   = false
    }
  }
  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "friendly-metric-name"
    sampled_requests_enabled   = false
  }
}

resource "aws_wafv2_web_acl" "web_acl" {
  name  = var.web_acl_name#"rule-group-example"
  scope = var.web_acl_scope#"REGIONAL"

  default_action {
    block {}
  }

  rule {
    name     = "rule-1"
    priority = 1

    override_action {
      count {}
    }
    statement {
      rule_group_reference_statement {
      arn = aws_wafv2_rule_group.rule-group.arn
       }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "${var.web_acl_name}-rule-metric-name"
      sampled_requests_enabled   = false
    }
  }

  tags = var.web_acl_tags

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "${var.web_acl_name}-metric-name"
    sampled_requests_enabled   = false
  }
}