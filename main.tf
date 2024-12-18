terraform {
    backend "S3" {
        bucket         = "aws-ecs-terraform-tfstate"
        key            = "terraform.tfstate"
        region         = local.name
        dynamodb_table = "aws-ecs-terraform-tfstate-locking"
        encrypt        = true
    }

   required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.0" 
    }
   }
}

provider "aws {
    region = local.name
}


//復習2回目
terraform {
    backend "s3" {
        bucket         = "aws-ecs-terraform-tfstate"
        key            = "terraform.tfstate"
        region         = "ap-northeast-1"
        dynamodb_table = "aws-ecs-terraform-tfstate-locking"
        encrypt        = true
    }

required_provider {
    aws = {
        source  = "hasicorp/aws"
        version = "~> 4.0"

    }
}
}
provider "aws" {
    region = "ap-northeast-1"
}



