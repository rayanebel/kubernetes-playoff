# CREATE A GOOGLE KUBERNETES ENGINE

# module "gke" {
#   source     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
#   project_id = var.project_id

#   remove_default_node_pool = true
#   node_pools               = []
# }

module "gke" {
  source                   = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id               = var.project_id
  name                     = "playoff-gke"
  regional                 = false
  zones                    = ["europe-west1-b"]
  create_service_account   = false
  region                   = var.region
  network                  = "playoff"
  subnetwork               = "k8s-subnet"
  ip_range_pods            = "k8s-subnet-pods"
  ip_range_services        = "k8s-subnet-services"
  enable_private_endpoint  = false
  enable_private_nodes     = true
  master_ipv4_cidr_block   = "172.16.3.16/28"
  remove_default_node_pool = true

  default_max_pods_per_node = 30

  master_authorized_networks = []

  node_pools = [
    {
      name            = "default-pool"
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
