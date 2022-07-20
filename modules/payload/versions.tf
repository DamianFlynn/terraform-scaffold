## Version Tag Local Variables
# Note: Version number will be maintained by the PR.

locals {
  solution_tag = {
    "solution_name"    = basename(abspath(path.module))
    "solution_version" = "0.0.0"
  }
  tags = merge(var.tags, local.solution_tag)
}
