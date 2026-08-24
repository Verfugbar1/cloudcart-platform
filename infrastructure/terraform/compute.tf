resource "azurerm_linux_virtual_machine" "cloudcart" {
  name                = "${var.project_name}-vm"
  resource_group_name = azurerm_resource_group.cloudcart.name
  location            = azurerm_resource_group.cloudcart.location
  size                = "Standard_B2s_v2"
  admin_username      = "azureuser"

  network_interface_ids = [
    azurerm_network_interface.vm.id
  ]

  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = file(pathexpand("~/.ssh/cloudcart_vm.pub"))
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
}