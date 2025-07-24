terraform {
  backend "s3" {
    bucket = "mybucketname"
    key    = "terraform.tfstate"
    # key = "path/to/mykey"
    region       = "us-east-1"
    use_lockfile = true
    # dynmodb_table = "givetablename"
    # encrypt = true
  }
}
