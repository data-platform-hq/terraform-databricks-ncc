# Azure Databricks Network Connectivity Config Terraform module
Terraform module for creation Azure Databricks NCC

## Usage
This module provisions Databricks Network Connectivity Config workspace bindings and private endpoints rules for your Storage Accounts (i.e. Private Endpoints for blob and dfs in Databricks Control Plane).
```hcl
variable "databricks_account_id" {}
variable "databricks_metastore_id" {}
variable "databricks_ncc_id" {}

data "azurerm_databricks_workspace" "example" {
  name                = "example-workspace"
  resource_group_name = "example-rg"
}

data "azurerm_storage_account" "example" {
  name                = "mystorageaccount"
  resource_group_name = "example-rg"
}

provider "databricks" {
  alias      = "account"
  host       = "https://accounts.azuredatabricks.net"
  account_id = var.databricks_account_id
}

#NOTE: Network Connectivity Config works only with Unity Catalog assigned Workspaces
module "metastore_assignment" {
  source  = "data-platform-hq/metastore-assignment/databricks"
  version = "~> 1.0"

  workspace_id = data.databricks_workspace.example.workspace_id
  metastore_id = var.databricks_metastore_id

  providers = {
    databricks = databricks.account
  }
}

module "databricks_workspace_ncc" {
  source  = "data-platform-hq/ncc/databricks"
  version = "~> 1.0"

  network_connectivity_config_id = var.databricks_ncc_id
  databricks_workspace_id        = data.databricks_workspace.example.workspace_id
  storage_accounts = [
    { name = data.azurerm_storage_account.example.name, id = data.azurerm_storage_account.example.id },
  ]

  providers = {
    databricks = databricks.account
  }

  depends_on = [modules.metastore_assignment]
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.0.0 |
| <a name="requirement_databricks"></a> [databricks](#requirement\_databricks) | >=1.44.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_databricks"></a> [databricks](#provider\_databricks) | >=1.44.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [databricks_mws_ncc_binding.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/mws_ncc_binding) | resource |
| [databricks_mws_ncc_private_endpoint_rule.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/mws_ncc_private_endpoint_rule) | resource |
| [databricks_mws_network_connectivity_config.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/data-sources/mws_network_connectivity_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_databricks_workspace_id"></a> [databricks\_workspace\_id](#input\_databricks\_workspace\_id) | Target Databricks Workspace id | `string` | n/a | yes |
| <a name="input_network_connectivity_config_name"></a> [network\_connectivity\_config\_name](#input\_network\_connectivity\_config\_name) | Name of existing Network Connectivity Config | `string` | n/a | yes |
| <a name="input_storage_accounts"></a> [storage\_accounts](#input\_storage\_accounts) | List of object with parameters to configure NCC for Storage Account. Both blob and dfs private endpoints would be provisioned | <pre>list(object({<br/>    name = string<br/>    id   = string<br/>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## License

Apache 2 Licensed. For more information please see [LICENSE](./LICENSE)
