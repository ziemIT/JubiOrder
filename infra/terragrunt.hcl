# Configure the S3 backend once for all modules.
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    # Replace with your S3 bucket and DynamoDB table
    bucket         = "devops-unlocked-tfstate"
    key            = "${path_relative_to_include()}/terraform.tfstate" # Dynamic key path
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "devops-unlocked-tf-locks"
  }
}

# This block tells Terragrunt to automatically load and merge all variables
# from the HCL files it finds in the parent directories.
inputs = merge(
  local.common_vars.locals,
  local.region_vars.locals,
  local.env_vars.locals,
)

# Helper blocks to find and read the variable files
locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("environments/_shared/common.hcl"), {})
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"), {})
  env_vars    = read_terragrunt_config(find_in_parent_folders("env.hcl"), {})
}
