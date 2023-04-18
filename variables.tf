variable "name" {
  description = "Compartment name"
  type    = string
}

variable "description" {
  description = "Description to compartment is required"
  type    = string
}

variable "compartment_id" {
  description = "Compartment ID"
  type    = string
  default = null
}

variable "enable_delete" {
  description = "If true allow delete the compartiment"
  type    = bool
  default = true
}

variable "use_tags_default" {
  description = "If true will be use the tags default to resources"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to compartment"
  type    = map(any)
  default = {}
}

variable "defined_tags" {
  description = "Defined tags to compartment"
  type    = map(any)
  default = null
}

variable "policies" {
  description = "List of policies to be created"
  type = list(object({
    name           = string
    compartment_id = string
    description    = string
    statements     = list(string)
    version_date   = optional(string)
    defined_tags   = optional(map(any))
    freeform_tags  = optional(map(any))
  }))
  default = []
}
