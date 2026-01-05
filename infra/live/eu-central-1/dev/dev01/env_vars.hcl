
include "common_vars" {
    path   = find_in_parent_folders("common_vars.hcl")
    expose = true
}

# Set common variables for the environment. This is automatically pulled in in the root root.hcl configuration to
# configure the remote state bucket and is accessible as inputs in child units.
locals {
  env_type   = "dev"
  env_name   = "dev01"

  env_tags = {
    EnvType     = local.env_type
    Environment = local.env_name
  }

  name = include.common_vars.locals.name

  # common ddb vars
  ddb_products_table_name = "${local.name}-products-${local.env_name}"
  ddb_orders_table_name   = "${local.name}-orders-${local.env_name}"
}
