FROM ubuntu:16.04
MAINTAINER Daniel Samson <daniel.samson@salesagility.com>

# Setup environment
ENV DEBIAN_FRONTEND noninteractive

# Update sources
RUN apt-get update -y

RUN apt-get install -y apache2 curl

# install http
RUN apt-get install -y apache2 vim bash-completion unzip
RUN mkdir -p /var/lock/apache2 /var/run/apache2
RUN a2enmod rewrite
RUN rm -f /var/www/html/index.html

# install mysql
RUN echo 'mysql-server mysql-server/root_password password changeme' | debconf-set-selections
RUN echo 'mysql-server mysql-server/root_password_again password changeme' | debconf-set-selections
RUN apt-get install -y mysql-client mysql-server

# install php
RUN apt-get install -y apache2-mod-php7.0 php7.0 php7.0-bcmath php7.0-bz2 php7.0-cgi php7.0-cli php7.0-common php7.0-curl php7.0-dba php7.0-dev php7.0-enchant php7.0-fpm php7.0-gd php7.0-gmp php7.0-imap php7.0-interbase php7.0-intl php7.0-json php7.0-ldap php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-odbc php7.0-opcache php7.0-pgsql php7.0-phpdbg php7.0-pspell php7.0-readline php7.0-recode php7.0-snmp php7.0-soap php7.0-sqlite3 php7.0-sybase php7.0-tidy php7.0-xml php7.0-xmlrpc php7.0-xsl php7.0-zip php-xdebug
ADD 30-xdebug.ini /etc/php/7.0/apache2/conf.d/
ADD 30-xdebug.ini /etc/php/7.0/cli/conf.d/

# install git
RUN apt-get --yes --force-yes install git

#comsposer
RUN curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

# install supervisord
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor

#ADD phpinfo.php /var/www/html/
ADD supervisord.conf /etc/
EXPOSE 80 443

CMD ["supervisord", "-n"]