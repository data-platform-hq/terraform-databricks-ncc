locals {
  ncc_config_mapped = {
    for object in flatten([for sa in var.storage_accounts : [for kind in ["blob", "dfs"] : {
      name = "${sa.name}-${kind}"
      kind = kind
      id   = sa.id
  }] if sa != null]) : object.name => object }
}

resource "databricks_mws_ncc_binding" "this" {
  network_connectivity_config_id = var.network_connectivity_config_id
  workspace_id                   = var.databricks_workspace_id
}

resource "databricks_mws_ncc_private_endpoint_rule" "this" {
  for_each = local.ncc_config_mapped

  network_connectivity_config_id = var.network_connectivity_config_id
  resource_id                    = each.value.id
  group_id                       = each.value.kind

  depends_on = [databricks_mws_ncc_binding.this]
}
