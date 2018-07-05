resource "azurerm_resource_group" "AZBENGROUP" {
  name     = "AZBENGROUP"
  location = "UK West"
}

resource "azurerm_resource_group" "AZBENGROUPVN" {
  name     = "AZBENGROUPVN"
  location = "UK West"
}


 resource "azurerm_virtual_network" "AZBENVN" {
  name                = "AZBENVN"
  address_space       = ["10.0.0.0/23"]
  location            = "UK West"
  resource_group_name = "${azurerm_resource_group.AZBENGROUPVN.name}"
}
