module "k8s" {
    source = "./k8s"
    key_name = "model-office-aws"
    key_path = "../../.ssh/modelofficeaws.pem"
    region = "eu-west-1"
    servers= "2"
    instance_type = "t2.micro"
    master_instance_type = "t2.micro"
}

output "master" {
    value = "${module.k8s.master_address}"
}


