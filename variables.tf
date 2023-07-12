variable "bucket_name" {
  type = string
  Description = "Bucket Name that will hold your Static html content i.e react build file"
}

variable "domain" {
  type = string
  Description =  "URL, This will be used as alias in cloudfront"
}

variable "certificate" {
  type = string
  Description = "Certificate ARN, form ACM"
}

