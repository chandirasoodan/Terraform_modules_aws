resource "aws_cloudwatch_metric_alarm" "monitoring" {
  count = var.create_metric_alarm == true ? 1 : 0
  alarm_name           = var.alarm_name 
  comparison_operator  = var.comparison_operator
  evaluation_periods   = var.evaluation_periods
  metric_name          = var.metric_name
  namespace            = var.namespace
  period               = var.period
  statistic            = var.statistic
  /*dimensions = {
    AutoScalingGroupName = length(var.AutoScalingGroupName) > 0 ? var.AutoScalingGroupName : null
        TargetGroup         = length(var.TargetGroup) > 0 ? replace(var.TargetGroup_ids[var.TargetGroup],"arn:aws:elasticloadbalancing:${var.region}:${data.aws_caller_identity.current.account_id}:","") : null
        LoadBalancer        = length(var.LoadBalancer) > 0 ? replace(var.loadbalancer_ids[var.LoadBalancer],"arn:aws:elasticloadbalancing:${var.region}:${data.aws_caller_identity.current.account_id}:loadbalancer/","") : null
  }*/
  threshold            = var.threshold
  alarm_description = var.alarm_description
  alarm_actions     = [aws_sns_topic.sns[0].arn]
  tags              = var.alarm_tags
  
}


resource "aws_cloudwatch_event_rule" "rule" {
  count       = var.create_cloudwatch_event == true ? 1: 0
  name        = var.event_rule_name
  description = var.event_rule_description
  event_pattern = jsonencode({
    source = [
      "aws.autoscaling"
    ]

    detail-type = [
      "EC2 Instance Launch Successful",
      "EC2 Instance Terminate Successful",
      "EC2 Instance Launch Unsuccessful",
      "EC2 Instance Terminate Unsuccessful"
    ]
  })
  tags        = var.event_rule_tags
}

## cloudwatch event target ##
resource "aws_cloudwatch_event_target" "sns" {
  count     = var.create_cloudwatch_event == true ? 1: 0
  rule      = aws_cloudwatch_event_rule.rule[0].name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.sns[0].arn
  depends_on= [aws_cloudwatch_event_rule.rule,aws_sns_topic.sns]
}


resource "aws_sns_topic" "sns" {
  count = var.create_sns == true ? 1 : 0
  name = var.sns_name
  tags = var.sns_tags
}

## sns topic policy ##
resource "aws_sns_topic_policy" "sns_policy" {
  count = var.create_sns == true ? 1 : 0
  arn    = aws_sns_topic.sns[0].arn
  policy = data.aws_iam_policy_document.sns_topic_policy[0].json
}

## sns policy document ##
data "aws_iam_policy_document" "sns_topic_policy" {
  count = var.create_sns == true ? 1 : 0
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [aws_sns_topic.sns[0].arn]
  }
}
## sns subscription ##
resource "aws_sns_topic_subscription" "datahub-topic-to-queue-subscribe" {
  count     = var.create_sns == true? length(var.sns_endpoint) : 0
  topic_arn = aws_sns_topic.sns[0].arn
  protocol  = var.sns_protocol
  endpoint  = var.sns_endpoint[count.index]
}

## cloudwatch log group ##
resource "aws_cloudwatch_log_group" "logs" {
  count     = var.create_log_group == true ? 1 : 0
  name      = var.log_group_name
  skip_destroy      = false
  log_group_class   = var.log_group_class
  retention_in_days = var.retention_in_days
  #kms_key_id        = length(var.kms_key_id)>0?var.kms_key_id:null
  tags = var.log_group_tags
}