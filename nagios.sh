 # shellcheck disable=SC1114
 #!/bin/bash
     cd ~
     apt-get update -y
     apt-get upgrade -y
     sudo apt install wget unzip curl openssl build-essential libgd-dev libssl-dev libapache2-mod-php php-gd php apache2 -y
     wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.6.tar.gz
     sudo tar -zxvf nagios-4.4.6.tar.gz
     cd nagios-4.4.6
     sudo ./configure
     sudo make all
     sudo make install-groups-users
     sudo usermod -a -G nagios www-data
     sudo make install
     sudo make install-init
     sudo make install-commandmode
     sudo make install-config
     sudo make install-webconf
     sudo a2enmod rewrite
     sudo a2enmod cgi
     sudo systemctl restart apache2
     sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
     sudo tar -zxvf nagios-plugins-2.3.3.tar.gz
     cd nagios-plugins-2.3.3/
     sudo ./configure --with-nagios-user=nagios --with-nagios-group=nagios
     sudo make
     sudo make install
     sudo /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
     sudo systemctl start nagios
     sudo systemctl enable nagios