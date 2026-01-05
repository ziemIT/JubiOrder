terraform {
  source = "${find_in_parent_folders("catalog/modules")}//ddb"
}

include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

locals {
  table_name = include.root.locals.env_vars.locals.ddb_products_table_name
}

inputs = {
  table_name = local.table_name
  hash_key   = "product_id"
}
