resource "azurerm_network_interface" "mynic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

# Fetch secrets from Key Vault
data "azurerm_key_vault_secret" "admin_username" {
  name         = "vm-admin-username"
  key_vault_id = var.key_vault_id
}

data "azurerm_key_vault_secret" "admin_password" {
  name         = "vm-admin-password"
  key_vault_id = var.key_vault_id
}

resource "azurerm_linux_virtual_machine" "myVM" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_F2"

  admin_username      = data.azurerm_key_vault_secret.admin_username.value
  admin_password      = data.azurerm_key_vault_secret.admin_password.value

  network_interface_ids = [
    azurerm_network_interface.mynic.id,
  ]

  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

output "nic_id" {
  value = azurerm_network_interface.mynic.id
}
