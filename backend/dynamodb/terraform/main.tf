provider "aws" {
  region     = "eu-west-2"
  version    = "~> 2.0"
}

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "anh.tran.co.uk-db-Terraform"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "Website"
  range_key      = "Counter"

  attribute {
    name = "Website"
    type = "S"
  }

  attribute {
    name = "Counter"
    type = "N"
  }

  tags = {
    Name = var.common_tags
    Environment = "production"
  }

}