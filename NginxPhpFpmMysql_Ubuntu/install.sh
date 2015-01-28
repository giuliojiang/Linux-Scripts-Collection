

#!/bin/sh
# install basic packages if needed
apt-get update
apt-get -y install nano wget
service apache2 stop

apt-get update

# install Mysql server
apt-get -y install mysql-server

# prevent apache2 from starting by default
mv /etc/rc.local /etc/rc.local.bak
wget -O /etc/rc.local http://pastie.org/pastes/5602974/download

# install php and nginx
apt-get -y install php5 php5-fpm php-pear php5-common php5-mcrypt php5-mysql php5-cli php5-gd
apt-get -y install nginx
wget -O /etc/php5/fpm/php5-fpm.conf http://pastie.org/pastes/5610069/download
/etc/init.d/php5-fpm restart

# creating nginx configuration symlinks
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
rm -rf /etc/nginx/sites-enabled
ln -s /etc/nginx/sites-available /etc/nginx/sites-enabled
# download default .conf
wget -O /etc/nginx/sites-available/default http://pastie.org/pastes/5606313/download
wget -O /etc/nginx/nginx.conf http://pastie.org/pastes/5610068/download
mkdir /var/www
mkdir /var/www/html
rm /var/www/index.html
chown -R www-data:www-data /var/www

# downloading setup-vhost
wget http://pastie.org/pastes/5606377/download -O /bin/setup-vhost
chmod +x /bin/setup-vhost
service nginx restart

clear
echo 'Installation done. Run setup-vhost <hostname> (without www prefix) to create the first vhost'
echo 'Its highly recommended that you reboot your system'
echo 'File /etc/rc.local has been modified. You can find a backup at /etc/rc.local.bak'
echo 'If you have permission problems, run chown www-data:www-data -R /var/www'
echo 'Also, run mysql_secure_installation'


