#!/usr/bin/env bash
#IP address as gaben's password
gabenIP=10.0.12.12

# A) In file named brumhack.txt
#Brumhack file location
brum_loc=4
#Brumhack contents
brum_text="dg"

# B) Total number files called mobilefun
#mobilefun file location
mob_loc=(1 8 38 12 99 2)
#mobilefun total files
mob_tot=6

# C) Total number files Magic*42
#magic42 file location
magic42_loc=(88 9 8 12 1 4 2)
#magic42 total files
magic42_tot=8

# D) Total Memory
#Set memory to:
vm_memory=501712

# key for win will be:
win_key=$brum_text$mob_tot$magic42_tot$vm_memory

useradd -m -s /bin/bash -U gaben 
apt-get -y install rar
usermod -g root gaben
mkdir /home/gaben/Game
chmod 0770 /home/gaben/Game
echo "gaben:$gabenIP"|chpasswd
cd /home/gaben/Game
#touch .win
for num in {1..100}; do
    mkdir $num
    cd $num
    # make files named in var_filenames on all directory
    cat /vagrant/var_filenames | xargs touch
    # make brumhack.txt on specified directories given in brum_loc
    if [ "$brum_loc" -eq "$num" ]
    then
	touch brumhack.txt
	echo "$brum_text" >> brumhack.txt
        echo "num is $num"
    fi

    # make mobilefun file on specified directories given in mob_loc
    for num1 in {0..8}; do
	    if [ "${mob_loc[$num1]}" == "$num" ]
#	    if [ "${mob_loc[1]}" -eq "$num" ]
	       echo "num1 is $num1 and num is $num"
	    then
		touch mobilefun
	    fi
	
	    if [ "${magic42_loc[$num1]}" == "$num" ]
	    then
		cat /vagrant/var_magic42names | xargs touch
	    fi
    done
    cd /home/gaben/Game
done 
    
    cd /home/gaben/Game
    touch .win
    echo "$win_key" >> .win
#    rm .win 
    
    echo ".win password is $win_key" 

    rar a -p$win_key .win.rar .win 
    cd /home/gaben/ 
#    rar a -pcedric Game.rar Game/* 

    rm /home/gaben/Game/.win
#   ip addr add 192.168.50.5 dev eth1
#    ifconfig eth0 $gabenIP netmask 255.255.255.0
#    rm -R /home/vagrant/Game/
#    rm /h
#    cd /home/vagrant/ &

#    rar a -pcedric Game.rar Game/*

#apt-get update
#apt-get install -y apache2
#if ! [ -L /var/www ]; then
#  rm -rf /var/www
#  ln -fs /vagrant /var/www
#fi

