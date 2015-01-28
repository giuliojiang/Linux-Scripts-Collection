#!/bin/sh
yum -y install xterm tigervnc-server
rpm -ivh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-7.noarch.rpm
yum -y install fluxbox
vncserver
vncserver -kill :1
cd ~
cd .vnc
wget -O xstartup http://pastie.org/pastes/4781064/download
chmod +x xstartup
echo "Installation finished. Run vncpasswd to change vnc password and vncserver to start the server"
