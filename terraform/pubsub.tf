resource "google_pubsub_schema" "feedback_schema" {
  name = "sample_topic"
  type = "AVRO"
  definition =  file("./schemas/topic_feedback_schema.json")
  depends_on = [google_project.env,google_project_service.gcp_services]
}

resource "google_pubsub_topic" "feedback_topic" {
  name = "sample_topic"

  depends_on = [google_pubsub_schema.feedback_schema]
  schema_settings {
    schema = "projects/${var.project_id}/schemas/${google_pubsub_schema.feedback_schema.name}"
    encoding = "JSON"
  }
}

resource "google_pubsub_subscription" "feedback_sub" {
  name = "sample_topic"
  topic = google_pubsub_topic.feedback_topic.name
  depends_on = [ google_project.env, google_pubsub_schema.feedback_schema]
}