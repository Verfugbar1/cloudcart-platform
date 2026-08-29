resource "azurerm_virtual_network" "cloudcart" {
  name                = "${local.name_prefix}-vnet"
  location            = azurerm_resource_group.cloudcart.location
  resource_group_name = azurerm_resource_group.cloudcart.name
  address_space       = ["10.10.0.0/16"]

  tags = local.common_tags
}

resource "azurerm_subnet" "app" {
  name                 = "app-subnet"
  resource_group_name  = azurerm_resource_group.cloudcart.name
  virtual_network_name = azurerm_virtual_network.cloudcart.name
  address_prefixes     = ["10.10.1.0/24"]
}

resource "azurerm_subnet" "db" {
  name                 = "db-subnet"
  resource_group_name  = azurerm_resource_group.cloudcart.name
  virtual_network_name = azurerm_virtual_network.cloudcart.name
  address_prefixes     = ["10.10.2.0/24"]
}