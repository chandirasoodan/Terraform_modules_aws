module "cloudwatch" {
  source = "./modules"
  create_metric_alarm = var.create_metric_alarm
  alarm_name           = var.alarm_name
  comparison_operator  = var.comparison_operator
  evaluation_periods   = var.evaluation_periods
  metric_name          = var.metric_name
  namespace            = var.namespace
  period               = var.period
  statistic            = var.statistic
  threshold            = var.threshold
  alarm_description    = var.alarm_description
  alarm_tags           = var.alarm_tags
  create_log_group = var.create_log_group
  log_group_name = var.log_group_name
  log_group_tags = var.log_group_tags
  retention_in_days = var.retention_in_days
  create_sns = var.create_sns
  sns_name = var.sns_name
  sns_endpoint = var.sns_endpoint
  sns_protocol = var.sns_protocol
  create_cloudwatch_event = var.create_cloudwatch_event
  event_rule_description = var.event_rule_description
  event_rule_name = var.event_rule_name
  event_rule_tags = var.event_rule_tags
}

