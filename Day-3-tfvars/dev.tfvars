### in terrafor.tfvars name dependency is there but if we run like this name 
### we can use this command
### terraform plan -var-file="dev.tfvars"
### we can use like this without change values in eviroment prod value in prodvar, 
### test value in testvar, and dev value in devvar file so we can easily manage
### in apply time we can also use terraform apply - var="instance_type=t2.micro"