
resource "aws_api_gateway_rest_api" "apig" {
  name        = var.api_name
  description = "API Gateway for Counter"
}

resource "aws_api_gateway_resource" "product" {
  rest_api_id = aws_api_gateway_rest_api.apig.id
  parent_id   = aws_api_gateway_rest_api.apig.root_resource_id
  path_part   = "product"
}

resource "aws_api_gateway_method" "createproduct" {
  rest_api_id   = aws_api_gateway_rest_api.apig.id
  resource_id   = aws_api_gateway_resource.product.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "createproduct-lambda" {
  rest_api_id = aws_api_gateway_rest_api.apig.id
  resource_id = aws_api_gateway_method.createproduct.resource_id
  http_method = aws_api_gateway_method.createproduct.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.adt_lambda_counter.invoke_arn
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.adt_lambda_counter.function_name
  principal     = "apigateway.amazonaws.com"

  # The "/*/*" portion grants access from any method on any resource
  # within the API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.apig.execution_arn}/*/POST/product"
}


resource "aws_api_gateway_deployment" "apigdeploy" {
  depends_on = [
    aws_api_gateway_integration.createproduct-lambda,
  ]

  rest_api_id = aws_api_gateway_rest_api.apig.id
  stage_name  = "Deploy"
}



output "base_url" {
  value = aws_api_gateway_deployment.apigdeploy.invoke_url
}

