resource "azurerm_resource_group" "cloudcart" {
  name     = "${var.project_name}-rg"
  location = var.location
}