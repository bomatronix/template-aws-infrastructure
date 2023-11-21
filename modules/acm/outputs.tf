output "certificate_arn" {
  value = aws_acm_certificate_validation${}.certificate.arn
  description = "value of the certificate arn"
}