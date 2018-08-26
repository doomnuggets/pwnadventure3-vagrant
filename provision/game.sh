#!/bin/bash


masterserver_ip=$1
gameserver_ip=$2

cp -r /tmp/game /opt/game
chown root:root /opt/game

username=$(grep 'Username: ' /opt/shared/service_account.txt | cut -d ' ' -f 2)
password=$(grep 'Password: ' /opt/shared/service_account.txt | cut -d ' ' -f 2)
cat > /opt/game/PwnAdventure3_Data/PwnAdventure3/PwnAdventure3/Content/Server/server.ini <<EOF
[MasterServer]
Hostname=$masterserver_ip
Port=3333

[GameServer]
Hostname=$gameserver_ip
Port=3000
Username=$username
Password=$password
Instances=5
EOF

echo "@reboot   sudo -u pwn3 bash \"cd /opt/game/PwnAdventure3_Data/PwnAdventure3/PwnAdventure3/Binaries/Linux && ./PwnAdventure3Server\"" > /etc/cron.d/gameserver
screen -d -m -S 'game_server' \
    bash -c 'cd /opt/game/PwnAdventure3_Data/PwnAdventure3/PwnAdventure3/Binaries/Linux && ./PwnAdventure3Server'
