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
variable "tag" {
  description = "tag"
  type        = string
}

variable "pip_allocation" {
  description = "pip allocaiton type"
  type        = string
}

variable "allowip" {
  description = "allowing ips"
  type        = list(string)
}

variable "allowhttp" {
  description = "allowing http traffic"
  type        = string
}

variable "allowssh" {
  description = "allow ssh"
  type        = string
}

variable "sshpriority" {
  description = "ssh pripoority"
  type        = number
}
variable "direction" {
  description = "traffic direction"
  type        = string
}
variable "access" {
  description = "allow traffic"
  type        = string
}

variable "protocol" {
  description = "protocol"
  type        = string
}

variable "sprange" {
  description = "range of allowd ips"
  type        = string
}

variable "ssh_dprange" {
  description = "dp range"
  type        = string
}

variable "distaddr" {
  description = "dest addr"
  type        = string
}

variable "httpriority" {
  type        = number
  description = "http pripority"
}

variable "http_dprange" {
  type        = string
  description = "dp range"
}

variable "ipconfig" {
  type        = string
  description = "ip-config"
}

variable "vmsize" {
  type        = string
  description = "vm size"

}

variable "osdisk" {
  type        = string
  description = "os disk name"
}

variable "caching" {
  type        = string
  description = "caching"
}

variable "storageaccount" {
  type        = string
  description = "storageaccount"
}
variable "publisher" {
  type        = string
  description = "publisher"
}
variable "offer" {
  type        = string
  description = "offer"
}

variable "ossku" {
  type        = string
  description = "ossku"
}
variable "valversion" {
  type        = string
  description = "version"
}
variable "username" {
  type        = string
  description = "username"
  sensitive   = true
}

variable "vm_password" {
  type        = string
  description = "passwd"
  sensitive   = true
}