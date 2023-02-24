FROM debian:stable-slim

ENV KOHA_DOMAIN    hive13.org
ENV DEBIAN_FRONTEND noninteractive

# Install base packages
RUN apt-get update && \
    apt-get install -y wget gnupg2 vim apache2 dialog mariadb-server mariadb-client tzdata supervisor

# Add the Koha package repo for the latest stable version
RUN wget -qO - https://debian.koha-community.org/koha/gpg.asc | gpg --dearmor -o /usr/share/keyrings/koha-keyring.gpg
RUN echo 'deb [signed-by=/usr/share/keyrings/koha-keyring.gpg] http://debian.koha-community.org/koha stable main' | tee /etc/apt/sources.list.d/koha.list

# Install Koha
RUN apt-get update && \
    apt-get install -y koha-common && \
    apt-get clean

# Edit Koha files as necessary (TODO: mount Koha configs from external volume?)
RUN sed -i -e 's/DOMAIN=.*/DOMAIN=".hive13.org"/g' /etc/koha/koha-sites.conf
RUN sed -i -e 's/INTRASUFFIX=.*/INTRASUFFIX="-at"/g' /etc/koha/koha-sites.conf
RUN sed -i -e 's/INTRAPORT="80"/INTRAPORT="8080"/g' /etc/koha/koha-sites.conf
RUN sed -i -e 's/OPACPORT=.*/OPACPORT="80"/g' /etc/koha/koha-sites.conf

# Setup koha hive13 user & make it happy with log dir permissions
RUN groupadd -g 1001 hive13-koha && \
    useradd hive13-koha -u 1001 -g 1001 -M && \
    mkdir -p /var/log/koha/hive13 && \
    chown -R 1001:1001 /var/log/koha/hive13 && \
    chmod -R og+rw /var/log/koha/hive13 && \
    mkdir -p /var/cache/koha/hive13 && \
    chown -R 1001:1001 /var/cache/koha



# Make apache also listen on port 8080 & fix annoying ServerName warning
RUN echo "Listen 8080" >> /etc/apache2/ports.conf
RUN echo "ServerName 127.0.0.1" >> /etc/apache2/apache2.conf

# Enable required apache mods
RUN a2enmod rewrite cgi headers proxy_http deflate

# Not sure why, but this is needed or mariadb won't properly start
#RUN mysql_install_db when no db is being used

ADD files/entrypoint.sh /opt/koha/entrypoint.sh

EXPOSE 7001 7002 7003
