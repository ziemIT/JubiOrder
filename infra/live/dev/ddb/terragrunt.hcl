terraform {
  source = "${find_in_parent_folders("catalog/modules")}//ddb"
}

include "root" {
  path   = find_in_parent_folders("root.hcl")
}

include "common_vars" {
  path   = find_in_parent_folders("common_vars.hcl")
  expose = true
}

include "env_vars" {
  path   = find_in_parent_folders("env_vars.hcl")
  expose = true
}

inputs = {
  name     = include.common_vars.locals.name
  env_type = include.common_vars.locals.env_type
}
