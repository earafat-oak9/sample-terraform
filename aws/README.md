# How to deploy resources

## Prerequisites
- Terraform installed
- Credentials with write access to the sandbox account

## Steps
1. Duplicate the file `local.template.tfvars` in the csp folder you want to run terraform in but remove 
   the `.template` part of its name.
   - _You should now have two files: `local.template.tfvars` and `local.tfvars`_
2. Edit the file `local.tfvars` and set your values.

3. Depending on what you want to deploy, run one of the following commands
	- _You might need to run `terraform init`_
	  
	  _Terraform will tell you to do so if you need to._ 


```shell
# deploy resources of a single module
terraform apply -target "module.s3.module.dr4"

# deploy a single resource
terraform apply -target "module.s3.module.dr4.aws_s3_bucket.bucket-dr4"
``` 

# How to contribute
Here's how to contribute to this repo.

# Folder structure
```
.
├── README.md - you're here!
├── aws/
│   ├── config_providers/
│   │   │   // This directory is oriented more towards testing config providers.
│   │   │   // It's focused on scenarios that create different resources to cover
│   │   │   // all possible configs of a resource.
│   │   │   
│   │   ├── s3/
│   │   │   │   // Group scnarios by service name.
│   │   │   │   
│   │   │   ├── all.tf   // has modules that point to all scenarios in service
│   │   │   ├── g4a/
│   │   │   │   │   // This is a scenario. It's a terraform module that deploys 
│   │   │   │   │   // resource(s) to cover a certain scenario. Its name is just
│   │   │   │   │   // a random 3-char string.  
│   │   │   │   │
│   │   │   │   └── g4a.tf
│   │   │   ├── dr4/
│   │   │   │   └── dr4.tf
│   │   │   └── more scenarios...
│   │   └── dynamodb/
│   │       ├── all.tf
│   │       └── more scenarios...
│   │
│   └── security/
│       │   // This directory is oriented more towards testing validations.
│       │   // It's focused on scenarios that create resources with certain
│       │   // design gaps that we expect.
│       │   
│       ├── s3/
│       │   ├── all.tf
│       │   └── more scenarios...
│       └── more services...
│
├── azure/
│   ├── config_providers/
│   │   └── services...
│   └── security/
│       └── services...
│
└── more CSPs...
```
