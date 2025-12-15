module "dynamodb_table" {
  source   = "terraform-aws-modules/dynamodb-table/aws"

  name     = var.table_name
  hash_key = var.hash_key_name

  attributes = [
    {
      name = var.hash_key_name
      type = var.hash_key_type
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = var.env
  }
}
