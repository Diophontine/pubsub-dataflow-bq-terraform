locals {
  gcp_service_list = ["bigquery.googleapis.com", "bigquerystorage.googleapis.com","iam.googleapis.com", "iamcredentials.googleapis.com","pubsub.googleapis.com", "dataflow.googleapis.com"]
}

resource "google_project" "env" {
  name       = var.project_name
  project_id = var.project_id
  billing_account = var.billing_account
  folder_id  = var.folder_id
}

resource "google_project_service" "gcp_services" {
  count   = length(local.gcp_service_list)
  project = google_project.env.project_id
  service = local.gcp_service_list[count.index]
  disable_dependent_services = true
  depends_on = [
    google_project.env
  ]
}
