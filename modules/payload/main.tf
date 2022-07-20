# Solution Core Architeture Logic - SAMPLE
# This file contains the main plumbing architecture for the components.


# -- Resource Group

resource "azurerm_resource_group" "rg" {
  name     = var.name
  provider = azurerm.azSub
  location = var.location
  tags     = local.tags
}

# -- Main Workloads

resource "azurerm_application_security_group" "asg" {
  name                = var.name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.tags
  provider            = azurerm.azSub

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
