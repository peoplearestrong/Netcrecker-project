resource "digitalocean_droplet" "psql" {
  image = "ubuntu-18-04-x64"
  name = "psql"
  region = "ams3"
  size = "s-1vcpu-1gb"
  private_networking = true
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]
  connection {
    host = "${digitalocean_droplet.liferay.ipv4_address}"
    user = "root"
    type = "ssh"
    private_key = "${file(var.pvt_key)}"
    timeout = "2m"
  }
  provisioner "remote-exec" {
    inline = [
      "apt update -y",
      "apt-get install -y python python3 python-pip python-yaml python-jinja2 python-httplib2 git",
      "useradd admin",
      "chpasswd <<< 'admin:admin'",
    ]
  }
}