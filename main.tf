terraform {
  required_providers {
    oci = {
      source = "hashicorp/oci"
    }
  }

  backend "s3" {
    bucket                      = "terraform-backend"
    key                         = "ampere/terraform.tfstate"
    profile                     = "default"
    region                      = "ap-tokyo-1"
    endpoint                    = "https://nr7eduszgfzb.compat.objectstorage.ap-tokyo-1.oraclecloud.com"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
}
