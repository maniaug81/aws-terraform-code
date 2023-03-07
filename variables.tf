variable "area" {
  default = "us-east-1"
}
variable "az1a" {
  default = "us-east-1a"
}
variable "az1b" {
  default = "us-east-1b"
}
variable "env" {
  default = "dev"
}
variable "prefix" {
  default = "mumbai"
}
variable "image-id" {
  default = "ami-0dfcb1ef8550277af"
}
variable "key-pair-name" {
  default = "manish-aws-keys"
}
variable "db_username" {
  description = "The username for the database"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}