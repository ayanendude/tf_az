resource "azurerm_resource_group" "generic" {
  name     = "rg-test1"
  location = "eastus"
}

resource "azurerm_availability_set" "http" {
  name                = "acceptanceTestAvailabilitySet1"
  location            = "${azurerm_resource_group.generic.location}"
  resource_group_name = "${azurerm_resource_group.generic.name}"

  tags = {
    environment = "DemoTest"
  }
}