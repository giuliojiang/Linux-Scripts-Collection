#!/bin/bash 

#================================================ POSTFIX
aptitude -y install postfix postfix-tls sasl2-bin
cd /etc
wget http://io.jstudios.ovh/dl/20130904mailscript/postfix.tgz -O postfix.tgz
rm -rf postfix
tar -zvxf postfix.tgz
rm -rf postfix.tgz
cd /etc/postfix
echo "write your MX domain name then press ENTER" #input domain name
read domain
sed -i 's/tobereplaced/'"$domain"'/g' main.cf #replacement
newaliases
service postfix restart
/etc/init.d/postfix restart
#================================================
#================================================ DOVECOT
cd /etc
aptitude -y install dovecot-common dovecot-pop3d dovecot-imapd 
wget http://io.jstudios.ovh/dl/20130904mailscript/dovecot.tgz -O dovecot.tgz
rm -rf dovecot
tar -zvxf dovecot.tgz
rm -rf dovecot.tgz
/etc/init.d/dovecot restart
service dovecot restart
#================================================

echo "mail server installed. now you need to create mail user accounts. root user cannot be used for emails. any other standard permission user will do. please report any problems on freevps.us forums. You need to reboot the system now."

#this script is totally based on http://www.server-world.info/en/note?os=Debian_7.0&p=mail&f=1
#more information can be found here http://www.server-world.info/en/note?os=Debian_7.0&p=mail&f=1
#SSL settings, VirtualDomains and AntiVirus
