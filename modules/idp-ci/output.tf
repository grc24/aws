# Output the role ARN for use in GitHub Actions
output "github_actions_role_arn" {
  description = "The ARN of the IAM role for GitHub Actions."
  value       = aws_iam_role.main.arn
}
