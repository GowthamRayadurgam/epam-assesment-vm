data "azurerm_resource_group" "existing" {
  name = "cmtr-4014a7a2-mod4-rg"
}

resource "azurerm_resource_group" "this" {
  name     = data.azurerm_resource_group.my_resource_group.name
  location = data.azurerm_resource_group.my_resource_group.location

  tags = {
    Creator = "gowtham_rayadurgam@epam.com"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnetname
  location            = var.location
  address_space       = var.address_space
  resource_group_name = var.resource_group_name
  tags = {
    Creator = "gowtham_rayadurgam@epam.com"
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
  allocation_method   = "Static"
  domain_name_label   = var.dns_lable
  tags = {
    Creator = "gowtham_rayadurgam@epam.com"
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags = {
    Creator = "gowtham_rayadurgam@epam.com"
  }
}

resource "azurerm_network_security_rule" "allow_ssh" {
  name                        = "ssh"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefixes     = ["18.153.146.156", "124.123.169.117"]
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "22"
  network_security_group_name = var.nsg_name
  resource_group_name         = var.resource_group_name
  
}

resource "azurerm_network_security_rule" "allow_http" {
  name                        = "allow-http"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefixes     = ["18.153.146.156", "124.123.169.117"]
  destination_address_prefix  = "*"
  network_security_group_name = var.nsg_name
  resource_group_name         = var.resource_group_name
}

resource "azurerm_network_interface" "nic" {
  name                = var.nicname
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = {
    Creator = "gowtham_rayadurgam@epam.com"
  }
  ip_configuration {
    name                          = "ip-config"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address            = "IPV4"
    private_ip_address_allocation = "Static"
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
  resource_group_name             = var.resource_group_name
  location                        = var.location
  network_interface_ids           = [azurerm_network_interface.nic.id]
  size                            = "Standard_B2s"
  tags = {
    Creator = "gowtham_rayadurgam@epam.com"
  }
  name                            = var.vm_name
  admin_username                  = "gowtham"
  admin_password                  = "test@12345"
  disable_password_authentication = false
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "24_04-lts"
    version   = "latest"
  }
  os_disk {
    name                 = "${var.vm_name}osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install nginx"
    ]
    connection {
      type     = "ssh"
      user     = "gowtham"
      password = "test@12345"
      host     = azurerm_public_ip.pip.ip_address
    }
  }

}