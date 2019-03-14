provider "tencentcloud" {
  region = "${var.region}"
  secret_id = "${var.secret_id}"
  secret_key = "${var.secret_key}"
}

resource "tencentcloud_subnet" "subnet" {
  name = "${var.subnet}"
  cidr_block = "${var.subnet_cidr_block}"
  availability_zone = "${var.availability_zone}"
  vpc_id = "${var.vpc_id}"
}

