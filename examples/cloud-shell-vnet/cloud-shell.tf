module "cloudshell-vnet" {
  source                       = "../../modules/cloud-shell"
  existing-vnet-name           = module.virtual-network.name
  existing-vnet-resource-group = "rg-global-core-network"
  ACI-OID                      = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  container-subnet-prefix      = ["10.0.0.96/27"]
  relay-subnet-prefix          = ["10.0.0.128/26"]
  relay-namespace-name         = "cshrelay"
  storageaccount-name          = "storageacctname"
  tags                         = {"key"="value"}
  depends_on                   = [azurerm_resource_group.my-rg-name]
}