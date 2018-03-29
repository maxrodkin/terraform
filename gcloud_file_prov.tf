provider "google" {
    region = "europe-west1-b"
    zone = "europe-west1-b"
    credentials = "${file("account.json")}"
    project     = "${var.project}"
}
resource "google_compute_instance" "default" {
	name = "node1"
	machine_type = "f1-micro"
	boot_disk {
	initialize_params {
	 image = "ubuntu-1604-xenial-v20170328"
	}
	}
	network_interface {
	network = "default"
	access_config {
	}
	}
  provisioner "file" {
    source      = "./helloworld.txt"
    destination = "/etc/helloworld.txt"
  }

}




