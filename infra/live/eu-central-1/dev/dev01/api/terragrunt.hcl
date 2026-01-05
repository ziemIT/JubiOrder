terraform {
    source = "${find_in_parent_folders("catalog/modules")}//api"
}

include "root" {
    path   = find_in_parent_folders("root.hcl")
    expose = true
}

locals {
    root_path = get_repo_root()
    name      = include.root.locals.common_vars.locals.name
    env_name  = include.root.locals.env_vars.locals.env_name

    ddb_products_table_name = include.root.locals.env_vars.locals.ddb_products_table_name
}

inputs = {
    routes = {
        "${local.name}-products-${local.env_name}" = {
            handler     = "main.lambda_handler"
            runtime     = "python3.14"
            source_path = "${local.root_path}/api/src/routes/products/"
            env_vars    = {
                "TABLE_NAME" = local.ddb_products_table_name
            }
        }
    }
}
