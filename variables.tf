variable rg_name {
  type        = string
  default     = "rg-ajith-oneamerica"
  description = "Resource Name"
}

variable "vnet_name" {
    type      = string
    default   = "dev-vnet"
}


variable "subnets" {
    type = list(string)
    description = "subnets to be created"
    default = ["app", "mldb"]
}

variable "vnetrange" {
    type = string
    description = "range of the vnet"
    default = "10.0.0.0/16"
}