#!/bin/bash

apt-get update -y
apt-get install -y postgresql postgresql-contrib tmux screen
update-rc.d postgresql enable
service postgresql start

sudo -u postgres bash <<EOF
createdb root
createuser -s root
EOF

createdb master
psql master -f /opt/master/initdb.sql

cd /opt/master
./MasterServer --create-server-account > /opt/shared/service_account.txt
./MasterServer --create-admin-team Admins > /opt/shared/admin_team_hash.txt

echo "@reboot   screen -d -m -S 'master_server' bash -c 'cd /opt/master && ./MasterServer'" > /etc/cron.d/masterserver
screen -d -m -S 'master_server' bash -c 'cd /opt/master && ./MasterServer'
