variable "vnetname" {
  description = "vnet name"
  type        = string
}

variable "location" {
  description = "localtion"
  type        = string
}

variable "resource_group_name" {
  description = "resource group name"
  type        = string
}

variable "address_space" {
  description = "address space for vnet"
  type        = list(string)
}
variable "subnetname" {
  description = "subnet name"
  type        = string
}
variable "address_prefix" {
  description = "address space for subnet"
  type        = list(string)
}

variable "pip_name" {
  description = "public ip name"
  type        = string
}

variable "dns_lable" {
  description = "dns name"
  type        = string

}
variable "nsg_name" {
  description = "nsg name"
  type        = string

}
variable "nicname" {
  description = "nic name"
  type        = string

}

variable "vm_name" {
  description = "vm-name"
  type        = string

}