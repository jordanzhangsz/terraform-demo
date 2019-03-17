provider "tencentcloud" {
  secret_id = "${var.secret_id}"
  secret_key = "${var.secret_key}"
  region = "ap-chengdu"
}

#Save results to remote http server
terraform {
  backend "http" {
    address = "http://127.0.0.1:8080"
    lock_address = "http://127.0.0.1:8080"
    unlock_address = "http://127.0.0.1:8080"
  }
}

#Get the input from remote http server
data "http" "input" {
  url = "http://127.0.0.1:8080/vpc/input"

  request_headers {
    "Accept" = "application/json"
  }
}

#Call module to create cloud resources
module "vpc" {
  source = "./vpc"
  secret_id = "${var.secret_id}"
  secret_key = "${var.secret_key}"
  region = "ap-chengdu"
  vpc = "vpc1"
  vpc_cidr_block = "10.1.0.0/16" 
}

output "vpc_id" {
  value="${module.vpc.vpc_id}"
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

output "subnet_id" {
  value="${module.subnet.subnet_id}"
}

module "security_group" {
  source = "./security-group"
  secret_id = "${var.secret_id}"
  secret_key = "${var.secret_key}"
  region = "ap-chengdu"
}

output "security_group_id" {
  value = "${module.security_group.security_group_id}"
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

output "instance_id" {
  value = "${module.vm.vm_instance_id}"
}

module "lb" {
  source = "./lb"
  secret_id = "${var.secret_id}"
  secret_key = "${var.secret_key}"
  region = "ap-chengdu"
  vpc_id = "${module.vpc.vpc_id}"
  name = "lb1"
  type = "OPEN"
  forward = "APPLICATION"
}

output "lb_id" {
  value = "${module.lb.lb_id}"
}

resource "tencentcloud_alb_server_attachment" "lb_attachment1" {
  loadbalancer_id = "${module.lb.lb_id}"
  listener_id="lbl-4f30tusj"
  #location_id = "loc-i858qv1l"
  backends = [
    {
      instance_id = "${module.vm.vm_instance_id}"
      port = 8080
      weight = 100
    }
  ]
}

