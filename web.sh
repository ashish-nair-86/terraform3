#!/bin/bash
yum install httpd -y
systemctl start httpd --now
echo "hello from India" > /var/www/html/index.html
systemctl restart httpd
