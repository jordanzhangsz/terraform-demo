variable "secret_id" {}
variable "secret_key" {}
variable "region" {}
variable "availability_zone" {}
variable "vpc_id" {}
variable "subnet_id" {}
variable "security_group_id" {}

variable "root_password" {default="Ab888888"}
variable "image_id" {default="img-oikl1tzv"}
variable "instance_type" {default="I2.MEDIUM4"}
variable "count" {default=1}
