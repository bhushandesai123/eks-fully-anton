# EKS Cluster with Access Config ----this is last code on terra eks_cluster resource so not copy 1st but go below to get this code
# or search  directly on registry --- (EKS Cluster with Access Config)

resource "aws_eks_cluster" "example" {
  name     = "${local.env}-${local.eks_name}"
  role_arn = aws_iam_role.example.arn



  vpc_config {
    subnet_ids = [aws_subnet.pvt-1a.id, aws_subnet.pvt-1b.id]       #### here 1 public subnet must because if not given LB created will be internal LB which not connected to internet
  }



  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
  ]
access_config {                                             ########         read #P1 below @ this
  authentication_mode = "API"
  bootstrap_cluster_creator_admin_permissions= true
}
}
output "endpoint" {
  value = aws_eks_cluster.example.endpoint
}



# resource "aws_eks_cluster" "demo" {
#   name     = "demo"
#   version  = "${local.eks_version}"     # by changing its value in local variable and use terra apply to update eks cluster version  
#   role_arn = aws_iam_role.demo.arn


#   vpc_config {
#     endpoint_private_access = false     # if true given then eks controlplane will be made in pvt subnets . some clients rarely demand this in rare conditions
#     endpoint_public_access = true

#     subnet_ids = [
#       aws_subnet.private_us_east_1a.id,
#       aws_subnet.private_us_east_1b.id, # here give subnets in which u want ur worker nodes. SO mostly we give pvt subnet only here
#     # aws_subnet.public_us_east_1a.id,
#     # aws_subnet.public_us_east_1b.id
#     ]
#                                         #   The subnets specified in vpc_config are critical for establishing communication between the worker nodes and the EKS control plane.
#                                         #    They also help configure network settings and security groups, ensuring that your cluster operates correctly within your VPC.
#   }

#   depends_on = [aws_iam_role_policy_attachment.demo_amazon_eks_cluster_policy]
# }
# access_config {                                         # P1 From here access config below 3 lines i added not in terra registry
#   authentication_mode = "API"   (or "CONFIG_MAP")       # aws auth configmap is deprecated so we are using API. but still u can use auth_configmap to create new users but its best practice to use API 
#   bootstrap_cluster_creator_admin_permissions= true     # P3 This may not bydefault true so deun taka . The IAM entity (user or role) that creates the cluster is automatically added to the system:masters group in the Kubernetes cluster.

# }
