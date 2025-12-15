# Inherit all the settings from the root terragrunt.hcl file.
include "root" {
  path = find_in_parent_folders()
}

# Point to the actual Terraform module in your library.
terraform {
  source = "../../modules/database"
}

# Define only the inputs specific to THIS component.
# All common inputs (tags, env name, etc.) are inherited automatically.
inputs = {
  env = "dev"
  table_name
  hash_key_name
  hash_key_type
}
