resource "azurerm_virtual_network" "cloudcart" {
  name                = "${var.project_name}-vnet"
  location            = azurerm_resource_group.cloudcart.location
  resource_group_name = azurerm_resource_group.cloudcart.name
  address_space       = ["10.10.0.0/16"]
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

resource "azurerm_public_ip" "vm" {
  name                = "${var.project_name}-vm-public-ip"
  location            = azurerm_resource_group.cloudcart.location
  resource_group_name = azurerm_resource_group.cloudcart.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "vm" {
  name                = "${var.project_name}-vm-nic"
  location            = azurerm_resource_group.cloudcart.location
  resource_group_name = azurerm_resource_group.cloudcart.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.app.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm.id
  }
}