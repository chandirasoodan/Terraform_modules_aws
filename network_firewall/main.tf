################################## sdwan ###########################################
locals {
  common_tags = var.common_tags
}
## cloudwatch log group ##
resource "aws_cloudwatch_log_group" "logs" {
  for_each = {for i in var.firewall: i.firewall_name => i}
  name     = "${each.value.firewall_name}_firewall_logs"
}
## firewall logging configuration ##
resource "aws_networkfirewall_logging_configuration" "logging" {
  for_each = {for i in var.logging_configurations: i.firewall_name => i}
  firewall_arn = aws_networkfirewall_firewall.network-firewall[each.value.firewall_name].arn
  logging_configuration {
    dynamic log_destination_config {
      for_each = each.value.log_destination_config
      content {
        log_destination = log_destination_config.value.log_destination
      log_destination_type = log_destination_config.value.log_destination_type
      log_type             = log_destination_config.value.log_type 
      }
      
    }
  }
}
## Firewall  ##
resource "aws_networkfirewall_firewall" "network-firewall" {
  for_each                  = {for i in var.firewall: i.firewall_name => i}
  name                      = each.value.firewall_name
  description               = each.value.firewall_description
  firewall_policy_arn       = aws_networkfirewall_firewall_policy.fw-policy[each.value.policy_name].id 
  vpc_id                    = each.value.vpc_id
  delete_protection         = tobool(lower(each.value.delete_protection))
  subnet_change_protection  = tobool(lower(each.value.subnet_change_protection))
  dynamic encryption_configuration {
    for_each = each.value.encryption_type == "CUSTOMER_KMS" || each.value.encryption_type=="AWS_OWNED_KMS_KEY" ? [1] : []
    content {
      type = each.value.encryption_type
      key_id = each.value.kms_key_id
    }
  }
  dynamic subnet_mapping {
    for_each                = [for i in each.value.subnet_mapping: i] 
    content {
    subnet_id               = subnet_mapping.value
    ip_address_type         = "IPV4"
  }
}
tags = merge(local.common_tags,var.firewall_tags)
}

resource "aws_networkfirewall_firewall_policy" "fw-policy" {
  for_each    = {for i in var.firewall_policy: i.policy_name => i}
  name        = each.value.policy_name
  description = each.value.policy_description
    firewall_policy {
        stateless_default_actions           = each.value.stateless_default_actions
        stateless_fragment_default_actions  =  each.value.stateless_fragment_default_actions
        dynamic stateless_rule_group_reference {
          for_each = each.value.stateless_rule_group_reference
          content {
            resource_arn                    = stateless_rule_group_reference.value.rule_group_arn == null ? aws_networkfirewall_rule_group.fw-rg01[stateless_rule_group_reference.value.rule_group_name].arn : stateless_rule_group_reference.value.rule_group_arn
            priority                        = length(var.managed_rule_group)+1
          }
          
        }
        dynamic stateful_rule_group_reference {
          for_each = each.value.stateful_rule_group_reference
          content {
            resource_arn                    = stateful_rule_group_reference.value.rule_group_arn == null ? aws_networkfirewall_rule_group.fw-rg01[stateful_rule_group_reference.value.rule_group_name].arn : stateful_rule_group_reference.value.rule_group_arn
            priority                        = length(var.managed_rule_group)+1
            override {
              action = stateful_rule_group_reference.value.action
            }
          }
        }
        dynamic stateful_rule_group_reference {
          for_each = var.managed_rule_group
          content {
            resource_arn = "arn:aws:network-firewall:us-east-1:aws-managed:stateful-rulegroup/${stateful_rule_group_reference.value}"
            priority = index(var.managed_rule_group,"${stateful_rule_group_reference.value}")+1
            override {
                  action = "DROP_TO_ALERT" 
                }
          }
      }
      stateful_default_actions = []
        stateful_engine_options {
          rule_order                        =  "STRICT_ORDER"
        }
       
    }
 
  tags        = merge(local.common_tags,var.firewall_policy_tags)
  depends_on  = [ aws_networkfirewall_rule_group.fw-rg01 ]
}


