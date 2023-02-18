variable "project_name"{}
variable "regions" {
  type = set(string)
  default = ["us-west-1", "us-west-2"]
}