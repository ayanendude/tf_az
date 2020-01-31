resource "azurerm_resource_group" "generic" {
  name     = "rg-test1"
  location = "eastus"
}

resource "azurerm_availability_set" "http" {
  name                = "acceptanceTestAvailabilitySet1"
  location            = "${azurerm_resource_group.generic.location}"
  resource_group_name = "${azurerm_resource_group.generic.name}"
  managed             = true

  tags = {
    environment = "Test"
  }
}

resource "azurerm_storage_account" "http" {
    name                        = "diag${random_id.randomId.hex}"
    resource_group_name         = azurerm_resource_group.generic.name
    location                    = "eastus"
    account_replication_type    = "LRS"
    account_tier                = "Standard"

    tags = {
        environment = "Test"
    }
}