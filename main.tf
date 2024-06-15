resource "yandex_vpc_network" "default" {}

resource "yandex_vpc_subnet" "default" {
  zone           = var.compute_zone
  network_id     = "${yandex_vpc_network.default.id}"
  v4_cidr_blocks = ["10.5.0.0/24"]
}

data "yandex_compute_image" "ubuntu_base_image" {
#   family = "ubuntu-2204-lts"
  //REQUIRED
  folder_id = var.images_folder_id
  //OPTIONAL
  name = var.boot_image_name
}

resource "yandex_compute_instance" "main" {
  //THIS BLOCK IS REQUIRED
  resources {
    cores = var.instance_resources_cores
    memory = var.instance_resources_memory
    //OPTIONAL
    core_fraction = var.instance_resources_core_fraction
    //OPTIONAL
    gpus = var.instance_resources_gpus
  }
  //THIS BLOCK IS REQUIRED
  boot_disk {
    auto_delete = var.boot_disk_autodelete
    device_name = var.boot_disk_device_name
    mode = var.boot_disk_mode

    initialize_params {
      image_id = "${data.yandex_compute_image.ubuntu_base_image.id}"
      name     = var.boot_disk_name
      description = var.boot_disk_description
      size     = var.boot_disk_size
      block_size = var.boot_disk_block_size
      type     = var.boot_disk_type
    }
  }
  //THIS BLOCK IS REQUIRED
  network_interface {
    index     = 1
    subnet_id = "ad16ob2c0ih1vdlh4p1m"
    nat       = false
    ipv4 = true
    ip_address = "1.1.1.1"
    ipv6 = false
    ipv6_address = "f0ee:6314:346b:0c79:13be:e440:0737:3f88"
    nat_ip_address = "1.1.1.2"
    security_group_ids = ["", ""]

    dns_record {
        fqdn = ""
        dns_zone_id = ""
        ttl = 900
        ptr = true
    }

    ipv6_dns_record {
        fqdn = ""
        dns_zone_id = ""
        ttl = 900
        ptr = true
    }

    nat_dns_record {
        fqdn = ""
        dns_zone_id = ""
        ttl = 900
        ptr = true
    }
  }
  // PARAMETERS BELOW ARE OPTIONAL!!!!!
  hostname    = var.instance_hostname
  name        = var.instance_name
  platform_id = var.platform_id
  zone        = var.compute_zone
  labels = var.labels

  metadata = {
    serial-port-enable = 1
    enable-oslogin     = var.os_login
    user-data = "some_user_data_or_file_with_userdata" # ${file("./cloud_init.yaml")}
    ssh-keys  = "user:key" #ubuntu:${file("~/.ssh/id_rsa.pub")}
  }

  network_acceleration_type = var.network_acceleration_type

  maintenance_policy = var.maintenance_policy

  secondary_disk {
    disk_id = "id"
    auto_delete = false
    device_name = "default_secondary_disk"
    mode = "READ_WRITE"
  }

  scheduling_policy {
    preemtible = var.preemtible
  }

  placement_policy {
    placement_group_id = "some_id"
    host_affinity_rules = {
      key = "yc.hostId"
      op = IN
      value = ["host_id1", "host_group_id1"]
    }
  }

  local_disk {
    size_bytes = 4096
  }

  filesystem {
    filesystem_id = "required_id"
    device_name = "name_of_device_representing_the_filesystem"
    mode = "READ_WRITE"
  }

  metadata_options {
    foo = "Options allow user to configure access to instance's metadata"
  }
  service_account_id = "(Optional) ID of the service account authorized for this instance."

  allow_stopping_for_update = true

  gpu_cluster_id = "(Optional) ID of the GPU cluster to attach this instance to The GPU cluster must exist in the same zone as the instance."

  maintenance_grace_period = "60s"

}