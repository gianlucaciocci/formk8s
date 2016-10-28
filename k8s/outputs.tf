output "master_address" {
    value = "${aws_instance.master.0.public_dns}"
}

