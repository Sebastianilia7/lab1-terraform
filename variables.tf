variable "namespace" {
  description = "Kubernetes namespace for your resources"
  type        = string
  default     = "sebastian-namespace"
}

variable "team_name" {
  description = "Team name for labeling"
  type        = string
  default     = "sebastian-team"
}
