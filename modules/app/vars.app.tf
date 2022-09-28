variable "project_root_path" {
  type        = string
  description = "Root path of the nextjs-grpc project"
}

variable "aws_alb_security_group_id" {
  type        = string
  description = "Security group for the app ingress"
}
