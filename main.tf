terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  backend "azurerm" {
      resource_group_name  = "rg-example"
      storage_account_name = "sttfbackazurerm"
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
      use_oidc             = true
      use_azuread_auth     = true
  }

}

provider "azurerm" {
  features {}
}
