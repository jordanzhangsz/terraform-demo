provider "tencentcloud" {
  secret_id = "${var.secret_id}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

resource "tencentcloud_instance" "vm" {
  instance_name = "vm1"
  availability_zone = "${var.availability_zone}"
  image_id = "${var.image_id}"
  instance_type = "${var.instance_type}"
  password = "${var.root_password}"
  allocate_public_ip = true
  internet_max_bandwidth_out = 1
  
  vpc_id = "${var.vpc_id}"
  subnet_id = "${var.subnet_id}"
  security_groups = ["${var.security_group_id}"]
  
  count = "${var.count}"
  
  provisioner "file" {
    source = "scripts/main"
    destination = "/root/main"
   
    connection {
      host = "${tencentcloud_instance.vm.public_ip}"
      type = "ssh"
      user = "root"
      password = "${var.root_password}"
    }
  }
}

