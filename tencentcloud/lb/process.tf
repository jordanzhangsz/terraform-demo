provider "tencentcloud" {
  secret_id = "${var.secret_id}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

resource "tencentcloud_lb" "lb" {
  name = "${var.name}"
  type = "${var.type}"
  forward = "${var.forward}"
  vpc_id = "${var.vpc_id}"
}
