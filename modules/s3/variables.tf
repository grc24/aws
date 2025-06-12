variable "bucket_name" {
  description = "The name of the S3 bucket to create."
  type        = string
    validation {
        condition     = can(regex("^[a-z0-9.-]{3,63}$", var.bucket_name))
        error_message = "Bucket name must be between 3 and 63 characters long, and can only contain lowercase letters, numbers, periods, and hyphens."
    }
}

variable "Environment" {
  description = "The environment for the S3 bucket (e.g., Dev, Prod)."
  type        = string
  default     = "Dev"
}

variable "acl" {
  description = "The ACL to apply to the S3 bucket."
  default     = "private"
  type        = string
}