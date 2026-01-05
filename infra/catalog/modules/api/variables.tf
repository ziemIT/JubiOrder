variable "routes" {
    description = "Information about lambdas for API"
  type = map(object({
    handler     = string
    runtime     = string
    source_path = string
    env_vars    = optional(map(string), {})
  }))
}
