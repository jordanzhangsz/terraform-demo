provider "tencentcloud" {
region = "${var.region}"
secret_id = "${var.secret_id}"
secret_key = "${var.secret_key}"
}

resource "tencentcloud_vpc" "vpc_a" {
  name       = "${var.vpc_a}"
  cidr_block = "10.3.0.0/16"
}

resource "tencentcloud_subnet" "subnet1_vpc_a" {
  name = "subnet1"
  cidr_block = "10.3.1.0/24"
  availability_zone = "${var.availability_zone}"
  vpc_id = "${tencentcloud_vpc.vpc_a.id}"
}

resource "tencentcloud_security_group" "web_access" {
  name        = "web access"
  description = "make it accessible the web application"
}
resource "tencentcloud_security_group_rule" "web" {
  security_group_id = "${tencentcloud_security_group.web_access.id}"
  type              = "ingress"
  cidr_ip           = "0.0.0.0/0"
  ip_protocol       = "tcp"
  port_range        = "80,3000,8080"
  policy            = "accept"
}
resource "tencentcloud_security_group_rule" "ssh" {
  security_group_id = "${tencentcloud_security_group.web_access.id}"
  type              = "ingress"
  cidr_ip           = "0.0.0.0/0"
  ip_protocol       = "tcp"
  port_range        = "22"
  policy            = "accept"
}

resource "tencentcloud_security_group_rule" "egress-accept" {
 security_group_id = "${tencentcloud_security_group.web_access.id}"
  type              = "egress"
  cidr_ip           = "0.0.0.0/0"
  ip_protocol       = "tcp"
  port_range        = "22"
  policy            = "accept"
}
