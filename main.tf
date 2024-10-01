data "ibm_is_zones" "regional" {
  region = var.ibmcloud_region
}

locals {
  zones       = length(data.ibm_is_zones.regional.zones)
  vpc_zones = {
    for zone in range(local.zones) : zone => {
      zone = "${var.ibmcloud_region}-${zone + 1}"
    }
  }

  tags = [
    "provider:ibm",
    "region:${var.ibmcloud_region}"
  ]
}

resource "random_string" "prefix" {
  length  = 4
  special = false
  numeric = false
  upper   = false
}


# If an existing resource group is provided, this module returns the ID, otherwise it creates a new one and returns the ID
module "resource_group" {
  source                       = "terraform-ibm-modules/resource-group/ibm"
  version                      = "1.1.5"
  resource_group_name          = var.existing_resource_group == null ? "${local.prefix}-resource-group" : null
  existing_resource_group_name = var.existing_resource_group
}

output "resource_group_id" { value = module.resource_group.resource_group_id }

