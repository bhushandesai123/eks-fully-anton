resource "aws_subnet" "pub-1a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
availability_zone = local.az1                  # this line i have add
map_public_ip_on_launch = true                   # this line i have add- and  in a subnet, the map_public_ip_on_launch attribute is used to control whether newly launched instances in that subnet should be assigned a public IP address by default.
                                                
  tags = {
   "kubernetes.io/role/elb"	= "1"                  # this line i have add===This tag is used by the AWS Load Balancer Controller to automatically discover which subnets can be utilized for creating Elastic Load Balancers (ELBs).If tags are not present, you encounter errors-"could not find any suitable subnets for creating the ELB" 
      Name = "${local.eks_name}-public-sub-1a"        # this line i have add
   "kubernetes.io/cluster/${local.eks_name}"=	"owned"      # this line i have add

  }
}

resource "aws_subnet" "pvt-1a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
availability_zone = local.az1                  
  tags = {
   "kubernetes.io/role/internal-elb"	= "1"           # tag allows the AWS Load Balancer Controller to automatically discover which subnets can be used for creating internal load balancers (e.g., Network Load Balancers or Application Load Balancers with an internal scheme).
      Name = "${local.eks_name}-pvt-sub-1a"           # When you create a Kubernetes service of type LoadBalancer with the appropriate annotations, the AWS Load Balancer Controller automatically provisions an internal load balancer.
   "kubernetes.io/cluster/${local.eks_name}"=	"owned"  # However, it relies on the kubernetes.io/role/internal-elb tag to determine which subnets are suitable for the internal load balancer.It ensures that only resources belonging to the cluster are considered for operations like scaling and load balancing, which helps maintain a clean and efficient infrastructure setup.

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
   "kubernetes.io/cluster/${local.eks_name}"=	"owned"     #  tag indicates that the resources (like security groups and subnets) are owned by the specified Kubernetes cluster.
  }
}



































# kubernetes.io/cluster/my-cluster=shared  =  This tag enables multiple EKS clusters to use the same subnets, allowing for efficient resource sharing and management across different clusters within the same VPC.
# The annotation kubernetes.io/role/internal-elb: "1"  = designates a node for internal ELB use in a Kubernetes cluster, facilitating efficient traffic distribution within the cluster's private network for enhanced communication between services.
# in a subnet, the map_public_ip_on_launch = attribute is used to control whether newly launched instances in that subnet should be assigned a public IP address by default.









