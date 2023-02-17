#export our arn and domian name to reference them in other resources.
output "domain_name" {
    value = var.domain_name
}

output "certificate_arn" {
    value = aws_acm_certificate.acm_certificate.arn
}