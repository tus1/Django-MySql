#!/bin/bash
#Setup MYSQL, DJANGO, PYTHON , and  ...
sudo apt update > /dev/null 2>&1

# MYSQL non-interactive 
echo "*********************** INSTALL debconf-utils **************************** "
sudo apt-get install debconf-utils > /dev/null 2>&1

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password RT_AWS'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password RT_AWS'
echo "*********************** INSTALL mysql-server **************************** "
sudo apt-get install mysql-server > /dev/null 2>&1

echo "*********************** INSTALL mysql_secure_installation *****************"

sudo apt-get -y install expect > /dev/null 2>&1

SECURE_MYSQL=$(expect -c "
set timeout 10
spawn mysql_secure_installation
expect \"Enter current password for root (enter for none):\"
send \"$RT_AWS\r\"
expect \"Change the root password?\"
send \"n\r\"
expect \"Remove anonymous users?\"
send \"y\r\"
expect \"Disallow root login remotely?\"
send \"y\r\"
expect \"Remove test database and access to it?\"
send \"y\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")

echo "$SECURE_MYSQL"
sudo apt-get -y purge expect > /dev/null 2>&1

echo "*********************** INSTALL OTHERS ************************************"
sudo apt install python-pip python-dev libmysqlclient-dev apache2 -y   > /dev/null 2>&1
sudo apt install apache2-utils libexpat1 ssl-cert libapache2-mod-wsgi -y > /dev/null 2>&1


echo "*********************** Restart Apache2 ************************************"
sudo service apache2 restart
