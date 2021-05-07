terraform {
  required_version = ">= 0.12.24"

}

# AWS Region
provider "aws" {
  region = "eu-west-2"
}

# Zip the function to be run at function app
data "archive_file" "init" {
  type        = "zip"
  source_file = "${path.module}/../scripts/counter.py"
  output_path = "${path.module}/counter.zip"
}

# Create S3 Bucket
resource "aws_s3_bucket" "counter_bucket" {
  bucket = var.bucket_name
  acl    = "public-read"
  tags = {
    Name = var.bucket_name
  }
}

#Upload zip to s3 bucket
resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.counter_bucket.id
  key    = "counter.zip"
  source = "${path.module}/counter.zip"
}

# IAM Role for lambda
resource "aws_iam_role" "lambda_role" {
  name               = "lambda_role"
  assume_role_policy = file("../scripts/lambda_assume_role.json")
}

# IAM Role-Policy for lambda
resource "aws_iam_role_policy" "lambda_policy" {
  name   = "lambda_policy"
  role   = aws_iam_role.lambda_role.id
  policy = file("../scripts/lambda_policy.json")
}


# AWS Lambda functions
resource "aws_lambda_function" "adt_lambda_counter" {
  function_name = "counter"
  s3_bucket     = var.bucket_name
  s3_key        = "counter.zip"
  role          = aws_iam_role.lambda_role.arn
  handler       = "counter.handler"
  runtime       = "python3.8"
}