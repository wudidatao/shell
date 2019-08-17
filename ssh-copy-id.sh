#!/bin/bash
#批量节点的单向免密登录

#如果没有创建公钥，则执行，如果创建过，则注释，生产慎用
#ssh-keygen -t rsa -P ''

#发送公钥到以下指定的机器上
IP="
192.168.1.110
192.168.1.111
"
#如果机器是顺序数量很大直接用这个
#for ip in 192.168.100.{191..194}

#依次循环登录认证
for ip in $IP;
do
  ssh-copy-id root@$ip
  echo $ip"拷贝成功"
  ssh root@$ip
  echo $ip"登录成功"
done
