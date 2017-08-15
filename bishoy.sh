#!/bin/bash

# RUN AS SUDO

apt update
apt install apache2 python-pip -y

pip install django
pip install virtualenv

django-admin startproject projectname /var/www/
