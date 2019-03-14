provider "tencentcloud" {
  region = "${var.region}"
  secret_id = "${var.secret_id}"
  secret_key = "${var.secret_key}"
}

resource "tencentcloud_vpc" "vpc" {
  name       = "${var.vpc}"
  cidr_block = "${var.vpc_cidr_block}"
}

