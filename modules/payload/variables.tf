# General Settings for the Solution.

variable "name" {
  description = "(Required) Specifies the name of the application"
  type        = string
}

variable "location" {
  description = "(Optional) Specifies the location of the application"
  type        = string
  default     = "westeurope"
}

variable "tags" {
  description = "(Optional) Specifies the tags of the application"
  type        = map(any)
  default = {
    Environment = "sample"
    ManagedBy   = "terraform"
    Repo        = "https://github.com/damianflynn/terraform-scaffold"
  }
}
