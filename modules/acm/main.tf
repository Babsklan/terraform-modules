# request public certificates from the amazon certificate manager.
resource "aws_acm_certificate" "acm_certificate" {
  domain_name               = var.domain_name
  subject_alternative_names = [var.alternative_name]            #How we request an ssl  for our subdomain name
  validation_method         = "DNS"                             #validation method is either by route 53 or Email

  lifecycle {
    create_before_destroy = true
  }
}

# get details about a route 53 hosted zone using data source  (importing form route 53 hosted zone)
data "aws_route53_zone" "route53_zone" {
  name         = var.domain_name
  private_zone = false
}

# create a record set in route 53 for domain validatation  (to show the domain name is ours)
# create a cname to validate
# (line 23) refer to the ssl certificate resource in line #2 and add resource type and reference name to ur variable name
resource "aws_route53_record" "route53_record" {
  for_each = {  
    for dvo in aws_acm_certificate.acm_certificate.domain_validation_options : dvo.domain_name => { 
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.route53_zone.zone_id  #add hosted zone id
}

# validate acm/ssl certificates
resource "aws_acm_certificate_validation" "acm_certificate_validation" {
  certificate_arn         = aws_acm_certificate.acm_certificate.arn          #add ssl certificate arn 
  validation_record_fqdns = [for record in aws_route53_record.route53_record : record.fqdn]   #add route 53 record set
}