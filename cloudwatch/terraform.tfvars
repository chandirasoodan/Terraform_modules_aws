  create_metric_alarm = true
  alarm_name           = "test_alarm"
  comparison_operator  = "GreaterThanOrEqualToThreshold"
  evaluation_periods   = 2
  metric_name          = "CPUUtilization"
  namespace            = "AWS/EC2"
  period               = 120
  statistic            = "Average"
  threshold            = 80
  alarm_description    = "test"
  alarm_tags           = {Name = "test"}
  create_log_group = true
  log_group_name = "test_log"
  log_group_tags = {Name = "test"}
  retention_in_days = 7
  create_sns = true
  sns_name = "test_sns"
  sns_endpoint = ["akash42jb@gmail.com"]
  sns_protocol = "email"
  create_cloudwatch_event = true
  event_rule_description = "test"
  event_rule_name = "test"
  event_rule_tags = {Name = "test"}