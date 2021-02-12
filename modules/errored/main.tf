zdjlfvnlzdfznvblzdfnvblzdfl'/
#provider "aws"  {
 # region   = var.region
 #}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "test_instance_my_instance1" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type1
  subnet_id                   = var.subnet
  associate_public_ip_address = var.associate_public_ip

    tags = merge({ "Name" = format("k.kotov-test -> %s -> %s", substr ("🤔🤷", 0,1), data.aws_ami.ubuntu.name) }, var.tags)
    timeouts {
    create = "10m"
    delete = "15m"
       }
  #tags = merge({ "Name" = "k.kotov"}, var.tags)
 }


resource "aws_ebs_volume" "ebs-volume_for_testing_terraform-AllowFullS3Access" {
  availability_zone = "us-east-1a"
        size = 1
  tags = merge({ "Name" = "k.kotov"}, var.tags)
    }



variable "letters" {
  description = "a list of letters"
  default = ["a", "b", "c"]
  }


