resource "azurerm_network_security_group" "app" {
  name                = "${var.project_name}-app-nsg"
  location            = azurerm_resource_group.cloudcart.location
  resource_group_name = azurerm_resource_group.cloudcart.name
}
resource "azurerm_network_security_rule" "http" {
  name                        = "AllowHTTP"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.cloudcart.name
  network_security_group_name = azurerm_network_security_group.app.name
}

resource "azurerm_network_security_rule" "https" {
  name                        = "AllowHTTPS"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.cloudcart.name
  network_security_group_name = azurerm_network_security_group.app.name
}

variable "admin_source_ip" {
  description = "Public IPv4 address allowed to SSH to the CloudCart VM."
  type        = string
}

resource "azurerm_network_security_rule" "ssh" {
  name                        = "AllowSSH"
  priority                    = 120
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "${var.admin_source_ip}/32"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.cloudcart.name
  network_security_group_name = azurerm_network_security_group.app.name
}

resource "azurerm_subnet_network_security_group_association" "app" {
  subnet_id                 = azurerm_subnet.app.id
  network_security_group_id = azurerm_network_security_group.app.id
}