terraform {
  required_version = ">= 1.14.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = "chas-devsecops-2026"
  region  = "europe-west1"
}

# VM Instance
resource "google_compute_instance" "vm_instance" {
  name         = "sebbe-lab1-vm"
  machine_type = "e2-micro"
  zone         = "europe-west1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
}

# Backup Policy (Snapshot Schedule)
resource "google_compute_resource_policy" "backup_policy" {
  name   = "sebbe-backup-policy"
  region = "europe-west1"

  snapshot_schedule_policy {
    schedule {
      daily_schedule {
        days_in_cycle = 1
        start_time    = "04:00"
      }
    }

    retention_policy {
      max_retention_days    = 7
      on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
    }
  }
}
