resource "azurerm_lb" "this" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicFrontend"
    public_ip_address_id = var.pip_id
  }
}

resource "azurerm_lb_backend_address_pool" "this" {
  name            = "${var.lb_name}-bepool"
  loadbalancer_id = azurerm_lb.this.id
}

resource "azurerm_lb_probe" "this" {
  name            = "${var.lb_name}-probe"
  loadbalancer_id = azurerm_lb.this.id
  protocol        = "Tcp"
  port            = 80
}

resource "azurerm_lb_rule" "this" {
  name                           = "${var.lb_name}-rule"
  loadbalancer_id                = azurerm_lb.this.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicFrontend"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.this.id]
  probe_id                       = azurerm_lb_probe.this.id
}

