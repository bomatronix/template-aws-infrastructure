// create aws lambda layer version
resource "aws_lambda_layer_version" "layers" {

  layer_name = var.layer_name

  compatible_runtimes = var.compatible_runtimes

  lifecycle {
    ignore_changes = [filename]
  }
}
