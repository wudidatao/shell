#!/bin/bash
ip=`python -c 'import get_ip;print get_ip.get_ip()'`
echo $ip
