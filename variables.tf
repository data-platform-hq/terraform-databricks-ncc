variable "databricks_workspace_id" {
  type        = string
  description = "Target Databricks Workspace id"
}

variable "network_connectivity_config_id" {
  type        = string
  description = "Existing Network Connectivity Config  ID in Databricks Account"
}

variable "storage_accounts" {
  type = list(object({
    name = string
    id   = string
  }))
  description = "List of object with parameters to configure NCC for Storage Account. Both blob and dfs private endpoints would be provisioned"
}
