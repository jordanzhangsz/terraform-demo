output "vm_instance_id" {
  value = "${tencentcloud_instance.vm.*.id}"
}

output "vm_private_id" {
  value = "${tencentcloud_instance.vm.*.private_ip}"
}

output "vm_public_id" {
  value = "${tencentcloud_instance.vm.*.public_ip}"
}

output "vm_image_id" {
  value = "${tencentcloud_instance.vm.*.image_id}"
}
