resource "kubernetes_deployment" "alb_ingress" {
  depends_on = ["kubernetes_cluster_role_binding.alb_ingress"]

  metadata {
    name      = "${var.name}"
    namespace = "${var.namespace}"

    labels {
      app = "${var.app_label}"
    }
  }

  spec {
    replicas = "${var.replicas}"

    selector {
      match_labels {
        app = "${var.app_label}"
      }
    }

    strategy {
      type = "RollingUpdate"

      rolling_update {
        max_surge       = "${var.max_surge}"
        max_unavailable = "${var.max_unavailable}"
      }
    }

    template {
      metadata {
        labels {
          app = "${var.app_label}"
        }
      }

      spec {
        dns_policy                       = "${var.dns_policy}"
        restart_policy                   = "Always"
        termination_grace_period_seconds = 30
        service_account_name             = "${var.service_account_name}"

        container {
          image                    = "${var.container_image}"
          image_pull_policy        = "Always"
          name                     = "${var.container_name}"
          termination_message_path = "/dev/termination-log"

          args = [
            "--watch-namespace=${var.namespace}",
            "--ingress-class=${var.ingress_class}",
            "--cluster-name=${var.cluster_name}",
            "--aws-vpc-id=${var.vpc_id}",
            "--aws-region=${var.region}",
            "--aws-max-retries=${var.max_retries}",
            "--alb-name-prefix=${var.alb_name_prefix}",
            "--target-type=${var.target_type}",
          ]

          volume_mount {
            mount_path = "/var/run/secrets/kubernetes.io/serviceaccount"
            name       = "${kubernetes_service_account.alb_ingress.default_secret_name}"
            read_only  = true
          }
        }

        volume {
          name = "${kubernetes_service_account.alb_ingress.default_secret_name}"

          secret {
            secret_name = "${kubernetes_service_account.alb_ingress.default_secret_name}"
          }
        }
      }
    }
  }
}

resource "kubernetes_cluster_role_binding" "alb_ingress" {
  depends_on = ["kubernetes_service_account.alb_ingress"]

  metadata {
    name = "${var.name}"

    labels {
      app = "${var.app_label}"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"             #TODO: use fine-grained ClusterRole when K8s TF provider supports
  }

  subject {
    kind      = "ServiceAccount"
    name      = "${var.service_account_name}"
    namespace = "${var.namespace}"
    api_group = ""
  }
}

resource "kubernetes_service_account" "alb_ingress" {
  metadata {
    name      = "${var.service_account_name}"
    namespace = "${var.namespace}"

    labels {
      app = "${var.app_label}"
    }
  }
}
