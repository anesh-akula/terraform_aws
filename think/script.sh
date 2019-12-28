#! /bin/bash
  sudo yum update
  yum install htttpd -y
  service start httpd
  chkconfig httpd on
echo "<h1> this is testing webpage created by terraform<h1>" > /var/www/html/index.html