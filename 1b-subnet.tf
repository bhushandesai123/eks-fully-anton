resource "aws_subnet" "pub-1a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
availability_zone = local.az1                  # this line i have add
map_public_ip_on_launch = true                   # this line i have add- and  in a subnet, the map_public_ip_on_launch attribute is used to control whether newly launched instances in that subnet should be assigned a public IP address by default.
                                                
  tags = {
   "kubernetes.io/role/elb"	= "1"                  # this line i have add
      Name = "${local.eks_name}-public-sub-1a"        # this line i have add
   "kubernetes.io/cluster/${local.eks_name}"=	"owned"      # this line i have add

  }
}

resource "aws_subnet" "pvt-1a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
availability_zone = local.az1                  
  tags = {
   "kubernetes.io/role/internal-elb"	= "1"
      Name = "${local.eks_name}-pvt-sub-1a"
   "kubernetes.io/cluster/${local.eks_name}"=	"owned"

  }
}

resource "aws_subnet" "pub-1b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"                   
availability_zone = local.az2
map_public_ip_on_launch = true

  tags = {
   "kubernetes.io/role/elb"	= "1"
   Name = "${local.eks_name}-public-sub-1b"
   "kubernetes.io/cluster/${local.eks_name}"=	"owned"

  }
}

resource "aws_subnet" "pvt-1b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.4.0/24"
availability_zone = local.az2                
  tags = {
   "kubernetes.io/role/internal-elb"	= "1"
      Name = "${local.eks_name}-pvt-sub-1b"
   "kubernetes.io/cluster/${local.eks_name}"=	"owned"
  }
}




































# The annotation kubernetes.io/role/internal-elb: "1" designates a node for internal ELB use in a Kubernetes cluster, facilitating efficient traffic distribution within the cluster's private network for enhanced communication between services.
# in a subnet, the map_public_ip_on_launch attribute is used to control whether newly launched instances in that subnet should be assigned a public IP address by default.









