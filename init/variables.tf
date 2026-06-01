variable "folder_id" {
  type        = string
  description = "Yandex Cloud Folder ID"
}

variable "cluster_name" {
  type        = string
  description = "Kubernetes cluster name"
  default     = "practice"
}

variable "cluster_version" {
  type        = string
  description = "Kubernetes version"
  default     = "1.33"
}

variable "public_ip" {
  type        = bool
  description = "Assign public IP address to cluster"
  default     = true
}

variable "release_channel" {
  type        = string
  description = "MK8S release channel"
  default     = "STABLE"
}

variable "cluster_zone" {
  type        = string
  description = "Availability zone"
  default     = "ru-central1-a"
}

variable "cluster_public_ip" {
  type        = bool
  description = "Assign public IP address to cluster"
  default     = true
}

variable "node_group_name" {
  type        = string
  description = "Node group name"
  default     = "practice-node-group"
}

variable "node_instance_cores" {
  type        = number
  description = "Number of CPU cores for node instances"
  default     = 2
}

variable "node_instance_memory" {
  type        = number
  description = "Memory in GB for node instances"
  default     = 2
}

variable "node_instance_type" {
  type        = string
  description = "Instance type for nodes"
  default     = "standard-v3"
}

variable "node_disk_size" {
  type        = number
  description = "Disk size in GB for node instances"
  default     = 32
}

variable "node_disk_type" {
  type        = string
  description = "Disk type for node instances"
  default     = "network-hdd"
}

variable "node_public_ip" {
  type        = bool
  description = "Assign public IP address to nodes"
  default     = true
}

variable "nodegroup_min_size" {
  type        = number
  description = "Minimum number of nodes in node group"
  default     = 1
}

variable "nodegroup_max_size" {
  type        = number
  description = "Maximum number of nodes in node group"
  default     = 3
}

variable "nodegroup_initial_size" {
  type        = number
  description = "Initial number of nodes in node group"
  default     = 1
}

variable "nodegroup_max_expansion" {
  type        = number
  description = "Maximum number of nodes that can be added to node group"
  default     = 1
}

variable "nodegroup_max_unavailable" {
  type        = number
  description = "Maximum number of nodes that can be unavailable in node group"
  default     = 0
}

variable "nodegroup_label_key" {
  type        = string
  description = "Label key for node group"
  default     = "size"
}

variable "nodegroup_label_value" {
  type        = string
  description = "Label value for node group"
  default     = "min"
}