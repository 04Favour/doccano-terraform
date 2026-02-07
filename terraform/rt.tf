resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.doccano_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}

# Associate Subnet
resource "aws_route_table_association" "a" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_rt.id
}