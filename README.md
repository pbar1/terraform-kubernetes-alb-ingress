# Terraform Module: AWS ALB Ingress Controller for Kubernetes

This is a Terraform module to create an [AWS ALB Igress Controller][1]. This module is opinionated in that it forces your ingress controller to be scoped to the namespace it is deployed into.

Uses the [Kubernetes provider][2] for Terraform

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| alb_name_prefix | Prefix to add to ALB resources (11 alphanumeric characters or less) | string | `` | no |
| app_label | Kubernetes `app` label to apply to resources created by this module | string | `alb-ingress-controller` | no |
| cluster_name | Kubernetes cluster name | string | - | yes |
| container_image | Container image to pull | string | `quay.io/coreos/alb-ingress-controller:v1.0.0` | no |
| container_name | Name to give to ALB ingress controller container within K8s pod | string | `server` | no |
| dns_policy | Set DNS policy for containers within the pod | string | `ClusterFirst` | no |
| ingress_class | Ingress class name to respect for the annotation `kubernetes.io/ingress.class:` | string | `alb` | no |
| max_retries | Maximum number of times to retry the aws calls | string | `10` | no |
| max_surge | The maximum number of pods that can be scheduled above the desired number of pods. Can be absolute (ex. 5) or percentage (ex. 10%) | string | `1` | no |
| max_unavailable | The maximum number of pods that can be unavailable during the update. Can be absolute (ex. 5) or percentage (ex. 10%) | string | `1` | no |
| name | Name to give the ALB ingress controller | string | `alb-ingress-controller` | no |
| namespace | Kubernetes namespace the ALB ingress controller will be scoped to | string | - | yes |
| region | AWS region | string | - | yes |
| replicas | Number of desired pods | string | `1` | no |
| service_account_name | Service account name to use for Kubernetes RBAC | string | `alb-ingress` | no |
| target_type | Default target type to use for target groups, must be `instance` or `ip` | string | `instance` | no |
| vpc_id | AWS VPC ID | string | - | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

[1]: https://kubernetes-sigs.github.io/aws-alb-ingress-controller/
[2]: https://www.terraform.io/docs/providers/kubernetes/index.html
