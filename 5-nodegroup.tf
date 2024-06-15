resource "aws_eks_node_group" "example" {
  cluster_name    = "${local.env}-${local.eks_name}"     
  node_group_name = "example"
  node_role_arn   = aws_iam_role.example-1.arn
  subnet_ids      = [aws_subnet.pvt-1a.id, aws_subnet.pvt-1a.id]   

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

capacity_type = "ON_DEMAND"
instance_types = ["t2.micro"]
labels = {
    role = "general"
}        

lifecycle {
  ignore_changes = [ scaling_config[0].desired_size ]
}
  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  ]
}










# resource "aws_eks_node_group" "example" {
#   cluster_name    = "${local.env}-${local.eks_name}"                # add this urself . So give  name 
#   node_group_name = "example"
#   node_role_arn   = aws_iam_role.example.arn
#   subnet_ids      = aws_subnet.example[*].id                        # add this urself. so give in ARRAY, MEAN [] GIVE SUBNET IN SQUARE BLOCK. u may use single zone to reduce cost also but there is small chance of failure

#   scaling_config {                                               # this will create auto scaling group check on aws
#     desired_size = 1                                       # desired size property in ASG updated on aws by eks autoscaler
#     max_size     = 2
#     min_size     = 1
#   }

#   update_config {
#     max_unavailable = 1
#   }
# capacity_type = "ON_DEMAND"                # add this urself
# instance_types = "t2.micro"                # add this urself
# labels = {                                 # add this urself. we can use them on pod affinity and node selectors
#     role = "general"
# }  
 
# lifecycle {                                               # add this urself. so when scaling happen due to auto-scaler terraform apply command not reverse back scaling to original desired size.            
#   ignore_changes = [ scaling_config[0].desired_size ]
# }
#   # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
#   # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
#   depends_on = [
#     aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
#     aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
#     aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
#   ]
# }