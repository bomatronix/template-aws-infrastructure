locals {
  variables = var.variables
  // add environment variables
    env_vars = merge(
        var.variables,
        {
        "ENVIRONMENT" = var.environment,
        "ENV" = var.environment,
        }
    )
}