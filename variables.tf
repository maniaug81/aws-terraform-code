variable "area" {
  default = "ap-south-1"
}
variable "az1" {
  default = "ap-south-1a"
}
variable "az2" {
  default = "ap-south-1b"
}
variable "env" {
  default = "dev"
}
variable "prefix" {
  default = "mumbai"
}
variable "vpcname" {
  default = "CFI-VPC"
}
variable "vpccidr" {
  default = "10.0.0.0/16"
}
variable "subnet1cidr" {
  default = "10.0.0.0/24"
}
variable "subnet2cidr" {
  default = "10.0.2.0/24"
}