// provider

provider "aws" {
  region = "us-east-1"
  access_key = ""
  secret_key = ""
}

//resources

//resource "aws_vpc" "vpc" {
//  cidr_block       = var.vpc_cidr
//
//  tags = {
//    Name = "demo-vpc"
//  }
//}

// variables

//variable "vpc_cidr" {
//  default = "10.0.0.0/16"
//  description = "Specify VPC Cidr block"
//  type = string
//}

// Supported tf objects [data types]
// string = "taco"
// number = 10
// number = 5.5
// bool = true
// list = ["bean-taco", "test-taco"]
// map = { name = "test" , age = 42, loves_taco = true }

// data

// getting all vpcs

data "aws_vpcs" "all_vpcs" {
}

output "all_vpcs" {
  value = data.aws_vpcs.all_vpcs.ids
}

// getting my vpc

data "aws_vpc" "selected" {
  default = false
  tags = {
    Name = "my-vpc"
  }
}

output "aws_my_vpc" {
  value = data.aws_vpc.selected.id
}

// getting default vpc

data "aws_vpc" "default" {
  default = true
}

resource "aws_subnet" "subnet-1" {
  cidr_block = ""
  vpc_id = data.aws_vpc.default.id
}


output "aws_default_vpc" {
  value = data.aws_vpc.default.id
}
