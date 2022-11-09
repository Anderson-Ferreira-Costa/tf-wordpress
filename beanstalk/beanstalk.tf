resource "aws_elastic_beanstalk_application" "this" {
  name = var.application_name
}

resource "aws_elastic_beanstalk_environment" "this" {
  name                = var.environment_name
  application         = aws_elastic_beanstalk_application.this.name
  solution_stack_name = var.solution_stack_name

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "AmazonSSMManagedInstanceCore"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.instance_type
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = var.minsize
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = var.maxsize
  }

}