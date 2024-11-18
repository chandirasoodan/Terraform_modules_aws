provider "aws" {
    alias = "cloud_guru"
    profile = "cloud_guru"
    region = "us-east-1"  
}

provider "aws" {
    alias = "ajay"
    profile = "ajay"
    region = "us-east-1"  
}

provider "aws" {
    alias = "test"
    profile = "cloud_guru"
    region = "us-east-1"  
    assume_role {
      role_arn = "arn:aws:iam::**********:role/cloud_guru_cross_acc"
    }
}