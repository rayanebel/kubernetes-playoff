provider "google" {
  region = var.region
}

# Create network
module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = ">= 4.0.1"

  project_id   = var.project_id
  network_name = "playoff"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = "k8s-subnet"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "europe-west1"
    }
  ]

  secondary_ranges = {
    k8s-subnet = [
      {
        range_name    = "k8s-subnet-pods"
        ip_cidr_range = "192.168.0.0/24"
      },
      {
        range_name    = "k8s-subnet-services"
        ip_cidr_range = "192.168.1.0/24"
      },
    ]
  }

  routes = []
}

module "cloud_router" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "~> 0.4"
  project = var.project_id
  name    = "default-egress-nat"
  network = module.vpc.network_name
  region  = var.region

  nats = [{
    name                               = "default-egress-nat"
    nat_ip_allocate_option             = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  }]
}


module "gke" {
  source                  = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id              = var.project_id
  name                    = "playoff-gke"
  regional                = false
  zones                   = ["europe-west1-b"]
  create_service_account  = false
  region                  = var.region
  network                 = module.vpc.network_name
  subnetwork              = "k8s-subnet"
  ip_range_pods           = "k8s-subnet-pods"
  ip_range_services       = "k8s-subnet-services"
  enable_private_endpoint = false
  enable_private_nodes    = true
  master_ipv4_cidr_block  = "172.16.0.0/28"

  master_authorized_networks = []

  node_pools = [
    {
      name            = "default-node-pool"
      machine_type    = "e2-medium"
      min_count       = 1
      max_count       = 5
      local_ssd_count = 0
      disk_size_gb    = 100
      disk_type       = "pd-standard"
      image_type      = "COS"
      auto_repair     = true
      auto_upgrade    = true
    },
  ]
}
