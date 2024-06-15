variable "compute_zone" {
  type = string
  default = "kz-1a"
}

variable "os_login" {
  type = bool
  default = false
}

variable "network_acceleration_type" {
  type = string
  default = "standard"
}

variable "maintenance_policy" {
  type = string
  default = "unspecified"
}

variable "labels" {
  type = map(string)
  default = {
      first_label = "foo"
      second_label = "bar"
    }
}

variable "platform_id" {
  type = string
  default = "standard-v3"
}

variable "instance_hostname" {
  type = string
  default = "default"
}

variable "instance_name" {
  type = string
  default = "default"
}

variable "images_folder_id" {
  type = string
  default = "standard-images"
}

variable "boot_image_name" {
  type = string
  default = "ubuntu-22-04-lts-v20240429"
}

variable "boot_disk_name" {
  type = string
  default = "default_disk"
}

variable "boot_disk_description" {
  type = string
  default = "default_description"
}

variable "boot_disk_mode" {
  type = string
  default = "READ_WRITE"
}

variable "boot_disk_block_size" {
  type = number
  default = 4096
}

variable "boot_disk_size" {
  type = number
  default = 20
}

variable "boot_disk_type" {
  type = string
  default = "network-ssd"
}

variable "boot_disk_device_name" {
  type = string
  default = "default_disk"
}

variable "boot_disk_autodelete" {
  type = bool
  default = false
}

variable "instance_resources_cores" {
  type = number
  default = 2
}

variable "instance_resources_core_fraction" {
  type = number
  default = 100
}

variable "instance_resources_memory" {
  type = number
  default = 2
}

variable "instance_resources_gpus" {
  type = number
  default = 0
}

variable "preemtible" {
  type = bool
  default = false
}
