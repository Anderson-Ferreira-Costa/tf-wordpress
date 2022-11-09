resource "aws_db_instance" "this" {
  allocated_storage      = 5
  max_allocated_storage  = 20
  storage_type           = "gp2"
  db_name                = "mydb"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  identifier             = "wordpress"
  username               = "wordpress"
  password               = "wordpress"
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.this.id]
}