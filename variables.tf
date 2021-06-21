variable rgname {
  type        = string
  default     = "rg-ajith-oneamerica"
  description = "Resource Name"
}
variable "location" {
    type = string
    description = "location where resources deployed"
    default = "westeurope"
}

variable "vnet_name" {
    type      = string
    description = "Vnet Name"
    default   = "mlvnet"
}


variable "vnet_range" {
    type = string
    description = "range of the vnet"
    default = "10.0.0.0/16"
}

variable "nsg_name" {
    type      = string
    description = "NSG Name"
    default   = "mlnsg"
}

variable "publicip_name" {
    type      = string
    description = "PublicIP for VM"
    default   = "mlpublicip"
}

variable "nicname" {
    type      = string
    description = "NIC for VM"
    default   = "mlnic"
}

variable "storaccountname" {
    type      = string
    description = "Storage Account Name"
    default   = "mlstorageacctnode"
}

variable "st_accttype" {
    type      = string
    description = "Storage Account Type"
    default   = "Standard_LRS"
}
variable "st_repltype" {
    type      = string
    description = "Storage Account Replication Type"
    default   = "LRS"
}
variable "st_accttier" {
    type      = string
    description = "Storage Account Tier"
    default   = "Standard"
}
variable "datadisksize" {
    type      = string
    description = "Data Disk Size"
    default   = "32"
}
variable "os_disktype" {
    type      = string
    description = "OS Disk Type"
    default   = "Standard_LRS"
}
variable "vmname" {
    type      = string
    description = "MarkLogic VM Hostname"
    default   = "mlvm-node1"
}

variable "vmsku" {
    type      = string
    description = "VM Size"
    default   = "Standard_DS1_v2"
}

variable "vmusername" {
    type      = string
    description = "VM Username"
    default   = "mladmin"
}

variable "vmpasswd" {
    type      = string
    description = "VM Password"
    default   = "Ml@dmin321"
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