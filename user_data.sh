#!/bin/bash
echo "Este es un mensaje" > /home/ec2-user/mensaje.txt
dnf update -y
dnf install httpd -y
systemctl start httpd
systemctl enable httpd