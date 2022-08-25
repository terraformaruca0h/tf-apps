# First module "call"
### Note we can call the module invocation with any name - not related at all with actual module name

locals {
  name_suffix = "${var.app_name}-${var.environment}-${var.region}"
  tags = merge(
    { NewTag = "foobar" },
    {
      Source          = "terraform cloud"
      Env             = var.environment
      CostCenter      = var.cost_center
      ApplicationName = var.app_name
  })
}

module "static_website" {
  #  source = "git@ssh.dev.azure.com:v3/rpgd60/tf-course-01/tf-modules-ado//modules/tf-azure-webstatic-ado?ref=v0.9.1"
  #  source = "git@github.com:rpgd60/tf-azure-webstatic.git?ref=1.1.0"
  source = "github.com/rpgd60/tf-azure-webstatic.git?ref=v0.9.3"

  # Resource Group
  region  = var.region
  rg_name = "rg-${local.name_suffix}"

  # Storage Account
  storage_account_name              = "${var.environment}staticweb"
  storage_account_tier              = "Standard"
  storage_account_replication_type  = "LRS"
  storage_account_kind              = "StorageV2"
  static_website_index_document     = "index.html"
  static_website_error_404_document = "error.html"
  module_tags                       = local.tags
}

# # Second module "call"
# module "second_static_website" {
#   source = "../../modules/azure-static-website"

#   # Resource Group
#   region  = "westeurope"
#   rg_name = "modreg2"

#   # Storage Account
#   storage_account_name              = "staticwebsite"
#   storage_account_tier              = "Standard"
#   storage_account_replication_type  = "LRS"
#   storage_account_kind              = "StorageV2"
#   static_website_index_document     = "index.html"
#   static_website_error_404_document = "error.html"
# }
