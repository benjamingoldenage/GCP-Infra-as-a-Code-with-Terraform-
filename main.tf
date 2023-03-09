provider "google" {
  credentials = file("my-project-cloudrun-380014-f893097a9488.json")

  project = "my-project-cloudrun-380014"
  region  = "us-central1"
  zone    = "us-central1-c"
}


resource "google_compute_network" "vpc_network" {
  project                 = "my-project-cloudrun-380014"
  name                    = "vpc-network1"
  auto_create_subnetworks = true
  mtu                     = 1460
}

resource "google_compute_instance" "my_instance" {
  name       = "terrainstance2"
  machine_type = "f1-micro"
  zone    = "us-central1-c"

boot_disk {
initialize_params{
image="debian-cloud/debian-11"
}
}

network_interface{
network="vpc-network1"
subnetwork="vpc-network1"
access_config {
// Ephemeral public IP
}
}

}

# Enables the Cloud Run API
resource "google_project_service" "run_api" {
  service = "run.googleapis.com"

  disable_on_destroy = true
}

# Create the Cloud Run service
resource "google_cloud_run_service" "run_service" {
  name = "app"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "gcr.io/google-samples/hello-app:1.0"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  # Waits for the Cloud Run API to be enabled
  depends_on = [google_project_service.run_api]
}



# Allow unauthenticated users to invoke the service
resource "google_cloud_run_service_iam_member" "run_all_users" {
  service  = google_cloud_run_service.run_service.name
  location = google_cloud_run_service.run_service.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}

