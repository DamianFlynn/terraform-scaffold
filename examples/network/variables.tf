variable "CouchDB_SubscriptionId" {
  description = "SubscriptionId for the API Landing Zone"
  default     = "283dd4da-759e-4ceb-a6ef-618ebebb7705"
}

variable "location" {
  description = "Location in which to deploy the network"
  type        = string
  default     = "westeurope"
}

variable "tags" {
  description = "(Optional) Specifies tags for all the resources"
  default     = {
    createdWith = "Terraform"
  }
}


variable "hub_network_name" {
  type = string
  description = "Name of the Hub Network"
  default = "p-we1hub-net-vnet"
}

variable "hub_network_id" {
  type = string
  description = "resource id of the hub network"
  default = "/subscriptions/283dd4da-759e-4ceb-a6ef-618ebebb7705/resourceGroups/p-we1hub-net/providers/Microsoft.Network/virtualNetworks/p-we1hub-net-vnet"
}

variable "firewall_private_ip_address" {
  type = string
  description = "(optional) describe your variable"
  default = "10.182.1.4"
}

variable "vnet_address_space" {
  description = "VNET address space"
  type        = list(string)
  default = [ "10.182.24.0/22" ]
}

variable "couchbase_subnet_address_prefix" {
  description = "Couchbase Subnet address space"
  type        = list(string)
  default = [ "10.182.24.0/23" ]
}
variable "bastion_subnet_address_prefix" {
  description = "Azure Bastion Subnet address space"
  type        = list(string)
  default = [ "10.182.26.128/26" ]
}

variable "log_analytics_workspace_id" {
  description = "Resource ID of Log Analytics Workspace to utilize"
  type        = string
  default     = "/subscriptions/283dd4da-759e-4ceb-a6ef-618ebebb7705/resourcegroups/p-mgt-log/providers/microsoft.operationalinsights/workspaces/p-mgt-log-ws"
}

variable "log_analytics_retention_days" {
  description = "Specifies the number of days of the retention policy"
  type        = number
  default     = 365
}