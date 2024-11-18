### Acceptor side ###

module "role" {
    source = "./module/iam/role"
    providers = {
      aws = aws.ajay
    }
    role_name = "cloud_guru_cross_acc"
    role_tag = {
        Name = "akash"
    }
    assume_role_policy = data.template_file.cross_acc_acceptor.rendered
}

data "template_file" "cross_acc_acceptor" {
    template = file("./module/iam/policies/cross_acc_acceptor.tpl")
    vars = {
      account_id = "596296296333"
    }
  
}

module "policy" {
    source = "./module/iam/policy"
    providers = {
      aws = aws.ajay
    }
    policy_name = "cloud_guru_cross_acc_policy"
    policy = file("./module/iam/policies/acceptor_role_permission.json")

  
}


module "role_policy_attachment" {
    source = "./module/iam/role_policy_attachment"
    providers = {
      aws = aws.ajay
    }
    policy_arn = module.policy.policy_arn
    role_name = module.role.role_name
  
}



#### Requestor Account ####

module "user" {
  source = "./module/iam/user"
  providers = {
    aws = aws.cloud_guru
  }
  user_name = "chandira"
  user_tags = {
    Name = "chandira"
  }
}

module "requestor_iam_policy" {
    source = "./module/iam/policy"
    policy_name = "ajay_cross_acc_policy"
    providers = {
    aws = aws.cloud_guru
  }
    policy = data.template_file.requestor_user_policy.rendered
  
}

data "template_file" "requestor_user_policy" {
    template = file("./module/iam/policies/requestor_user_policy.tpl")
    vars = {
      account_id = "138827503498"
      role_name = module.role.role_name
    }
  
}

module "user_policy_attachment" {
  source = "./module/iam/user_policy_attachment"
  providers = {
    aws = aws.cloud_guru
  }
  user_name = module.user.user_name
  policy_arn = module.requestor_iam_policy.policy_arn
}



##### testing cross acc access ######

resource "aws_s3_bucket" "s3" {

    provider = aws.test
    bucket = "test-138827503498"
    tags = {
      Name = "test-138827503498"
    }
  
}