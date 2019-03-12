resource "tencentcloud_instance" "vm" {
  instance_name = "vm1"
  availability_zone = "${var.availability_zone}"
  image_id = "${var.image_id}"
  instance_type = "${var.instance_type}"
  password = "${var.root_password}"
  allocate_public_ip = true
  internet_max_bandwidth_out = 1
  
  subnet_id = "${tencentcloud_subnet.subnet1_vpc_a.id}"
  security_groups = ["${tencentcloud_security_group.web_access.id}"]
  vpc_id = "${tencentcloud_vpc.vpc_a.id}"
  
  count = "${var.count}"
  
  provisioner "file" {
    source = "scripts/init.sh"
    destination = "/etc/init.sh"
   
    connection {
      host = "${tencentcloud_instance.vm.public_ip}"
      type = "ssh"
      user = "root"
      password = "${var.root_password}"
    }
  }
}

