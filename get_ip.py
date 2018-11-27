#!/bin/python
import socket
def get_ip():
 hostname = socket.getfqdn(socket.gethostname())
 addr = socket.gethostbyname(hostname).split('.')[2] + '-' + socket.gethostbyname(hostname).split('.')[3]
 return addr
