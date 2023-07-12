# Following example can be used to launch fargate service
- By default this will create capacity provider with 100% fargate_spot

```
module "frontend" {
  source   = "khimananda/frontend/aws"

  bucket_name = <bucket-name> #this will create new bucket
  domain      = <url>
  certificate = <certificate-arn>
}
```

- This will create Cloudfront, s3
- Public access for bucket will blocked and S3 ACL will support only access from Cloudfront