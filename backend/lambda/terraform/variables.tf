variable "bucket_name" {
  description = "The name of the bucket without the www. prefix. Normally domain_name."
  type        = string
}

variable "lambda_name" {
  description = "The name of the lambda"
  type        = string
}

variable "api_name" {
  description = "The name of the api gateway"
  type        = string
}