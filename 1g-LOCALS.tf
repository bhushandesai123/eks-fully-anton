locals{
    env= "dev"
region = "ap-south-1"
az1 = "ap-south-1a"
az2 = "ap-south-1b"
eks_name = "dhairya-cluster"
eks_version= "1.29"               
}






#notes
# locals{
#     env= "dev"
# region = "ap-south-1"
# az1 = "ap-south-1a"
# az2 = "ap-south-1b"
# eks_name = "dhairya-cluster"  #####just in case there are multiple eks cluster on same account then we can use this cluster name as prefix to iam role and policy
# eks_version= "1.29"
# }

# provider "aws" {
#     region = local.region                    
# }

# resource "aws_internet_gateway" "gw" {
#   vpc_id = aws_vpc.main.id

#   tags = {
#     Name = "${local.eks_name}-igw"
#   }
# }


# Q=why need $ symbol to pull local variable but not need in above case?

#   region = local.region  == here we use actual value in local variable
#   Name = "${local.eks_name}-igw" === here we add local value with hard code -igw to connect loval var and hard coded igw we need $ sign