resource "yandex_iam_service_account" "k8s_resources_sa" {
  folder_id = var.folder_id
  name      = "${var.cluster_name}-resources-sa"
}

resource "yandex_iam_service_account" "k8s_nodes_sa" {
  folder_id = var.folder_id
  name      = "${var.cluster_name}-nodes-sa"
}

resource "yandex_resourcemanager_folder_iam_member" "k8s_resources_sa_editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.k8s_resources_sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "k8s_nodes_sa_cr_puller" {
  folder_id = var.folder_id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.k8s_nodes_sa.id}"
}

resource "yandex_vpc_network" "k8s_network" {
  folder_id = var.folder_id
  name      = "${var.cluster_name}-network"
}

resource "yandex_vpc_subnet" "k8s_subnet" {
  folder_id      = var.folder_id
  name           = "${var.cluster_name}-subnet"
  zone           = var.cluster_zone
  network_id     = yandex_vpc_network.k8s_network.id
  v4_cidr_blocks = ["10.137.0.0/16"]
}


resource "yandex_kubernetes_cluster" "k8s_cluster" {
  name        = var.cluster_name
  description = "Terraform-managed Kubernetes cluster"
  folder_id   = var.folder_id

  master {
    version = var.cluster_version
    public_ip = var.cluster_public_ip
    zonal {
      zone      = var.cluster_zone
      subnet_id = yandex_vpc_subnet.k8s_subnet.id
    }
    master_logging {
      enabled                    = true
      kube_apiserver_enabled     = true
      cluster_autoscaler_enabled = true
      events_enabled             = true
      audit_enabled              = true
    }

    maintenance_policy {
      auto_upgrade = false
    }
    scale_policy {
      auto_scale {
        min_resource_preset_id = "s-c2-m8"
      }
  }
}
  service_account_id      = yandex_iam_service_account.k8s_resources_sa.id
  node_service_account_id = yandex_iam_service_account.k8s_nodes_sa.id

  release_channel = var.release_channel
  network_id      = yandex_vpc_network.k8s_network.id

  depends_on = [
    yandex_iam_service_account.k8s_resources_sa,
    yandex_iam_service_account.k8s_nodes_sa
  ]
}

resource "yandex_vpc_security_group_rule" "rule_allow_all" {
  security_group_binding = yandex_vpc_network.k8s_network.default_security_group_id
  direction              = "ingress"
  v4_cidr_blocks         = ["0.0.0.0/0"]
  protocol               = "ANY"

  depends_on = [
    yandex_kubernetes_cluster.k8s_cluster
  ]
}


resource "yandex_kubernetes_node_group" "k8s_node_group" {
  cluster_id  = yandex_kubernetes_cluster.k8s_cluster.id
  name        = var.node_group_name
  description = "Terraform-managed node group"
  version     = var.cluster_version

  instance_template {
    platform_id = "standard-v3"

    network_interface {
      nat        = var.node_public_ip
      ipv4       = var.node_public_ip
      subnet_ids = [yandex_vpc_subnet.k8s_subnet.id]
    }

    resources {
      cores         = var.node_instance_cores
      memory        = var.node_instance_memory
      core_fraction = 100
    }

    boot_disk {
      type = var.node_disk_type
      size = var.node_disk_size
    }

    scheduling_policy {
      preemptible = false
    }
  }

  deploy_policy {
    max_expansion   = var.nodegroup_max_expansion
    max_unavailable = var.nodegroup_max_unavailable
  }

  scale_policy {
    auto_scale {
      min = var.nodegroup_min_size
      max = var.nodegroup_max_size
      initial = var.nodegroup_initial_size
    }
  }

  allocation_policy {
    location {
      zone = var.cluster_zone
    }
  }

  maintenance_policy {
    auto_repair  = true
    auto_upgrade = false
  }

  node_labels = {
    "${var.nodegroup_label_key}" = var.nodegroup_label_value
  }

  depends_on = [
    yandex_kubernetes_cluster.k8s_cluster
  ]
}