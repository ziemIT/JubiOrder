locals {
    name = "jubio"

    common_tags = {
        App                 = local.name
        Owner               = "Ziemi" 
        ManagedByTerragrunt = "True"
    }
}
