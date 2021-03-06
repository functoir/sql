#!/bin/bash
# odoo_config.sh
# Bash script to configure odoo installation
#
# Usage: ./odoo_config.sh
#
# Author: Amittai Joel Siavava

# sudo -i
for y in $(locale | cut -d '=' -f 2| sort |uniq ); do
  locale-gen $y; 
done
apt-get update && apt-get upgrade -y
apt-get install postgresql -y
cd /etc/init.d
./postgresql start
su - postgres
psql template1 -c 'SHOW SERVER_ENCODING'
psql postgres -c "update pg_database set datallowconn = TRUE where datname = 'template0';"
psql template0 -c "update pg_database set datistemplate = FALSE where datname = 'template1';"
psql template0 -c "drop database template1;"
psql template0 -c "create database template1 with template = template0 encoding = 'UTF8';"
psql template0 -c "update pg_database set datistemplate = TRUE where datname = 'template1';"
psql template1 -c "update pg_database set datallowconn = FALSE where datname = 'template0';"
psql template1 -c 'SHOW SERVER_ENCODING'
createuser -s odoo
psql -c "alter user odoo with password 'odoo';"
exit
wget -O - https://nightly.odoo.com/odoo.key | apt-key add -
echo "deb http://nightly.odoo.com/11.0/nightly/deb/ ./" >> /etc/apt/sources.list.d/odoo.list
apt-get update && apt-get install odoo -y
./odoo start