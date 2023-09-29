locals{ 
  storage_name= ["north","south","east","west"]
  superstar= ["jade","saj","idk","douglas","emannuel","olarewaju"]

}
  resource "azurerm_resource_group" "butterfly" {
  name     = "lmao"
  location = "Canada Central"
}

resource "azurerm_storage_account" "azurestorage" {
  name                     = "azurestor"
  resource_group_name      = azurerm_resource_group.butterfly.name
  location                 = azurerm_resource_group.butterfly.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "azurecontainer" {
  name                  = "content"
  storage_account_name  = azurerm_storage_account.azurestorage.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "awesomecontent" {
  for_each            = { for blob in local.storage_name : blob => blob }
  name                   = "my-awesome-content.zip"
  storage_account_name   = azurerm_storage_account.azurestorage.name
  storage_container_name = azurerm_storage_container.azurecontainer.name
  type                   = "Block"
  source                 = "some-local-file.zip"
}

