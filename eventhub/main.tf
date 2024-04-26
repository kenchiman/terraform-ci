resource "azurerm_eventhub_namespace" "example" {
  name                = "evhns-dd-to-azure"
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = "Standard"
  capacity            = 1
}

resource "azurerm_eventhub" "example" {
  name                = "evh-dd-to-azure"
  namespace_name      = azurerm_eventhub_namespace.example.name
  resource_group_name = var.resource_group
  partition_count     = 2
  message_retention   = 1
}