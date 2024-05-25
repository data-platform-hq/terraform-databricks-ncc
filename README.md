# Azure <> Terraform module
Terraform module for creation Azure <>

## Usage

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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_databricks_workspace_id"></a> [databricks\_workspace\_id](#input\_databricks\_workspace\_id) | Target Databricks Workspace id | `string` | n/a | yes |
| <a name="input_network_connectivity_config_id"></a> [network\_connectivity\_config\_id](#input\_network\_connectivity\_config\_id) | Existing Network Connectivity Config  ID in Databricks Account | `string` | n/a | yes |
| <a name="input_storage_accounts"></a> [storage\_accounts](#input\_storage\_accounts) | List of object with parameters to configure NCC for Storage Account. Both blob and dfs private endpoints would be provisioned | <pre>list(object({<br>    name = string<br>    id   = string<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## License

Apache 2 Licensed. For more information please see [LICENSE](./LICENSE)
