# terraform-aws-rds-scheduler

[![Lint Status](https://github.com/DNXLabs/terraform-aws-rds-scheduler/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-rds-scheduler/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-rds-scheduler)](https://github.com/DNXLabs/terraform-aws-rds-scheduler/blob/master/LICENSE)

This is a module to create a schedule to shut down or start a Relational database service (RDS).

The following resources will be created:
 - AWS Eventbridge event rule - Delivers a real-time stream of system events that shut down or start the RDS.
 - Identity Access Management (IAM) that create a service role for Systems Manager Automation

Notes:
Aurora DB clusters can't be started or stopped under certain conditions:
- To start a cluster it must be in 'stopped' status.
- To stop a cluster it must be in 'available' status.
- You can't start or stop a cluster that's part of an Aurora global database.
- You can't start or stop a cluster that uses the Aurora parallel query.
- You can't start or stop an Aurora Serverless cluster.
- You can't start or stop an Aurora multi-master cluster.

<!--- BEGIN_TF_DOCS --->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aurora\_cluster | Is Aurora Cluster? | `bool` | `false` | no |
| cron\_start | Cron expression to define when to trigger a start of the DB | `any` | n/a | yes |
| cron\_stop | Cron expression to define when to trigger a stop of the DB | `any` | n/a | yes |
| enable | n/a | `bool` | `true` | no |
| identifier | RDS instance or Aurora Cluster identifier for schedule | `any` | n/a | yes |
| schedule\_timezone | Timezone used in scheduling cronjob | `any` | n/a | yes |

## Outputs

No output.

<!--- END_TF_DOCS --->

## Authors

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-rds-scheduler/blob/master/LICENSE) for full details.
