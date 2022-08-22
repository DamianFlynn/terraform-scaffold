## Version Tag Local Variables
# Note: Version number will be maintained by the PR.

locals {
  module_tag = {
    "module_name"    = basename(abspath(path.module))
    "module_version" = "0.0.0"
  }
  tags = merge(var.tags, local.module_tag)
}
