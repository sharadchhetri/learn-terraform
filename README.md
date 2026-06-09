# Learn-Terraform

In this repo we are keeping the terraform code for learning purpose. Currently we are using the provider called aws.

# Install Terraform
Visit [Terrafrom](https://developer.hashicorp.com/terraform/install) 

# Highlights
Given below are sample code for learning.

1. Terraform backend: Using s3 bucket which will remotely save the tfstat file.
2. Local Variable file.
3. Variable files (.tfvars and .tf) | dev.tfvars is for dev environment.
4. Module (example s3_bucket)

**Note:**
In native terraform, we cannot use input variables, local values, or data source attributes inside a backend configuration block.

Alternatively, you can use given below two methods.

1. Passing the variables value during runtime.

```
# in hcl - in terraform.tf file
terraform {
  backend "s3" {} # Left empty intentionally
}
```


```
# In command line
terraform init \
  -backend-config="bucket=my-dev-tfstate-bucket" \
  -backend-config="key=dev/terraform.tfstate" \
  -backend-config="region=us-east-1"
  ```


2. Or create a config file 


```
# dev-backend.conf

bucket = "my-dev-tfstate-bucket"
key    = "dev/terraform.tfstate"
region = "us-east-1"
```

```
# Run the command
terraform init -backend-config="dev-backend.conf"
```