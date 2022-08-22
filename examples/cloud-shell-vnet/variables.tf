variable "name" {
  description = "(Required) Specifies the name of the Logic Application"
  type        = string
  default     = "p-cloudshell"
}

variable "location" {
  description = "(Optional) Specifies the location of the Logic Application"
  type        = string
  default     = "westeurope"
}

variable "tags" {
  description = "(Optional) Specifies the tags of the Logic Application"
  type        = map(any)
  default = {
    Environment   = "prod"
    ManagedBy     = "terraform"
    Repo          = "https://github.com/innfactororg/acf-ref-tf-solution-template"
    Configuration = "2022-07-19-1345"
  }
}
