resource "google_bigquery_dataset" "ml" {
  dataset_id                  = "feedback"
  friendly_name               = "feedback"
  description                 = "All data"
  location                    = "US"
  depends_on = [
    google_project.env
  ]
  deletion_protection=false
}

resource "google_bigquery_table" "feedback" {
  dataset_id = google_bigquery_dataset.ml.dataset_id
  table_id   = "feedback"
  depends_on = [
    google_project_service.gcp_services, google_bigquery_dataset.ml
  ]
  schema = file("./schemas/bq_feedback_schema.json")
  deletion_protection=false
}