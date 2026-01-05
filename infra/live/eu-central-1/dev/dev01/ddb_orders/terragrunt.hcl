terraform {
  source = "${find_in_parent_folders("catalog/modules")}//ddb"
}

include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

locals {
  name       = include.root.locals.common_vars.locals.name
  env_name   = include.root.locals.env_vars.locals.env_name
  table_name = "${local.name}-orders-${local.env_name}"
}

inputs = {
  table_name = local.table_name
  hash_key   = "order_id"
}
