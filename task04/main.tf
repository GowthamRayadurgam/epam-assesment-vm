data "azurerm_resource_group" "existing" {
  name = var.resource_group_name
}

resource "azurerm_resource_group" "this" {
  name     = data.azurerm_resource_group.existing.name
  location = data.azurerm_resource_group.existing.location

  tags = {
    Creator = var.tag
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnetname
  location            = var.location
  address_space       = var.address_space
  resource_group_name = var.resource_group_name
  tags = {
    Creator = var.tag
  }
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnetname
  virtual_network_name = var.vnetname
  resource_group_name  = var.resource_group_name
  address_prefixes     = var.address_prefix
}

resource "azurerm_public_ip" "pip" {
  name                = var.pip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.pip_allocation
  domain_name_label   = var.dns_lable
  tags = {
    Creator = var.tag
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags = {
    Creator = var.tag
  }
}

resource "azurerm_network_security_rule" "allow_ssh" {
  name                        = var.AllowSSH
  priority                    = var.sshpriority
  direction                   = var.direction
  access                      = var.access
  protocol                    = var.protocol
  source_address_prefixes     = var.allowip
  source_port_range           = var.sprange
  destination_address_prefix  = var.distaddr
  destination_port_range      = var.ssh_dprange
  network_security_group_name = var.nsg_name
  resource_group_name         = var.resource_group_name

}

resource "azurerm_network_security_rule" "allow_http" {
  name                        = var.AllowHTTP
  priority                    = var.httpriority
  direction                   = var.direction
  access                      = var.access
  protocol                    = var.protocol
  source_port_range           = var.sprange
  destination_port_range      = var.http_dprange
  source_address_prefixes     = var.allowip
  destination_address_prefix  = var.distaddr
  network_security_group_name = var.nsg_name
  resource_group_name         = var.resource_group_name
}

resource "azurerm_network_interface" "nic" {
  name                = var.nicname
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = {
    Creator = var.tag
  }
  ip_configuration {
    name                          = var.ipconfig
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = var.pip_allocation
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
  depends_on = [azurerm_subnet.subnet, azurerm_public_ip.pip]
}

resource "azurerm_network_interface_security_group_association" "nsg_nic_association" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
  depends_on                = [azurerm_network_interface.nic, azurerm_network_security_group.nsg]
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  resource_group_name   = var.resource_group_name
  location              = var.location
  network_interface_ids = [azurerm_network_interface.nic.id]
  size                  = var.vmsize
  tags = {
    Creator = var.tag
  }
  name                            = var.vm_name
  admin_username                  = var.username
  admin_password                  = var.vm_password
  disable_password_authentication = false
  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.ossku
    version   = var.valversion
  }
  os_disk {
    name                 = var.osdisk
    caching              = var.caching
    storage_account_type = var.storageaccount
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install nginx"
    ]
    connection {
      type     = var.allowssh
      user     = var.username
      password = var.vm_password
      host     = azurerm_public_ip.pip.ip_address
    }
  }

}