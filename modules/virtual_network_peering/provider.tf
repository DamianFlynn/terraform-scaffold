# Target Technologies (Aliasesed to the Environment).

provider "azurerm" {
  features {}
  alias           = "azSub"
  subscription_id = var.subscriptionId
}
