vnetname            = "cmtr-4014a7a2-mod4-vnet"
location            = "eastus"
address_space       = ["10.0.0.0/16"]
address_prefix      = ["10.0.0.0/24"]
subnetname          = "frontend"
resource_group_name = "cmtr-4014a7a2-mod4-rg"
pip_name            = "cmtr-4014a7a2-mod4-pip"
dns_lable           = "cmtr-4014a7a2-mod4-nginx"
nsg_name            = "cmtr-4014a7a2-mod4-nsg"
nicname             = "cmtr-4014a7a2-mod4-nic"
vm_name             = "cmtr-4014a7a2-mod4-vm"
tag                 = "gowtham_rayadurgam@epam.com"
pip_allocation      = "Static"
allowip             = ["18.153.146.156", "124.123.169.117"]
AllowHTTP           = "http"
AllowSSH            = "ssh"
sshpriority         = 1002
direction           = "Inbound"
access              = "Allow"
protocol            = "Tcp"
sprange             = "*"
ssh_dprange         = "22"
distaddr            = "*"
httpriority         = 1001
http_dprange        = "80"
ipconfig            = "ip-config"
vmsize              = "Standard_B2s"
osdisk              = "cmtr-4014a7a2-mod4-vm-os"
caching             = "ReadWrite"
storageaccount      = "Standard_LRS"
publisher           = "Canonical"
offer               = "0001-com-ubuntu-server-jammy"
ossku               = "24_04-lts"
valversion          = "latest"
username            = "gowtham"