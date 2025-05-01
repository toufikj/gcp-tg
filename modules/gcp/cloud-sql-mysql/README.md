# Cloud SQL Module

This module creates a Cloud SQL instance in Google Cloud Platform using the [terraform-google-sql-db](https://github.com/terraform-google-modules/terraform-google-sql-db) module.

## Usage

```hcl
module "cloud_sql" {
  source = "path/to/module"

  project_id = "your-project-id"
  region     = "us-central1"
  instance_name = "your-instance-name"
  
  # Network configuration
  network = "your-vpc-network"
  private_network = "your-private-network"
  
  # Instance configuration
  tier = "db-f1-micro"
  disk_size = 10
  
  # Database configuration
  database_version = "MYSQL_8_0"
  user_name = "admin"
  user_password = "your-password"
  
  # Optional configurations
  databases = [
    {
      name      = "your-database"
      charset   = "utf8mb4"
      collation = "utf8mb4_general_ci"
    }
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project_id | The project ID to deploy to | string | - | yes |
| region | The region to deploy to | string | - | yes |
| instance_name | The name of the Cloud SQL instance | string | - | yes |
| database_version | The database version to use | string | "MYSQL_8_0" | no |
| network | The VPC network to use | string | - | yes |
| private_network | The VPC network to use for private IP | string | - | yes |
| tier | The machine tier | string | "db-f1-micro" | no |
| disk_size | The disk size in GB | number | 10 | no |
| user_name | The name of the default user | string | "default" | no |
| user_password | The password for the default user | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| instance_name | The name of the Cloud SQL instance |
| instance_connection_name | The connection name of the Cloud SQL instance |
| public_ip_address | The public IPv4 address of the Cloud SQL instance |
| private_ip_address | The private IPv4 address of the Cloud SQL instance |
| instance_first_ip_address | The first IPv4 address of the Cloud SQL instance |
| instance_self_link | The URI of the Cloud SQL instance |
| generated_user_password | The auto generated default user password |

## Requirements

- Terraform >= 1.3.0
- Google Cloud Provider >= 4.0.0 