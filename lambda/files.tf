// data archive_file place_hodler
data "archive_file" "place_hodler" {
  type        = "zip"
  output_path = "${path.module}/lambda_function_payload.zip"
  source {
    content = "def lambda_handler(event, context):\n    print('Hello World')\n    return 'Hello World'\n"
    filename = "lambda_function_payload.js"
  }
}