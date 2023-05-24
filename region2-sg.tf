module "web_security_group-2" {
  source = "terraform-aws-modules/security-group/aws"
  
  providers = {
    aws = aws.region2
  }

  name        = "harsh-viradia-web-security"
  description = "Harsh-Viradia-web-security"
  vpc_id      = aws_vpc.harsh-viradia-vpc-2.id

  ingress_with_cidr_blocks = [{
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = "0.0.0.0/0" }, #we can add any specific ip here

    {
      from_port = 443
      to_port   = 443
      protocol  = "tcp"
  cidr_blocks = "0.0.0.0/0" }] #we can add any specific ip here

  egress_with_cidr_blocks = [{
    from_port   = -1
    to_port     = -1
    protocol    = "-1"
    cidr_blocks = "0.0.0.0/0"

  }]
  tags = {
    "Name" = "harsh-viradia-web-sg-region-2"
  }
}

module "app_security_group-2" {
  source = "terraform-aws-modules/security-group/aws"

  providers = {
    aws = aws.region2
  }

  name        = "harsh-viradia-app-sg"
  description = "harsh-viradia-app-sg"
  vpc_id      = aws_vpc.harsh-viradia-vpc-2.id

  ingress_with_source_security_group_id = [{
    from_port                = 80
    to_port                  = 80
    protocol                 = "tcp"
    source_security_group_id = "${module.web_security_group-2.security_group_id}"
    }, {
    from_port                = 443
    to_port                  = 443
    protocol                 = "tcp"
    source_security_group_id = "${module.web_security_group-2.security_group_id}"
  }]
  egress_with_cidr_blocks = [{
    from_port   = -1
    to_port     = -1
    protocol    = "-1"
    cidr_blocks = "0.0.0.0/0"
  }]

  tags = {
    "Name" = "harsh-viradia-app-sg-region-2"
  }

}
