#!/bin/bash

host_ip=192.168.1.52
host_name=public-1-52
host_domain_name=public-1-52.com

yum install sendmail

sed -i "s/Addr=127.0.0.1/Addr=$host_ip/g" /etc/mail/sendmail.cf

echo "$host_ip $host_name $host_domain_name " >> /etc/hosts

systemctl enable sendmail.service
systemctl start sendmail.service
