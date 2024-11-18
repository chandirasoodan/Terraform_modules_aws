firewall = [{
  firewall_name = "test"
  policy_name = "test"
  firewall_description = "test"
  vpc_id = "vpc-00d343dafaa9c4007"
  delete_protection = false
  subnet_change_protection = false
  encryption_type = null
  kms_key_id = null
  subnet_mapping = ["subnet-055422f034920c791","subnet-08e9e6d533c7a1b22"]
}]
firewall_tags = {}
list-firewalls = []
list-firewall-policies = []

firewall_policy = [{
  policy_name = "test"
  policy_description = "test"
  stateless_default_actions = ["aws:forward_to_sfe"]
  stateless_fragment_default_actions =["aws:forward_to_sfe"]
  stateless_rule_group_reference_arns =null
  stateless_rule_group_reference = [/*{
   rule_group_name = "test"
   rule_group_arn = null
   action = "DROP_TO_ALERT" 
  }*/]
  stateful_rule_group_reference = [/*{
   rule_group_name = "test"
   rule_group_arn = null
  }*/]
  managed_rule_group = []
}]

firewall_policy_tags = {}

rule_group = [{
  rule_group_name = "test"
  capacity = 100
  rule_group_description = "test"
  rule_group_type = "STATELESS"
  rules = null
  rule_string = null
  stateful_rule_order = null
  portsets = [/*{
  port_set_key = ""
  port_set = []
}*/]
  ipsets= [/*{
    rule_group_name  = ""
    ipset_key = ""
    ip_set = []
}*/]
  rules_source_list = [/*{
    generated_rules_type = "DENYLIST"
    target_types         = ["HTTP_HOST"]
    targets              = ["test.example.com"]
  }*/]
  stateless_rules = [{
    stateless_custom_action = [{
    dimension = 1
    action_name = "testactionmetrics"
   }]
   priority = 1
   protocols = [6]
   actions = ["aws:pass", "testactionmetrics"]
   source_address_definition = [{address_definition = "0.0.0.0/0"}]
   source_port = [{
    from_port = 443
    to_port = 443
   }]
   destination_address_definition = [{address_definition = "0.0.0.0/0"}]
   destination_port = [{
    from_port = 443
    to_port = 443
   }]
   tcp_flag = [{
    flags = ["SYN"]
    masks = ["SYN", "ACK"]
   }]
  }]

}]
ipset_variables = [/*{
  rule_group_name  = ""
  ipset_key = ""
  ip_set = []
}*/]


stateful_rule = [/*{
  rule_group_name = "test"
  action = "PASS"
  destination = "0.0.0.0/0"
  destination_port = "ANY"
  protocol = "IP"
  direction = "FORWARD"
  source_port ="ANY"
  source = "1.0.0.0/0"
  keyword = "sid"
  settings = ["1"]
}*/]

firewall_rule_group_tags = {}

logging_configurations = [{
  firewall_name = "test"
  log_destination_config = [{
    log_destination = {
      logGroup = "test_firewall_logs"
    }
    log_destination_type = "CloudWatchLogs"
    log_type = "ALERT"
  }]
}]