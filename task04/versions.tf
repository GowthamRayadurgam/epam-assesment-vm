terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version  = "~> 1.5.7"
    }
  }
}

provider "azurerm" {
  features {

  }
  subscription_id = "5b2dce2d-b796-44e5-8f67-cea66f735d9e"
  tenant_id       = "b41b72d0-4e9f-4c26-8a69-f949f367c91d"
}
