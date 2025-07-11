##locals.tf

locals {
  project = "netology-develop-platform"
  type_web = "web"
  type_db  = "db"
  vm_web_instance_name = "${local.project}-${local.type_web}"
  vm_db_instance_name  = "${local.project}-${local.type_db}"
}
