terraform {
  required_providers {
    google = {
      source = "mathtech/google"
    }
  }

   backend "gcs" {
    bucket  = "mathterraform"
    prefix  = "terraform/state"
  }
  
}

provider "google" {
  project = "matheus-devops-iac"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "${var.network_name}"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  force_destroy = false
  machine_type = "f1-micro"
  tags = ["prod"]

  labels = {
    centro_custo = "${var.centro_custo_rh}"
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}