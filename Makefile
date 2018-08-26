release:
	rm -f provision/shared/*.txt
	tar -czf provision/pwn3.tar.gz -C provision PwnAdventure3Servers
	rm -rf provision/PwnAdventure3Servers

build:
	-vagrant destroy --force
	if [ ! -e provision/PwnAdventure3Servers ]; then cd provision/ && tar -xzf pwn3.tar.gz ;fi
	vagrant up masterserver
	vagrant up

client:
	if [ ! -e provision/PwnAdventure3Servers/GameServer/PwnAdventure3_Data/PwnAdventure3/PwnAdventure3/Binaries/Linux/PwnAdventure3-Linux-Shipping ]; \
	then \
		echo 'You need to build the servers first: make build' \
		exit 1 \
	;fi
	mkdir client/
	cp -r provision/PwnAdventure3Servers/GameServer/PwnAdventure3_Data client/
	cp provision/PwnAdventure3Servers/GameServer/PwnAdventure3 client/
	sed -i 's/Username.*/Username=/' client/PwnAdventure3_Data/PwnAdventure3/PwnAdventure3/Content/Server/server.ini
	sed -i 's/Password.*/Password=/' client/PwnAdventure3_Data/PwnAdventure3/PwnAdventure3/Content/Server/server.ini
