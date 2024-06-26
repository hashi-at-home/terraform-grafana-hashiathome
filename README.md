[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit) [![pre-commit.ci status](https://results.pre-commit.ci/badge/github/hashi-at-home/terraform-grafana-hashiathome/main.svg)](https://results.pre-commit.ci/latest/github/hashi-at-home/terraform-grafana-hashiathome/main) [![semantic-release: conventional](https://img.shields.io/badge/semantic--release-conventional-e10079?logo=semantic-release)](https://github.com/semantic-release/semantic-release)

# Terraform Grafana - Hashi At Home

This is the terraform module for Hashi At Home.
It terraforms a Grafana Instance to monitor Hashiathome.

## Examples

The `examples/` directory contains the example usage of this module.
These examples show how to use the module in your project, and are also use for testing in CI/CD.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >1.2.0 |
| <a name="requirement_grafana"></a> [grafana](#requirement\_grafana) | ~> 2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_grafana"></a> [grafana](#provider\_grafana) | 2.19.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [grafana_dashboard.nodes](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/dashboard) | resource |
| [grafana_folder.hah](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/folder) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_stack"></a> [stack](#input\_stack) | Cloud Stack configuration | <pre>object({<br>    region = string<br>    name   = string<br>    slug   = string<br>  })</pre> | <pre>{<br>  "name": "hashiathome.grafana.net",<br>  "region": "prod-eu-west-2",<br>  "slug": "hashiathome"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
