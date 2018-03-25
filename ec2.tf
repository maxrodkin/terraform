
provider "aws" {
    access_key = "AKIAJZJ3AJWFPKLK2JQQ"
    secret_key = "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"
    region = "eu-west-1"
}

resource "aws_instance" "rodkin_1" {

subnet_id = "subnet-147e7e4f"
instance_type = "t2.micro"
ami = "ami-70054309"
key_name = "rodkin-6"
vpc_security_group_ids = ["sg-83f9a1f9" ]

tags {
"Name" = "rodkin_1"
}

connection {
# The default username for our AMI
user = "ubuntu"
# The path to your keyfile
#key_file = "./rodkin-6.ppk"
private_key = "${file("./rodkin-6.pem")}"
}

provisioner "remote-exec" {
	inline = [
		"sudo apt-get update",
		"apt-get --yes --force-yes -o Dpkg::Options::=\"--force-confdef\" -o Dpkg::Options::=\"--force-confnew\" upgrade",
		"sudo apt-get -y install systemd"
	]
}

provisioner "remote-exec" {
	inline = [
		"sudo useradd theUsername"
	]
}
provisioner "remote-exec" {
	inline = [
		"sudo sh -c \"echo '127.0.0.1 rodkin_1.local' >> /etc/hosts\"",	
		"sudo hostnamectl set-hostname rodkin_1.local"

		]
}

provisioner "remote-exec" {
	inline = [
		"sudo reboot"
	]
}

}





