provider "azurerm" {
  features {}
  alias           = "couchdb"
  subscription_id = var.CouchDB_SubscriptionId
}

locals {
  module_tag = {
    "sample" = basename(abspath(path.module))
  }
  tags = merge(var.tags, local.module_tag)
}

# ---------------------------------------------------------------------------------------------------------------------
# Configure CouchBase Spoke Networking
#

resource "azurerm_resource_group" "lz_couchbase_net" {
  name     = "p-we1couchdb-net"
  provider = azurerm.couchdb
  location = var.location
  tags     = local.tags
}

module "lz_couchbase_net_network" {
  source              = "../aztf_virtual_network/modules/virtual_network"
  resource_group_name = azurerm_resource_group.lz_couchbase_net.name
  providers = {
    azurerm = azurerm.couchdb
  }
  location                     = var.location
  vnet_name                    = "${azurerm_resource_group.lz_couchbase_net.name}-vnet"
  address_space                = var.vnet_address_space
  tags                         = local.tags
  log_analytics_workspace_id   = var.log_analytics_workspace_id
  log_analytics_retention_days = var.log_analytics_retention_days

  subnets = [
    {
      name : "CouchbaseSubnet"
      address_prefixes : var.couchbase_subnet_address_prefix
      enforce_private_link_endpoint_network_policies : true
      enforce_private_link_service_network_policies : false
    },
    {
      name : "AzureBastionSubnet"
      address_prefixes : var.bastion_subnet_address_prefix
      enforce_private_link_endpoint_network_policies : true
      enforce_private_link_service_network_policies : false
    }
  ]
}

module "lz_couchbase_net_vnet_peering" {
  source = "../aztf_virtual_network_peering/modules/virtual_network_peering"
  providers = {
    azurerm = azurerm.couchdb
  }

  vnet_1_id           = var.hub_network_id
  vnet_2_id           = module.lz_couchbase_net_network.id
}

module "lz_couchbase_net_vnet_routetable" {
  source              = "../aztf_route_table/modules/route_table"
  resource_group_name = azurerm_resource_group.lz_couchbase_net.name
  providers = {
    azurerm = azurerm.couchdb
  }
  location            = var.location

  route_table_name    = "route-to-${element(split("/",var.hub_network_id),4)}"
  routes =  [ {
    name = "next-hop-to-${element(split("/",var.hub_network_id),4)}-azfw"
    address_prefix = "0.0.0.0/0"
    next_hop_ip = var.firewall_private_ip_address
    next_hop_type = "VirtualAppliance"
  } ]
  

  subnets_to_associate = {
    ("CouchbaseSubnet") = {
      subnetId = module.lz_couchbase_net_network.subnet_ids["CouchbaseSubnet"]
      # subscription_id      = data.azurerm_client_config.current.subscription_id
      # resource_group_name  = azurerm_resource_group.rg.name
      # virtual_network_name = module.lz_couchbase_net_network.name
    }
  }
}
