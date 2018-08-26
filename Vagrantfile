# -*- mode: ruby -*-
# vi: set ft=ruby :

$network_base="192.168.33"
$masterserver_ip="#{$network_base}.10"
$gameserver_count=1

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.synced_folder ".", disabled: true

  config.vm.define "masterserver" do |master|
    master.vm.synced_folder "provision/PwnAdventure3Servers/MasterServer", "/opt/master"
    master.vm.synced_folder "provision/shared", "/opt/shared"
    master.vm.network "private_network", ip: $masterserver_ip
    master.vm.provider "virtualbox" do |vb|
      vb.memory = 4096
    end
    master.vm.provision "shell", path: "provision/master.sh", privileged: true
  end

  (11..10+$gameserver_count).each_with_index do |i,index|
    config.vm.define "gameserver_#{index+1}" do |game|
      game.vm.provision "file", source: "provision/PwnAdventure3Servers/GameServer", destination: "/tmp/game"
      game.vm.synced_folder "provision/shared", "/opt/shared"
      game.vm.network "private_network", ip: "#{$network_base}.#{i}"
      game.vm.provider "virtualbox" do |vb|
        vb.memory = 4096
      end
      game.vm.provision "shell", path: "provision/game.sh", args: "#{$masterserver_ip} #{$network_base}.#{i}", privileged: true
    end
  end
end
