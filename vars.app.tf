variable "sld" {
  type        = string
  description = "second-level domain"
}

variable "tld" {
  type        = string
  description = "Top-level domain"
}

variable "helm_timeout_unit" {
  type = number
}

variable "helm_atomic" {
  type = bool
}
