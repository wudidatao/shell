#!/bin/bash

new_NIC_name=eth0
old_NIC_name=`ls /etc/sysconfig/network-scripts/ | grep ifcfg | grep -v ifcfg-lo | cut -d "-" -f2`

#修改网卡配置文件内容
sed -i "s/$old_NIC_name/$new_NIC_name/g" /etc/sysconfig/network-scripts/ifcfg-$old_NIC_name

#修改网卡配置文件名
mv /etc/sysconfig/network-scripts/ifcfg-$old_NIC_name /etc/sysconfig/network-scripts/ifcfg-$new_NIC_name

#先删除内核文件网卡配置这行（生产慎用，代码核对相同后再执行，以后有空再说）
sed -i "/GRUB_CMDLINE_LINUX/d" /etc/default/grub

#再重新增加（生产慎用，代码核对相同后再执行，以后有空再说）
echo "GRUB_CMDLINE_LINUX=\"crashkernel=auto rd.lvm.lv=centos/root rd.lvm.lv=centos/swap rhgb quiet net.ifnames=0\""  >> /etc/default/grub

#文件生效
grub2-mkconfig -o /etc/grub2.cfg

#重启
reboot
