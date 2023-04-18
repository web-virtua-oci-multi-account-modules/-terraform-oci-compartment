# OCI Compartments with Policies for multiples accounts with Terraform module
* This module simplifies creating and configuring of Compartments with Policies across multiple accounts on OCI

* Is possible use this module with one account using the standard profile or multi account using multiple profiles setting in the modules.

## Actions necessary to use this module:

* Criate file provider.tf with the exemple code below:
```hcl
provider "oci" {
  alias   = "alias_profile_a"
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.ssh_private_key_path
  region           = var.region
}

provider "oci" {
  alias   = "alias_profile_b"
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.ssh_private_key_path
  region           = var.region
}
```


## Features enable of Compartment configurations for this module:

- Identity compartment
- Identity Policy

## Usage exemples


### Create compartment with policy

```hcl
module "main_clients_compartment" {
  source = "web-virtua-oci-multi-account-modules/compartment/aws"

  compartment_id = var.tenancy_ocid
  name           = "tf-compatment-test"
  description    = "Network compartment"

  policies = [
    {
        name           = "tf-oke-scanning-image-policy"
        compartment_id = var.compatment_id
        description    = "Description"
        statements     = [
            "Allow service vulnerability-scanning-service to read repos in tenancy"
        ]
    }
  ]

  providers = {
    oci = oci.alias_profile_a
  }
}
```

### Create compartment without policy

```hcl
module "main_clients_compartment" {
  source = "web-virtua-oci-multi-account-modules/compartment/aws"

  compartment_id = var.tenancy_ocid
  name           = "tf-compatment-test"
  description    = "Network compartment"

  providers = {
    oci = oci.alias_profile_a
  }
}
```

## Variables

| Name | Type | Default | Required | Description | Options |
|------|-------------|------|---------|:--------:|:--------|
| name | `string` | `-` | yes | Compartment name | `-` |
| description | `string` | `-` | yes | Description to compartment is required | `-` |
| compartment_id | `string` | `null` | no | Compartment ID | `-` |
| enable_delete | `bool` | `true` | no | If true allow delete the compartiment | `*`false <br> `*`true |
| use_tags_default | `bool` | `true` | no | If true will be use the tags default to resources | `*`false <br> `*`true |
| tags | `map(any)` | `{}` | no | Tags to compartment | `-` |
| defined_tags | `map(any)` | `{}` | no | Defined tags to compartment | `-` |
| records | `list(object)` | `[]` | no | List of policies to be created | `-` |

* Model of variable policies
```hcl
variable "policies" {
  description = "List of policies to be created"
  type = list(object({
    name           = string
    compartment_id = string
    description    = string
    statements     = list(string)
    version_date   = optional(string)
    defined_tags   = optional(map(any))
    freeform_tags  = optional(map(any))
  }))
  default = [
    {
        name           = "tf-oke-scanning-image-policy"
        compartment_id = "ocid1.tenancy.oc1..aaaaa...wfgjhgfjhgfjhg"
        description    = "Enable policy to scan all vulnerability on services in tenancy OCIR"
        statements     = [
            "Allow service vulnerability-scanning-service to read repos in tenancy"
        ]
    }
  ]
}
```


## Resources

| Name | Type |
|------|------|
| [oci_identity_compartment.create_compartment](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_policy) | resource |
| [oci_identity_policy.create_policy](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/identity_compartments) | resource |

## Outputs

| Name | Description |
|------|-------------|
| `compartment` | Compartiment |
| `compartment_id` | Compartiment ID |
