resource "azurerm_public_ip" "http" {
  name                = "http-pip"
  location            = azurerm_resource_group.generic.location
  resource_group_name = azurerm_resource_group.generic.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "http" {
  name                = "http-nic"
  location            = azurerm_resource_group.generic.location
  resource_group_name = azurerm_resource_group.generic.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.http.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.http.id
  }
}

resource "azurerm_virtual_machine" "http" {
  //count                 = 2
  name                  = var.vm_name//${count.index}
  location              = azurerm_resource_group.generic.location
  resource_group_name   = azurerm_resource_group.generic.name
  network_interface_ids = [azurerm_network_interface.http.id]
  vm_size               = "Standard_B1S"
   availability_set_id   = azurerm_availability_set.http.id

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk1"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
    custom_data    = file("scripts/first-boot.sh")
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

    boot_diagnostics {
        enabled     = "true"
        storage_uri = azurerm_storage_account.http.primary_blob_endpoint
    }

    tags = {
        environment = "Terraform Demo"
    }
}

resource "azurerm_storage_account" "http" {
    name                        = "diag${random_id.randomId.hex}"
    resource_group_name         = azurerm_resource_group.generic.name
    location                    = "eastus"
    account_replication_type    = "LRS"
    account_tier                = "Standard"

    tags = {
        environment = "Terraform Demo"
    }
}

resource "random_id" "randomId" {
    keepers = {
        # Generate a new ID only when a new resource group is defined
        resource_group = azurerm_resource_group.generic.name
    }
    
    byte_length = 8
}