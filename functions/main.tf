resource "azurerm_storage_account" "example" {
  name                     = "ddazurest20230827"
  resource_group_name      = var.resource_group
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "example" {
  name                = "asp-k8sfundamentals"
  resource_group_name = var.resource_group
  location            = var.location
  os_type             = "Windows"
  sku_name            = "Y1"
}

# Key Vault からDatadog APIキーを取得する場合
# data "azurerm_key_vault" "example" {
#   name = "k8s-fundamentals"
#   resource_group_name = var.resource_group
# }

# data "azurerm_key_vault_secret" "dd-api-key" {
#   name = "dd-api-key"
#   key_vault_id = data.azurerm_key_vault.example.id
# }

# data "azurerm_key_vault" "example" {
#   name = "k8s-fundamentals"
#   resource_group_name = var.resource_group
# }

# data "azurerm_key_vault_secret" "dd-api-key" {
#   name = "dd-api-key"
#   key_vault_id = data.azurerm_key_vault.example.id
# }

resource "azurerm_windows_function_app" "example" {
  name                = "dd-to-azure"
  resource_group_name = var.resource_group
  location            = var.location
  depends_on      = [azurerm_storage_account.example]

  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  service_plan_id            = azurerm_service_plan.example.id
  https_only                 = true

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "node" 
    WEBSITE_NODE_DEFAULT_VERSION = "~18" 
    # 本来はKey Vault から取得するようにするなどセキュアにしておく方がよい（terraformのコードをGitHubなどで管理している場合は特に）
    # DD_API_KEY                   = "<YOUR_DD_API_KEY>"
    # Key Vault からDatadog APIキーを取得する場合
    # DD_API_KEY                   = data.azurerm_key_vault_secret.dd-api-key.value
    DD_SITE                      = "ap1.datadoghq.com"
    evh_connect                  = "${var.connection}"
    # evh_connect                  = "${var.connection};EntityPath=${var.evh_name}"
  }

  site_config {
    cors {
      allowed_origins     = ["*", "https://portal.azure.com"]
    }
  }
}