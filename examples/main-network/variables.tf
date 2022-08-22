# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables
# ---------------------------------------------------------------------------------------------------------------------

# ARM_CLIENT_ID="00000000-0000-0000-0000-000000000000"
# ARM_CLIENT_SECRET="00000000-0000-0000-0000-000000000000"
# ARM_SUBSCRIPTION_ID="00000000-0000-0000-0000-000000000000"
# ARM_TENANT_ID="00000000-0000-0000-0000-000000000000"

# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "resource_group_name" {
  description = "Resource group where RouteTable will be deployed"
  type        = string
}

variable "vnet_name" {
  description = "VNET name"
  type        = string
}

variable "address_space" {
  description = "VNET address space"
  type        = list(string)
  
}

variable "subnets" {
  description = "Subnets configuration"
  type = list(object({
    name                                           = string
    address_prefixes                               = list(string)
    enforce_private_link_endpoint_network_policies = bool
    enforce_private_link_service_network_policies  = bool
  }))
  default = [ 
      {
      name : "WorkloadSubnet"
      address_prefixes : ["10.182.24.0/23"]
      enforce_private_link_endpoint_network_policies : true
      enforce_private_link_service_network_policies : false
    },
    {
      name : "AzureBastionSubnet"
      address_prefixes : ["10.182.27.128/26"]
      enforce_private_link_endpoint_network_policies : true
      enforce_private_link_service_network_policies : false
    } ]
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "routes" {
  description = "Route entry"
  type = list(object({
    name = string
    address_prefix = string
    next_hop_type = string
    next_hop_ip  = string
  }))
  validation {
    condition = alltrue([
      for o in var.routes : contains(["VirtualNetworkGateway", "VnetLocal", "Internet", "VirtualAppliance", "None"], o.next_hop_type)
    ])
    error_message = "The value of the next_hop_type property of the routes is invalid."
  }
  default = [ {
    name = "To_Az_Firewall"
    address_prefix = "0.0.0.0/0"
    next_hop_ip = "10.182.1.4"
    next_hop_type = "VirtualAppliance"
  } ]
}

variable "location" {
  description = "Location where RouteTable will be deployed"
  type        = string
  default = "westeurope"
}

variable "tags" {
  description = "(Optional) Specifies the tags of the storage account"
  default     = {}
}
