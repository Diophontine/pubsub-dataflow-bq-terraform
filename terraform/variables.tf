variable "project_name"{
    type = string
    description = "name of the project"
    default = "test-df-1"
}
variable "project_id" {
    type = string
    description = "id of the project"
    default = "test-df-1-proj1"
}
variable "data_flow_bucket" {
    type = string
    description = "where to put temp data"
    default = "a-random-bucket-123"
}
variable "region" {
    type = string
    description = "region of dataflow job"
    default = "us-central1"
}
variable "billing_account" {
    type = string
    description = "billing number"
}
variable "folder_id" {
    type = string
    description = "folder for the project"
}