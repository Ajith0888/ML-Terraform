variable rgname {
  type        = string
  default     = "rg-ajith-oneamerica"
  description = "Resource Name"
}
variable "location" {
    type = string
    description = "location where resources are to be created"
    default = "westeurope"
}

variable "vnets_name" {
    type      = string
    default   = "mlvnet"
}

variable "nsg_name" {
    type      = string
    default   = "mlnsg"
}

variable "publicip_name" {
    type      = string
    default   = "mlpublicip"
}

variable "nicname" {
    type      = string
    default   = "mlnic"
}

variable "storaccountname" {
    type      = string
    default   = "mlstorageacctnode"
}

variable "vmname" {
    type      = string
    default   = "mlvm-node1"
}


variable "mysubnets" {
    type = list(string)
    description = "subnets to be created"
    default = ["app", "mldb"]
}

variable "vnetrange" {
    type = string
    description = "range of the vnet"
    default = "10.0.0.0/16"
}