resource "azurerm_resource_group" "AZBENGROUP" {
  name     = "AZBENGROUP"
  location = "UK West"
}

resource "azurerm_resource_group" "AZBENGROUPVN" {
  name     = "AZBENGROUPVN"
  location = "UK West"
}


 resource "azurerm_virtual_network" "AZBENVN1" {
  name                = "AZBENVN"
  address_space       = ["10.0.0.0/23"]
  location            = "UK West"
  resource_group_name = "${azurerm_resource_group.AZBENGROUPVN.name}"
}

resource "azurerm_subnet" "AZBENSUB11" {
  name                 = "AZBENSUB11"
  resource_group_name  = "${azurerm_resource_group.AZBENGROUPVN.name}"
  virtual_network_name = "${azurerm_virtual_network.AZBENVN1.name}"
  address_prefix       = "10.0.0.0/24"
}

resource "azurerm_subnet" "AZBENSUB12" {
  name                 = "AZBENSUB12"
  resource_group_name  = "${azurerm_resource_group.AZBENGROUPVN.name}"
  virtual_network_name = "${azurerm_virtual_network.AZBENVN1.name}"
  address_prefix       = "10.0.1.0/24"
}

resource "azurerm_public_ip" "AZBENIP" {
  name                         = "AZBENIP"
  location                     = "UK West"
  resource_group_name          = "${azurerm_resource_group.AZBENGROUP.name}"
  public_ip_address_allocation = "dynamic"
}

resource "azurerm_network_interface" "AZBENNI-11" {
  name                = "AZBENNI-11"
  location            = "UK West"
  resource_group_name = "${azurerm_resource_group.AZBENGROUPVN.name}"

  ip_configuration {
    name                          = "AZBENVNIP1"
    subnet_id                     = "${azurerm_subnet.AZBENSUB11.id}"
    private_ip_address_allocation = "static"
    private_ip_address            = "10.0.0.4"
    public_ip_address_id          = "${azurerm_public_ip.AZBENIP.id}"
  }
}

resource "azurerm_storage_account" "AZBENSTORE" {
  name                     = "azbenstore"
  resource_group_name      = "${azurerm_resource_group.AZBENGROUP.name}"
  location                 = "UK West"
  account_tier             = "standard"
  account_replication_type = "GRS"
}
