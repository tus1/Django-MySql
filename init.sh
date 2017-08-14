#!/bin/sh

#Setup MYSQL, DJANGO, PYTHON , and  ...
sudo apt update
sudo apt install python-pip python-dev mysql-server libmysqlclient-dev apache2 -y
sudo apt install apache2-utils libexpat1 ssl-cert libapache2-mod-wsgi -y

sudo service apache2 restart
