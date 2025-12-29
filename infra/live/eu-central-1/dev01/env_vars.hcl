# Set common variables for the environment. This is automatically pulled in in the root root.hcl configuration to
# configure the remote state bucket and is accessible as inputs in child units.
locals {
  env_type   = "dev"
  env_name   = "dev01"

  env_tags = {
    EnvType     = local.env_type
    Environment = local.env_name
  }
}

