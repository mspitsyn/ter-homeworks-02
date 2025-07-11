###cloud vars


variable "cloud_id" {
  type        = string
  default = "b1gchhnthvn0qe3v2rfb"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default = "b1gh2n9lu2pm397sqa8m"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "wm_web_default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "vm_web_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Операционная система ВМ"
}

variable "vm_web_name_platform" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Имя web-платформы"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "Стандарт платформы"
}

/* variable "vm_web_cores" {
    type = number
    default = 2
    description = "Кол-во ядер от 2 до 32"
}

variable "vm_web_memory" {
    type = number
    default = 1
    description = "Кол-во памяти"
}

variable "vm_web_core_fraction" {
    type = number
    default = 5
    description = "Процент использования"
}
###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEHRcJFPPYCyIbTvpZaN0Lm7YDV0CupCsj1RBJ+KMTGD mspitsin@mspitsin"
  description = "ssh-keygen -t ed25519"
}
*/

variable "vms_resources" {
  type         = map(map(number))
  default = {
    "web" = {
      cores = 2
      memory = 1
      core_fraction = 5
    }
    "db" = {
      cores = 2
      memory = 1
      core_fraction = 5
    }
  }
}

variable "metadata" {
  type = map(any)
  default = {
    "serial-port-enable" = 1
    "ssh-keys"           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEHRcJFPPYCyIbTvpZaN0Lm7YDV0CupCsj1RBJ+KMTGD mspitsin@mspitsin"
  }
  description = "Metadata for VMs"
}