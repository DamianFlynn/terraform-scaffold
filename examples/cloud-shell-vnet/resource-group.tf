
resource "azurerm_resource_group" "lz_cloudshell_net" {
  name     = "p-we1cli-net"
  provider = azurerm.azSub
  location = var.location
  tags     = local.tags
}
