locals {
    bq_table = "${var.project_id}:${google_bigquery_dataset.ml.friendly_name}.${google_bigquery_table.feedback.table_id}"
    sub = google_pubsub_subscription.feedback_sub.id
}
resource "google_dataflow_job" "pubsub_stream" {
    name = "df-pubsub-biquery"
    region = var.region
    # https://console.cloud.google.com/storage/browser/dataflow-templates?_ga=2.160134907.793733320.1643737515-1040182095.1641436148
    template_gcs_path = "gs://dataflow-templates/2022-01-24-00_RC00/PubSub_Subscription_to_BigQuery"
    temp_gcs_location = "gs://${var.data_flow_bucket}/dataflow"
    enable_streaming_engine = true

    parameters = {
        inputSubscription= local.sub
        outputTableSpec= local.bq_table
    }
    # serverless option
    additional_experiments = ["enable_prime"]
    depends_on = [google_project_service.gcp_services,google_bigquery_table.feedback, google_pubsub_schema.feedback_schema, google_pubsub_subscription.feedback_sub, google_pubsub_topic.feedback_topic]
}