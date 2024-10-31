terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.7.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.0"
    }
  }
  cloud {
    # The name of your Terraform Cloud organization.
    organization = "SoftwareOne"

    # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
      name = "level-3-terraform-azurerm-lz-vending"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "core" {}

module "lz-vending" {
  for_each = var.lz_vending

  source  = "Azure/lz-vending/azurerm"
  version = "4.1.4"

  location = each.value.location

  subscription_alias_enabled = true
  subscription_alias_name    = each.value.alias
  subscription_billing_scope = "/providers/Microsoft.Billing/billingAccounts/d7f99c23-d88b-5ab6-e739-8531d488b81e:34d03de1-f6b6-4b3e-a396-875a0d9437c9_2019-05-31/billingProfiles/6O76-4DRN-BG7-PGB/invoiceSections/YGJ7-XMXH-PJA-PGB"
  subscription_display_name  = each.value.name
  subscription_workload      = "Production"

  # network_watcher_resource_group_enabled = true

  # # management group association variables
  # subscription_management_group_association_enabled = true
  # subscription_management_group_id                  = "Corp"

  # # virtual network variables
  # virtual_network_enabled = true
  # virtual_networks = {
  #   one = {
  #     name                    = "my-vnet"
  #     resource_group_name     = "my-vnet"
  #     address_space           = ["192.168.1.0/24"]
  #     hub_peering_enabled     = true
  #     hub_network_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/my-hub-network-rg/providers/Microsoft.Network/virtualNetworks/my-hub-network"
  #     mesh_peering_enabled    = true
  #   }
  #   two = {
  #     name                    = "my-vnet2"
  #     resource_group_name     = "my-vnet2"
  #     location                = "northeurope"
  #     address_space           = ["192.168.2.0/24"]
  #     hub_peering_enabled     = true
  #     hub_network_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/my-hub-network-rg/providers/Microsoft.Network/virtualNetworks/my-hub-network2"
  #     mesh_peering_enabled    = true
  #   }
  #   vnet1 = {
  #     name                    = "spoke"
  #     address_space           = ["192.168.1.0/24"]
  #     resource_group_name     = "rg-networking"
  #     vwan_connection_enabled = true
  #     vwan_hub_resource_id    = azurerm_virtual_hub.example.id
  #   }
  # }

  # umi_enabled             = true
  # umi_name                = "umi"
  # umi_resource_group_name = "rg-identity"
  # umi_role_assignments = {
  #   myrg-contrib = {
  #     definition     = "Contributor"
  #     relative_scope = "/resourceGroups/MyRg"
  #   }
  # }

  # resource_group_creation_enabled = true
  # resource_groups = {
  #   myrg = {
  #     name     = "MyRg"
  #     location = "westeurope"
  #   }
  # }

  # # role assignments
  # role_assignment_enabled = true
  # role_assignments = {
  #   # using role definition name, created at subscription scope
  #   contrib_user_sub = {
  #     principal_id   = "00000000-0000-0000-0000-000000000000"
  #     definition     = "Contributor"
  #     relative_scope = ""
  #   },
  #   # using a custom role definition
  #   custdef_sub_scope = {
  #     principal_id   = "11111111-1111-1111-1111-111111111111"
  #     definition     = "/providers/Microsoft.Management/MyMg/providers/Microsoft.Authorization/roleDefinitions/ffffffff-ffff-ffff-ffff-ffffffffffff"
  #     relative_scope = ""
  #   },
  #   # using relative scope (to the created or supplied subscription)
  #   rg_owner = {
  #     principal_id   = "00000000-0000-0000-0000-000000000000"
  #     definition     = "Owner"
  #     relative_scope = "/resourceGroups/MyRg"
  #   },
  # }
}
