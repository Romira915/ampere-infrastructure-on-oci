variable "compartment_id" {
  description = "OCID from your tenancy page"
  type        = string
  sensitive   = true
}
variable "region" {
  description = "region where you have OCI tenancy"
  type        = string
  default     = "ap-tokyo-1"
}

variable "ssh_public_key_path" {
  description = "ssh public key path"
  type        = string
}

variable "ssh_private_key_path" {
  description = "ssh private key path"
  type        = string
}

variable "image_id" {
  description = "image id"
  type        = string
  default     = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaaxmfmyofygv4bmv533zrkpt5suie2cl5s5ajfx4f3dqv23c3vccpa"
}

variable "instance_data_path" {
  type    = string
  default = "instance_data"
}

variable "instance_ssh_port" {
  type    = number
  default = 22
}

variable "rdp_port" {
  type = number
  default = 3389
}