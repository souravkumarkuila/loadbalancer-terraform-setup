variable "bastion_name" {}
variable "location" {}
variable "resource_group_name" {}

variable "bastion_subnet_id" {
  description = "Subnet ID for Bastion"
}

variable "bastion_pip_id" {
  description = "Public IP ID for Bastion"
}
