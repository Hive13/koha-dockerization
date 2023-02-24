#!/bin/bash


# Setup apache2 sites
a2dissite 000-default.conf
a2ensite hive13.conf

# Start required services (TODO: use supervisor instead?)
service mariadb start
service memcached start


# Start apache2 in foreground

