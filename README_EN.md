# Kubernetes Node Group Debugging Practice in Yandex Cloud

This repository contains practical exercises for debugging Kubernetes node group issues in Yandex Cloud.

## Preparation

1. Install terraform following the guide in our [documentation](https://yandex.cloud/ru/docs/tutorials/infrastructure-management/terraform-quickstart#install-terraform).

2. Install helm using the instructions at https://helm.sh/docs/intro/install/.

3. Install and configure YC CLI https://yandex.cloud/ru/docs/cli/quickstart.

4. Clone this repository where you'll complete the practical work:

```bash
git clone https://github.com/DaniilInside/practice-k8s-node-group-yandex-cloud-debuging.git
```

5. Navigate to the directory:

```bash
cd practice-k8s-node-group-yandex-cloud-debuging/init
```

6. Run the commands:

```bash
export YC_TOKEN=$(yc iam create-token)
export TF_VAR_folder_id=$(yc config get folder-id)
terraform init
terraform apply
```

Wait for the infrastructure to be created. As a result, you'll get a link to the k8s cluster and a command to connect. The practical exercises will take place there.

All tasks are numbered in order of increasing difficulty.

## Rules

* Stay in the `./practice-k8s-node-group-yandex-cloud-debuging` directory
* Do not change the cluster configuration in the tasks unless explicitly stated
* Make all fixes through changes to resources deployed in the task
* If you need to make changes to the cluster, make them through terraform
* To start a task, run the command:

```bash
helm install practice-<number> ./debug-practice-chart --values practice-<number>/values.yaml
```

A namespace `practice-<number>` is created for each task, and all task resources will be in it.

After completion, be sure to delete the task resources:

```bash
helm uninstall practice-<number>
```

* Do not create your own resources

## Tasks

### Task 1

To start the task, run the command:

```bash
helm install practice-1 ./debug-practice-chart --values practice-1/values.yaml
```

**Determine:**

* Why is the pod in Pending status?
* Why didn't Cluster Autoscaler create a node?
* How to fix the problem? Get the pod to transition to Running status.

### Task 2

To start the task, run the command:

```bash
helm install practice-2 ./debug-practice-chart --values practice-2/values.yaml
```

**Determine:**

* Why is the pod in Pending status?
* Why didn't Cluster Autoscaler create a node?
* How to fix the problem? Get the pod to transition to Running status.

### Task 3

To start the task, run the command:

```bash
helm install practice-3 ./debug-practice-chart --values practice-3/values.yaml
```

**Determine:**

* What changed in the node group?
* Why did these changes occur?

<details>
<summary>**Additional task**</summary>

Make the node group scale down to 1 without changing the number of replicas in the deployment.
</details>

### Task 4

To start the task, run the command:

```bash
helm install practice-4 ./debug-practice-chart --values practice-4/values.yaml
```

**Determine:**

* Why are not all pods in Running status?
* Fix the problem and get all pods to transition to Running without reducing their number.

### Task 5

To start the task, run the command:

```bash
helm install practice-5 ./debug-practice-chart --values practice-5/values.yaml
```

Wait for all pods to transition to Running.

Run the commands in the `./init` directory:

```bash
export YC_TOKEN=$(yc iam create-token)
export TF_VAR_folder_id=$(yc config get folder-id)
export TF_VAR_node_disk_size="34"
terraform apply
```

These commands will change the disk size, thereby triggering the recreation of nodes in the Node Group.

Don't wait for the operation to complete - it won't finish :)

**Do not cancel the operation!**

**Determine:**

* Why is the node group hanging in Reconciling status?
* Fix the problem - a fix will be considered a transition of the Node Group to Running status.