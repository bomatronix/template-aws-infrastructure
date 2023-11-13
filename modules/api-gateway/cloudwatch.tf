resource "aws_cloudwatch_log_group" "api_gateway_log_group" {
  name              = "${var.name}-${var.enviornment}-api-gateway-log-group"
  retention_in_days = var.api_gw_log_retention_in_days
  tags              = merge(var.standard_tags, ({ "name" = "${var.name}-api-gateway-log-group" }))

}