resource "aws_networkfirewall_rule_group" "fw-rg01" {
  for_each    = {for i in var.rule_group: i.rule_group_name => i}
  capacity    = each.value.capacity
  description = each.value.rule_group_description
  name        = each.value.rule_group_name
  type        = each.value.rule_group_type
  tags        = merge(local.common_tags,var.firewall_rule_group_tags)
  rules       = each.value.rules == null ? null : file(each.value.rules)
  rule_group {
    dynamic rule_variables {
      for_each = length(each.value.ipsets) > 0 || length(each.value.portsets)>0 ? [1] : []
      content {
      dynamic ip_sets {
        for_each = each.value.ipsets
        content {
        key = ip_sets.value.ip_set_key
        ip_set {
          definition = ip_sets.value.ip_set
        }
      }
      }
      dynamic port_sets {
        for_each = each.value.portsets
        content {
        key = port_sets.value.port_set_key
        port_set {
          definition = port_sets.value.port_set
        }
       }
      }
    }
  }
    rules_source {  
      rules_string = each.value.rule_string == null ? null : file(each.value.rules_string)
      dynamic rules_source_list {
        for_each = each.value.rules_source_list
        content {
        generated_rules_type = rules_source_list.value.generated_rules_type
        target_types         = rules_source_list.value.target_types
        targets              = rules_source_list.value.targets
        }
      }
      dynamic stateful_rule {
        for_each =  [for item in var.stateful_rule: item if item.rule_group_name == each.value.rule_group_name]#[for item in [for i in var.stateful_rule:i.rule_group_name == each.value.rule_group_name? i:{}]: item if length(item)>0]
        content{
          action =  stateful_rule.value.action
          header {
            destination      = stateful_rule.value.destination
            destination_port = stateful_rule.value.destination_port
            protocol         = stateful_rule.value.protocol
            direction        = stateful_rule.value.direction
            source_port      = stateful_rule.value.source_port
            source           = stateful_rule.value.source
            }
          rule_option {
            keyword  = stateful_rule.value.keyword
            settings = stateful_rule.value.settings
      }
    }
  }

dynamic stateless_rules_and_custom_actions {
  for_each = length(each.value.stateless_rules)>0 ? each.value.stateless_rules : []
  content {
        dynamic custom_action {
          for_each = stateless_rules_and_custom_actions.value.stateless_custom_action
          content {
            action_definition {
              publish_metric_action {
                dimension {
                  value = custom_action.value.dimension
                }
              }
            }
            action_name = custom_action.value.action_name
          }
        }
        stateless_rule {
          priority = stateless_rules_and_custom_actions.value.priority
          rule_definition {
            
            actions = stateless_rules_and_custom_actions.value.actions
            match_attributes {
              dynamic source {
                for_each = stateless_rules_and_custom_actions.value.source_address_definition
                content {
                  address_definition = source.value.address_definition
                }
              }
              dynamic source_port {
                for_each = stateless_rules_and_custom_actions.value.source_port
                content {
                  from_port = source_port.value.from_port
                  to_port   = source_port.value.to_port
                }
              }
              dynamic destination {
                for_each = stateless_rules_and_custom_actions.value.destination_address_definition
                content {
                  address_definition = destination.value.address_definition
                }
              }
              dynamic destination_port {
                for_each = stateless_rules_and_custom_actions.value.destination_port
                content {
                  from_port = destination_port.value.from_port
                  to_port   = destination_port.value.to_port
                }
              }
              protocols = stateless_rules_and_custom_actions.value.protocols
              dynamic tcp_flag {
                for_each = stateless_rules_and_custom_actions.value.tcp_flag
                content {
                  flags = tcp_flag.value.flags
                  masks = tcp_flag.value.masks
                }
              }
            }
          }
        }
      }
      }

 }
 dynamic stateful_rule_options {
  for_each = each.value.stateful_rule_order == null ? [] : each.value.stateful_rule_order
  content {
      rule_order = each.value.stateful_rule_order
  }
 }
}
}
/*
import {
  to = ""
  id = ""
}

*/
output "name" {
  value = {for i,j in {"1" = {name = "one"}} : j.name => "two" if j.name == "one"}
}