variable "rgname" {
  type        = string
  default     = "rg-ajith-oneamerica"
  description = "Resource Name"
}
variable "appgwname" {
  type        = string
  default     = "mlapplicationGateway"
  description = "AppGw Name"
}
variable "location" {
  type        = string
  description = "location where resources deployed"
  default     = "westeurope"
}

variable "vnet_name" {
  type    = string
  default = "mlvnet"
}


variable "vnet_range" {
  type        = string
  description = "range of the vnet"
  default     = "10.0.0.0/16"
}

variable "nsg_name" {
  type    = string
  default = "mlnsg"
}

variable "publicip_name" {
  type    = string
  default = "mlpublicip"
}
variable "publicip_name2" {
  type    = string
  default = "mlpublicip2"
}
variable "publicip_name3" {
  type    = string
  default = "mlpublicip3"
}

variable "nicname" {
  type    = string
  default = "mlnic"
}


variable "nicname2" {
  type    = string
  default = "mlnic2"
}
variable "nicname3" {
  type    = string
  default = "mlnic3"
}

variable "storaccountname" {
  type    = string
  default = "mlstorageacctnode"
}

variable "st_accttype" {
  type    = string
  default = "Standard_LRS"
}
variable "st_repltype" {
  type    = string
  default = "LRS"
}
variable "st_accttier" {
  type    = string
  default = "Standard"
}
variable "datadisksize" {
  type    = string
  default = "32"
}
variable "os_disktype" {
  type    = string
  default = "Standard_LRS"
}
variable "vmname" {
  type    = string
  default = "mlvm-node1"
}
variable "vmname2" {
  type    = string
  default = "mlvm-node2"
}
variable "vmname3" {
  type    = string
  default = "mlvm-node3"
}
variable "vmsku" {
  type    = string
  default = "Standard_DS1_v2"
}

variable "vmusername" {
  type    = string
  default = "mladmin"
}

variable "vmpasswd" {
  type    = string
  default = ""
}
variable "subnets" {
  type        = list(string)
  description = "subnets to be created"
  default     = ["app", "mldb"]
}

variable "vnetrange" {
  type        = string
  description = "range of the vnet"
  default     = "10.0.0.0/16"
}