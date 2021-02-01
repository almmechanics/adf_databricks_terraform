# ADF and Databricks connectivity

The codebase creates an end-to-end ADF to databricks pipeline with fully integrated logging. 

## Tech Stack

*  `Terraform`
*  `ARM`
*  `DataFactory`
*  `Application Insights`
*  `Log Analytics`

## Usage 

```Terraform
terraform plan -var-file="../secret.tfvars" -out=plan.tfplan
terraform apply plan.tfplan
```

Not included `secrets.tfvars` - you need to supply your own.