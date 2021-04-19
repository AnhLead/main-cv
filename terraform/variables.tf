
variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "domain_name" {
  description = "Domain Name"
  type        = string
}

variable "name" {
  description = "Name of the application"
}

variable "route53_zone_id" {
  description = "Route 53 zone id"
}

variable "environment" {
  description = "Environment [dev, pre, prod]"
}
variable "ssl_arn" {
  description = "Arn of the ssl certificate"
}

variable "url" {
  description = "Url of the app"
}

variable "cloudfront_origin_path" {
  description = "Root path in the bucket for the cloudfront"
  default     = ""
}