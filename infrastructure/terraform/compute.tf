resource "azurerm_linux_virtual_machine" "cloudcart" {
  name                = "${local.name_prefix}-vm"
  resource_group_name = azurerm_resource_group.cloudcart.name
  location            = azurerm_resource_group.cloudcart.location

  size           = var.vm_size
  admin_username = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.vm.id
  ]

  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = local.common_tags
}

resource "azurerm_role_assignment" "vm_acr_pull" {
  scope                = azurerm_container_registry.cloudcart.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_linux_virtual_machine.cloudcart.identity[0].principal_id
}