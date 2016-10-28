# A Terraform plan to start a k8s cluster with Atomic

resource "aws_security_group" "k8s" {
  name = "k8s"
  description = "Kubernetes traffic"

  ingress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "template_file" "kubelet" {
    template = "${path.module}/scripts/minion/kubelet"

    vars {
        master_ip = "${aws_instance.master.private_ip}"
    }

    depends_on = ["aws_instance.master"]
}

resource "template_file" "config" {
    template = "${path.module}/scripts/common/config"

    vars {
        master_ip = "${aws_instance.master.private_ip}"
    }

    depends_on = ["aws_instance.master"]
}

resource "template_file" "flanneld" {
    template = "${path.module}/scripts/minion/flanneld"

    vars {
        master_ip = "${aws_instance.master.private_ip}"
    }

    depends_on = ["aws_instance.master"]
}

resource "aws_instance" "master" {

    ami = "${lookup(var.master_ami, var.region)}"
    instance_type = "${var.master_instance_type}"
    key_name = "${var.key_name}"
    security_groups = ["${aws_security_group.k8s.name}"]

    connection {
        type="ssh"
        user = "ubuntu"
        key_file = "${var.key_path}"
    }

    provisioner "file" {
        source = "${path.module}/scripts/master/"
        destination = "/tmp"
    }

    provisioner "remote-exec" {
        scripts = [
            "${path.module}/scripts/master.sh",
        ]
    }

    tags {
        Name = "master"
    }
}


