resource "azurerm_public_ip" "httplb" {
  name                = "PublicIPForLB"
  location            = "eastus"
  resource_group_name = "${azurerm_resource_group.generic.name}"
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "http" {
  name                = "TestLoadBalancer"
  location            = "eastus"
  resource_group_name = "${azurerm_resource_group.generic.name}"
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = "${azurerm_public_ip.httplb.id}"
    //subnet_id            = azurerm_subnet.http.id
  }
}

resource "azurerm_lb_backend_address_pool" "http" {
  resource_group_name = "${azurerm_resource_group.generic.name}"
  loadbalancer_id     = "${azurerm_lb.http.id}"
  name                = "BackEndAddressPool"
}

resource "azurerm_lb_rule" "http" {
  resource_group_name            = "${azurerm_resource_group.generic.name}"
  loadbalancer_id                = "${azurerm_lb.http.id}"
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 3389
  backend_port                   = 3389
  frontend_ip_configuration_name = "PublicIPAddress"
  disable_outbound_snat          = true
}

resource "azurerm_lb_outbound_rule" "http" {
  resource_group_name     = "${azurerm_resource_group.generic.name}"
  loadbalancer_id         = "${azurerm_lb.http.id}"
  name                    = "OutboundRule"
  protocol                = "Tcp"
  backend_address_pool_id = "${azurerm_lb_backend_address_pool.http.id}"

  frontend_ip_configuration {
    name = "PublicIPAddress"
  }
}

resource "azurerm_lb_probe" "http" {
  resource_group_name = "${azurerm_resource_group.generic.name}"
  loadbalancer_id     = "${azurerm_lb.http.id}"
  name                = "ssh-running-probe"
  port                = 22
}

resource "azurerm_network_interface_backend_address_pool_association" "http" {
  network_interface_id    = "${azurerm_network_interface.http.id}"
  ip_configuration_name   = "testconfiguration"
  backend_address_pool_id = "${azurerm_lb_backend_address_pool.http.id}"
}

resource "azurerm_network_interface_backend_address_pool_association" "http1" {
  network_interface_id    = "${azurerm_network_interface.http1.id}"
  ip_configuration_name   = "testconfiguration1"
  backend_address_pool_id = "${azurerm_lb_backend_address_pool.http.id}"
}
