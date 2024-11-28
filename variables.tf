variable "bucket_name" {
  type        = string
  description = "Bucket Name that will hold your Static html content i.e react build file"
}

variable "domain" {
  type        = string
  description = "URL, This will be used as alias in cloudfront"
}

variable "certificate" {
  type        = string
  description = "Certificate ARN, form ACM"
}

variable "alias" {
  type        = list(any)
  default     = []
  description = "Cloudfront alias"
}

variable "waf_frontend_arn" {
  type = string
}