output "cluster_url" {
  description = "Kubernetes cluster URL"
  value = "https://console.yandex.cloud/folders/${var.folder_id}/managed-kubernetes/cluster/${yandex_kubernetes_cluster.k8s_cluster.id}/overview"
}

output "cluster_connection" {
  description = "Kubernetes cluster URL"
  value = "yc managed-kubernetes cluster get-credentials --id ${yandex_kubernetes_cluster.k8s_cluster.id} --external"
}