module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  
  name = local.name
  cidr = "10.0.0.0/16"

  azs             = ["${local.region}a", "${local.region}c"]
  public_subnets  = ["10.0.11.0/24", "10.0.12.0/24"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

  public_subnet_names  = ["Public Subnet 1a", "Public Subnet 1c" ] 
  private_subnet_names = ["private Subnet 1a", "private Subnet 1c"] 

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway   = true
}

//復習2回目

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.name
  cidr = "10.0.0.0/16"

  azs             = ["${local.name}a", "${local.name}c"]
   public_sunets  = ["10.0.11.0/24", "10.0.12.0/24"]
   private_sunets  = ["10.0.1.0/24", "10.0.2.0/24"]

   public_subnet_names  = ["Public Subnet 1a", "Public Subnet 1c"]
   private_subnet_names  = ["Private Subnet 1a", "Private Subnet 1c"]

   enable_dns_hostnames = true
   enable_dns_support   = true

   enable_nat_subnets   = true


   }

