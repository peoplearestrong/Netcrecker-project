resource "digitalocean_droplet" "jenkins" {
  image = "ubuntu-18-04-x64"
  name = "jenkins"
  region = "ams3"
  size = "s-1vcpu-3gb"
  private_networking = true
  ssh_keys = [
    var.ssh_fingerprint
  ]
  connection {
    host = digitalocean_droplet.jenkins.ipv4_address
    user = "root"
    type = "ssh"
    private_key = file(var.pvt_key)
    timeout = "2m"
  }
  provisioner "remote-exec" {
    inline = [
      "echo Started",
    ]
  }
}

resource "digitalocean_floating_ip_assignment" "jenkins_fip" {
  ip_address = "134.209.137.43"
  droplet_id = digitalocean_droplet.jenkins.id
}
