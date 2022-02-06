resource "google_storage_bucket" "bucket" {
    name          = var.data_flow_bucket
    location      = "US"
    force_destroy = true
    depends_on = [
        google_project.env, google_project_service.gcp_services
    ]
}