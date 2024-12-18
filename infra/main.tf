Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Here is a basic example of how you can use Terraform to create an Azure cloud infrastructure for an e-commerce web application. 

Please note that this is a simplified example and you may need to adjust it according to your specific needs. 

```hcl
provider "azurerm" {
  features {}
}

module "resource_group" {
  source  = "Azure/resource-group/azurerm"
  version = "2.0.2"

  name     = "ecommerce_rg"
  location = "West Europe"
}

module "storage_account" {
  source  = "Azure/storage-account/azurerm"
  version = "2.0.2"

  name                     = "ecommercestorage"
  resource_group_name      = module.resource_group.name
  location                 = module.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

module "app_service" {
  source  = "Azure/app-service/azurerm"
  version = "2.0.2"

  name                = "ecommerce-app"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  app_service_plan_id = module.app_service_plan.id
  storage_account     = module.storage_account.name
}

module "sql_server" {
  source  = "Azure/sql-server/azurerm"
  version = "2.0.2"

  name                         = "ecommerce-sql"
  resource_group_name          = module.resource_group.name
  location                     = module.resource_group.location
  version                      = "12.0"
  administrator_login          = "admin"
  administrator_login_password = "password"
}

module "sql_database" {
  source  = "Azure/sql-database/azurerm"
  version = "2.0.2"

  name                = "ecommerce-db"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  server_name         = module.sql_server.name
  requested_service_objective_name = "S0"
}
```

This code creates a resource group, a storage account, an app service, a SQL server, and a SQL database. The modules used in this code are hypothetical and you would need to replace them with actual Terraform modules or your own code. 

Please replace the placeholders (like "password") with your actual data. Also, remember to keep your sensitive data like passwords and keys secure and do not expose them in your scripts or version control system. 

This code is modular as it uses Terraform modules, which are self-contained packages of Terraform configurations that are managed as a group. This makes the code more manageable, reusable, and it enforces separation of concerns. 

As for cost-effectiveness, this largely depends on the specific Azure services you choose to use, their tier, and how you manage them. In this example, we are using "Standard" tier for the storage account and "S0" for the SQL database, which are cost-effective options. However, you should review the pricing details of each service and choose the ones that best fit your needs and budget.