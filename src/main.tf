#создаем облачную сеть develop
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

#создаем облачную сеть db
resource "yandex_vpc_network" "db" {
  name = var.vpc_name_db
}

#создаем облачную подсеть develop (zone A)
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.wm_web_default_cidr
}

#создаем облачную подсеть db (zone B)
resource "yandex_vpc_subnet" "db" {
  name           = var.vpc_name_db
  zone           = var.vm_db_default_zone
  network_id     = yandex_vpc_network.db.id
  v4_cidr_blocks = var.wm_db_default_cidr
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_family
}
resource "yandex_compute_instance" "platform" {
  name            = local.vm_web_instance_name
  platform_id     = var.vm_web_platform_id
  zone            = var.default_zone
  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = var.metadata

}

data "yandex_compute_image" "ubuntu_db" {
  family = var.vm_db_family
}
resource "yandex_compute_instance" "platform_db" {
  name        = local.vm_db_instance_name
  platform_id = var.vm_db_platform_id
  zone = var.vm_db_default_zone
    resources {
    cores         = var.vms_resources.db.cores
    memory        = var.vms_resources.db.memory
    core_fraction = var.vms_resources.db.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_db.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.db.id
    nat       = true
  }
  metadata = var.metadata
}