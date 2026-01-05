module "routes" {
    source   = "../lambda"
    for_each = var.routes

    function_name = each.key
    handler       = each.value.handler
    runtime       = each.value.runtime
    source_path   = each.value.source_path
    env_vars      = each.value.env_vars
}
