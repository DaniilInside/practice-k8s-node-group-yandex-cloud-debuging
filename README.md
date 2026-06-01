# Практика по отладке групп узлов Kubernetes в Yandex Cloud

Этот репозиторий содержит практические задания по отладке проблем с группами узлов Kubernetes в Yandex Cloud.

## Подготовка

1. Установи terraform по гайду из нашей [документации](https://yandex.cloud/ru/docs/tutorials/infrastructure-management/terraform-quickstart#install-terraform).

2. Установи helm по инструкции https://helm.sh/docs/intro/install/ .

3. Установи и настрой YC CLI https://yandex.cloud/ru/docs/cli/quickstart .

4. Склонируй себе репозиторий, в нём ты будешь выполнять практические работы:

```bash
git clone https://github.com/DaniilInside/practice-k8s-node-group-yandex-cloud-debuging.git
```

5. Перейди в каталог:

```bash
cd practice-k8s-node-group-yandex-cloud-debuging/init
```

6. Выполни команды:

```bash
export YC_TOKEN=$(yc iam create-token)
export TF_VAR_folder_id=$(yc config get folder-id)
terraform init
terraform apply
```

Дождись создания инфраструктуры, в результате ты получишь ссылку на кластер k8s и команду для подключения. В нём будут проходить практические.

Все задания нумеруются в порядке увеличения сложности.

## Правила

* Находись в каталоге `./practice-k8s-node-group-yandex-cloud-debuging`
* Конфигурацию кластера менять  в заданиях не нужно, если об этом не сказано явно.
* Все исправления выполняй через изменения ресурсов развернутых в задании.
* Если надо внести изменения в кластер, вноси их через terraform.
* Чтобы начать задание, выполни команду:

```bash
helm install practice-<number> ./debug-practice-chart --values practice-<number>/values.yaml
```

Под каждое задание создается namespace `practice-<number>` все ресурсы задания будут в нём.

После выполнения обязательно удали ресурсы задания:

```bash
helm uninstall practice-<number>
```

* Не создавай, своих ресурсов.

## Задания

### Задание 1

Чтобы начать задание, выполни команду:

```bash
helm install practice-1 ./debug-practice-chart --values practice-1/values.yaml
```

**Определи:**

* Почему под в статусе Pending?
* Почему Cluster Autoscaler не создал ноду?
* Как исправить проблему? Добейся того чтобы под перешел в статус Running.

### Задание 2

Чтобы начать задание, выполни команду:

```bash
helm install practice-2 ./debug-practice-chart --values practice-2/values.yaml
```

**Определи:**

* Почему под в статусе Pending?
* Почему Cluster Autoscaler не создал ноду?
* Как исправить проблему? Добейся того чтобы под перешел в статус Running.

### Задание 3

Чтобы начать задание, выполни команду:

```bash
helm install practice-3 ./debug-practice-chart --values practice-3/values.yaml
```

**Определи:**

* Что изменилось в группе узлов?
* Почему произошли эти изменения?

<details>
<summary>**Доп задание**</summary>

Заставь группу узлов уменьшится до 1, не меняя количества реплик в deployment.
</details>

### Задание 4

Чтобы начать задание, выполни команду:

```bash
helm install practice-4 ./debug-practice-chart --values practice-4/values.yaml
```

**Определи:**

* Почему не все поды в статусе Running?
* Исправь проблему, добейся перехода всех подов в Running не уменьшая их количество.

### Задание 5

Чтобы начать задание, выполни команду:

```bash
helm install practice-5 ./debug-practice-chart --values practice-5/values.yaml
```

Дождись пока все поды перейдут в Running.

Выполни команды в каталоге `./init`:

```bash
export YC_TOKEN=$(yc iam create-token)
export TF_VAR_folder_id=$(yc config get folder-id)
export TF_VAR_node_disk_size="34"
terraform apply
```

Этими командами ты изменишь размер диска, тем самым вызовешь пересоздание нод в Группе узлов.

Не дожидайся окончания операции — она не завершится :)

**Операцию не отменяй!**

**Определи:**

* Почему группа нод висит в статусе Reconciling.
* Исправь проблему — починкой будет считаться переход Группы узлов в статус Running.