data "aws_vpc" "std_vpc" {
    filter {
        name = "tag:Name"
        values = ["managed-vpc"] 
    }
}

data "aws_security_group" "lambda_sg" {
    filter {
        name = "tag:Name"
        values = ["managed-sg"]
    }
}

data "aws_subnets" "private_app_subnets" {
    filter {
        name = "vpc-id"
        values = [data.aws_vpc.std_vpc.id]
    }
    # filter {
    #   name = "tag:Name"
    #   values = []
    # }
}

