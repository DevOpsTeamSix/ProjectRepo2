resource "aws_security_group" "jumpsg" {
    name = "Jump-Server-SG"
    vpc_id = "vpc-0156bfca952dbe480"

ingress {
    description = "SSH Traffic From MyIP"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["172.31.2.192/32"]
}

ingress {
    description = "HTTP Traffic"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

ingress {
    description = "ICMP Traffic"
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
}

egress {
    description = "Outbound Rules"
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
}
}

output "sg_id" {
    value = aws_security_group.jumpsg.name
}
