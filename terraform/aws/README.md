# How To Use  

* Export your aws access key id and secret access key as following,  
  `export AWS_ACCESS_KEY_ID="anaccesskey"  
   export AWS_SECRET_ACCESS_KEY="asecretkey"`

* Make sure terraform is installed.  

* Use `terraform init` to install aws plugin.  

* Next, invoke `terraform plan` command to see the possible changes.  

* Finally, use `terraform apply` command to perform infrastructure orchestration.  

* Use `terraform destroy` to revoke changes.  

* Make sure that you always put `*.tfvars` file in .gitignore.
