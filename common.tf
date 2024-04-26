data "azurerm_resource_group" "example" {
  name     = "rg-example"
  # location = "japaneast"
}

module "test_eventhubs" {
    source         = "./eventhub"
    env          = "test"
    resource_group= data.azurerm_resource_group.example.name
    location      = data.azurerm_resource_group.example.location
}

module "test_func" {
    source         = "./functions"
    env          = "test"
    resource_group = data.azurerm_resource_group.example.name
    location      = data.azurerm_resource_group.example.location
    connection	= module.test_eventhubs.connection
    evh_name    = module.test_eventhubs.evh_name
}
