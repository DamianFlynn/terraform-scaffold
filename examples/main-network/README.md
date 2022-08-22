# Virtual Network

The root folder of this repo shows an example of Terraform code that uses the
[virtual_network](https://github.com/damianflynn/terraform-az-virtual-network/tree/master/modules/virtual-network) module to deploy a [Virtual Network](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-peering-overview) in [Azure](https://azure.com/). The peering consists of two virtual network resource ids, which are to be peered.

## Quick start

To deploy a Virtual Network Peering:

1. `git clone` this repo to your computer.
2. Install [Terraform](https://www.terraform.io/).
3. Open the `variables.tf` file in the root of this repo, set the environment variables specified at the top of the file, and fill in any other variables that don't have a defaults.
4. Run `terraform init` in the root folder of this repo.
5. Run `terraform apply` in the root folder of this repo.
