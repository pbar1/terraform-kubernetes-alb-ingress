variable "namespace" {
  description = "Kubernetes namespace the ALB ingress controller will be scoped to"
}

variable "cluster_name" {
  description = "Kubernetes cluster name"
}

variable "vpc_id" {
  description = "AWS VPC ID"
}

variable "region" {
  description = "AWS region"
}

#region OPTIONAL VARIABLES
variable "container_image" {
  description = "Container image to pull"
  default     = "quay.io/coreos/alb-ingress-controller:v1.0.0"
}

variable "container_name" {
  description = "Name to give to ALB ingress controller container within K8s pod"
  default     = "server"
}

variable "replicas" {
  description = "Number of desired pods"
  default     = 1
}

variable "max_surge" {
  description = "The maximum number of pods that can be scheduled above the desired number of pods. Can be absolute (ex. 5) or percentage (ex. 10%)"
  default     = 1
}

variable "max_unavailable" {
  description = "The maximum number of pods that can be unavailable during the update. Can be absolute (ex. 5) or percentage (ex. 10%)"
  default     = 1
}

variable "dns_policy" {
  description = "Set DNS policy for containers within the pod"
  default     = "ClusterFirst"
}

variable "alb_name_prefix" {
  description = "Prefix to add to ALB resources (11 alphanumeric characters or less)"
  default     = ""
}

variable "name" {
  description = "Name to give the ALB ingress controller"
  default     = "alb-ingress-controller"
}

variable "app_label" {
  description = "Kubernetes `app` label to apply to resources created by this module"
  default     = "alb-ingress-controller"
}

variable "ingress_class" {
  description = "Ingress class name to respect for the annotation `kubernetes.io/ingress.class:`"
  default     = "alb"
}

variable "max_retries" {
  description = "Maximum number of times to retry the aws calls"
  default     = 10
}

variable "service_account_name" {
  description = "Service account name to use for Kubernetes RBAC"
  default     = "alb-ingress"
}

variable "target_type" {
  description = "Default target type to use for target groups, must be `instance` or `ip`"
  default     = "instance"
}

#endregion

