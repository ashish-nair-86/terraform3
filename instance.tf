resource "aws_key_pair" "dove-key" {
  key_name   = "dovekey"
  public_key = file("doverkey.pub")

}

resource "aws_instance" "dover-instance" {
  count                  = 5
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1
  key_name               = aws_key_pair.dove-key.key_name
  vpc_security_group_ids = ["sg-00a7fdf11efbd18ad"]
  tags = {
    Name = "app-${count.index + 1}"
  }
  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }
  connection {
    user        = var.USER
    private_key = file("doverkey")
    host        = self.public_ip
  }
}

