#!/bin/bash

#通用系统初始化脚本

#!/bin/bash

echo "关闭防火墙"
systemctl stop firewalld.service
systemctl disable firewalld.service

echo "关闭postfix"
systemctl stop postfix.service
systemctl disable postfix.service

echo "关闭selinx"
sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config

echo "同步北京时间"
timedatectl set-timezone Asia/Shanghai
yum install ntpdate -y
systemctl start ntpdate.service
systemctl enable ntpdate.service
ntpdate -u cn.pool.ntp.org

echo "文件打开数设置"
echo "
* soft noproc 65536
* hard noproc 65536
" >> /etc/security/limits.conf

#echo "网卡配置"
#sed -i "s/BOOTPROTO=none/BOOTPROTO=static/g" /etc/sysconfig/network-scripts/ifcfg-eth0
#sed -i "s/ONBOOT=no/ONBOOT=yes/g" /etc/sysconfig/network-scripts/ifcfg-eth0
#echo "
##IPADDR=100.87.0.
#NETMASK=255.255.255.0
#GATEWAY=100.87.0.1
#" >> /etc/sysconfig/network-scripts/ifcfg-eth0
#ifdown eth0
#ifup eth0

echo "配置DNS"
echo "nameserver 100.87.0.103
nameserver 100.87.0.104
" >> /etc/resolv.conf

echo "安装zabbix"
rpm --import http://repo.zabbix.com/RPM-GPG-KEY-ZABBIX
rpm -Uv http://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-release-4.0-1.el7.noarch.rpm
rpm -Uv http://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-agent-4.0.1-1.el7.x86_64.rpm
sed -i "s/ServerActive=127.0.0.1/ServerActive=100.87.0.106/g" /etc/zabbix/zabbix_agentd.conf
sed -i "s/Server=127.0.0.1/Server=100.87.0.106/g" /etc/zabbix/zabbix_agentd.conf
systemctl restart zabbix-agent.service
