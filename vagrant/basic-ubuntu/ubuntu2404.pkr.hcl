source "virtualbox-iso" "ubuntu-example1" {
  headless = true
  guest_os_type = "Ubuntu_64"
  iso_url = "https://mirror.yandex.ru/ubuntu-releases/24.04/ubuntu-24.04.2-live-server-amd64.iso"
  iso_checksum = "sha256:d6dab0c3a657988501b4bd76f1297c053df710e06e0c3aece60dead24f270b4d"
  vm_name = "ubuntu-server-2404"
  cpus = 1
  memory = 2048
  disk_size = 5000
  boot_command = [
      "e<wait>",
      "<down><down><down>",
      "<end><bs><bs><bs><bs><wait>",
      "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
       "<f10><wait>"
    ]
    http_directory = "http"
    ssh_timeout = "30m"
    ssh_username = "${var.username}"
    ssh_password = "${var.password}"
    shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
}
build {
  sources = ["sources.virtualbox-iso.ubuntu-example1"]
  post-processors {
    post-processor "artifice" {
      files = [
        "output-ubuntu-example1/ubuntu-server-2404-disk001.vmdk",
        "output-ubuntu-example1/ubuntu-server-2404.ovf"
      ]
    }
    post-processor "vagrant" {
      keep_input_artifact = true
      provider_override   = "virtualbox"
    }
}
}

