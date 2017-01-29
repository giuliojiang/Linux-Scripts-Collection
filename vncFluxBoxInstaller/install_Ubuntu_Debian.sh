#!/bin/sh
apt-get update
apt-get -y upgrade
apt-get -y install tightvncserver xterm fluxbox iceweasel
update-menus
apt-get -y install xfonts-base xfonts-75dpi xfonts-100dpi
cd ~
mkdir .vnc
cd .vnc
wget -O xstartup http://pastie.org/pastes/4781064/download
chmod +x xstartup
echo "Installation finished. If everything went right, now you will be asked to set a new 8-character password for VNCserver"
vncserver
