#!/bin/sh
# install basic packages if needed
apt-get update
apt-get -y install nano wget
service apache2 stop

# adding repositories
echo 'deb http://packages.dotdeb.org squeeze all' >> /etc/apt/sources.list
wget http://www.dotdeb.org/dotdeb.gpg
cat dotdeb.gpg | apt-key add -
rm dotdeb.gpg
apt-get update

# install Mysql server
apt-get -y install mysql-server

# prevent apache2 from starting by default
mv /etc/rc.local /etc/rc.local.bak
wget -O /etc/rc.local http://pastie.org/pastes/5602974/download

# configure mysql
cat > /etc/mysql/my.cnf <<END
[mysqld]
default-storage-engine = myisam
key_buffer = 1M
query_cache_size = 1M
query_cache_limit = 128k
max_connections=25
thread_cache=1
skip-innodb
query_cache_min_res_unit=0
tmp_table_size = 1M
max_heap_table_size = 1M
table_cache=256
concurrent_insert=2 
max_allowed_packet = 1M
sort_buffer_size = 64K
read_buffer_size = 256K
read_rnd_buffer_size = 256K
net_buffer_length = 2K
thread_stack = 64K
END

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

