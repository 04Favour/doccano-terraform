resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.doccano_vpc.id
    tags = {Name = "doccano-igw"}
}