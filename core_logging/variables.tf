variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "prefix" {
  type = string
}

variable "log_retention_days" {
  type    = number
  default = 30
}