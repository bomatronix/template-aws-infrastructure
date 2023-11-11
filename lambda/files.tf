// data archive_file place_hodler
data "archive_file" "place_hodler" {
    type        = "zip"
    source {
        content  = <<EOF
        exports.handler = async (event) => {
            const response = {
                statusCode: 200,
                body: JSON.stringify('Hello from Lambda!'),
            };
            return response;
        };
        EOF
        filename = "index.js"
    }
    output_path = "${path.module}/lambda_function_payload.zip"
}