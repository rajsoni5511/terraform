terraform {
    required_version = ">=1.10" #version locking blog
  backend "s3" {
    bucket = "multiclouds.live"
    #key    = "terraform.tfstate"
    ## if using same s3 bucket for other directory we can write like this
     key ="day3/terraform.tfstate"
    # it's benifit is this that statefile not overite or del
    # key = "path/to/mykey"
    region       = "us-east-1"
    use_lockfile = true #this block support latest ver. 1.10 and upgrade
    # dynmodb_table = "givetablename"
    # encrypt = true
  }
}
