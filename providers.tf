terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = "1.70.0-beta0"
    }
  }
}

provider "ibm" {
  region = var.ibmcloud_region
  ibmcloud_api_key = var.ibmcloud_api_key
}