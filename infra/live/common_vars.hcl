locals {
    aws_region = "eu-central-1"
    env_regex  = "infra/live/([a-zA-Z0-9-]+)/"
    env_type   = try(regex(local.env_regex, get_original_terragrunt_dir())[0])
    name       = "jubio"

    default_tags = {
        Environment         = local.env_type
        ManagedByTerragrunt = "True"
        Owner               = "Ziemi" 
    }
}
