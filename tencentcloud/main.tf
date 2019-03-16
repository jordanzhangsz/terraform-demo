terraform {
  backend "http" {
    address = "http://127.0.0.1:8080"
    lock_address = "http://127.0.0.1:8080"
    unlock_address = "http://127.0.0.1:8080"
  }
}

module "vpc" {
  source = "./vpc"
  secret_id = "${var.secret_id}"
  secret_key = "${var.secret_key}"
  region = "ap-chengdu"
  vpc = "vpc1"
  vpc_cidr_block = "10.1.0.0/16" 
}

module "subnet" {
  source = "./subnet"
  secret_id = "${var.secret_id}"
  secret_key = "${var.secret_key}"
  region = "ap-chengdu"
  availability_zone = "ap-chengdu-1"
  vpc_id = "${module.vpc.vpc_id}"
  subnet = "subnet1"
  subnet_cidr_block = "10.1.1.0/24"
}

module "security_group" {
  source = "./security-group"
  secret_id = "${var.secret_id}"
  secret_key = "${var.secret_key}"
  region = "ap-chengdu"
}

module "vm" {
  source = "./vm"
  secret_id = "${var.secret_id}"
  secret_key = "${var.secret_key}"
  region = "ap-chengdu"
  availability_zone = "ap-chengdu-1"
  vpc_id = "${module.vpc.vpc_id}"
  subnet_id = "${module.subnet.subnet_id}"
  security_group_id = "${module.security_group.security_group_id}"
}

output "vpc_id" {
  value="${module.vpc.vpc_id}"
}
