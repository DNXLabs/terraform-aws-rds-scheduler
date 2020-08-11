# terraform-aws-rds-scheduler

terraform-aws-rds-scheduler is a module to create a schedule to shut down or start a Relational database service (RDS)

This module requires:
 - Terraform Version >=0.12.20

This modules creates the following resources:
 - AWS Cloudwatch event rule - Delivers a real-time stream of system events that shut down or start the RDS.
 - Identity Access Management (IAM) that create a service role for Systems Manager Automation

More Information: https://dnxlabs.slab.com/public/d6s1wxc3

[![Lint Status](https://github.com/DNXLabs/terraform-aws-rds-scheduler/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-rds-scheduler/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-rds-scheduler)](https://github.com/DNXLabs/terraform-aws-rds-scheduler/blob/master/LICENSE)

<!--- BEGIN_TF_DOCS --->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.20 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cron\_start | Cron expression to define when to trigger a start of the DB | `any` | n/a | yes |
| cron\_stop | Cron expression to define when to trigger a stop of the DB | `any` | n/a | yes |
| enable | n/a | `bool` | `true` | no |
| identifier | RDS instance identifier for schedule | `any` | n/a | yes |

## Outputs

No output.

<!--- END_TF_DOCS --->

## Authors

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-rds-scheduler/blob/master/LICENSE) for full details.