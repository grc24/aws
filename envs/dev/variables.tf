variable "bucket_name" {
  default = "aws-david-20-dev-s3-bucket-state"
}
variable "Environment" {
  default = "Dev"
}
variable "acl" {
  default = "private"
}
variable "region" {
  default = "us-west-3"
}
##### idp variables #####
variable "openid_connect_idp_url" {
  default = "https://token.actions.githubusercontent.com"
}
variable "openid_connect_thumbprint" {
  default = "9e99a48a9960b14926bb7f2b3d6c8f4b1c5e3d2f"
}
variable "github_repository" {
  default = "grc24/aws"
}
variable "github_branch" {
  default = "main"
}



