#!/bin/bash
service mysql start
mysql <<EOF
create database dvwa;
create user dvwa@localhost identified by 'p@ssw0rd';
grant all on dvwa.* to dvwa@localhost;
flush privileges;
EOF