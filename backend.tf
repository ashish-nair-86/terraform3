terraform {
  backend "s3" {
    bucket = "jenkins-mysql-backup00"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}
