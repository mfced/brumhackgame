#!/usr/bin/env bash
# =============================================== Variables ================================================
#IP address as gaben's password
gabenIP=10.0.2.15

# A) In file named brumhack.txt
	#Brumhack file location
brum_loc=$((1 + RANDOM % 100))
#brum_loc=4 

	#Brumhack contents
brum_text=$(openssl rand -base64 2)
#brum_text="dg"


# B) Total number files called mobilefun
	#mobilefun file location
COUNTER=0
LIMIT=$((1 + RANDOM % 100))
while [  $COUNTER -lt $LIMIT ]; do
	#echo The counter is $COUNTER
	mob_loc[$COUNTER]=$((1 + RANDOM % 100))
	let COUNTER=COUNTER+1
	echo $LIMIT
done


#for mobnum in "{1..$counter}";do
#	mob_loc[$mobnum]=$((1 + RANDOM % 100))
#	echo $mobnum
#done;  
echo "${#mob_loc[@]} mob_loc"
#mob_loc=(1 8 38 12 99 2)

	#mobilefun total files
mob_tot=${#mob_loc[@]}

# C) Total number files Magic*42
#magic42 file location
magic42_loc=(88 9 8 12 1 4 2)
#magic42 total files
magic42_tot=${#magic42_loc[@]}

# D) Total Memory
#Set memory to:
vm_memory=$(vmstat -s | head -1 | sed 's/K total memory//;s/ //' | tr -d '[[:space:]]')
#vm_memory=501712

# key for win will be:
win_key=$brum_text$mob_tot$magic42_tot$vm_memory

#magic42 line initate as a number
declare -i magic42_line
# =======================================================  Script =========================================================================================

# Add user that has the Game folder and a read/write access to it.
useradd -m -s /bin/bash -U gaben 

# To zip files
apt-get -y install rar

# Add gaben to root group
usermod -g root gaben

mkdir /home/gaben/Game
chmod 0770 /home/gaben/Game

#Change password user
echo "gaben:$gabenIP"|chpasswd


cd /home/gaben/Game
#touch .win
# 1 - 100 directories
for num in {1..100}; do
    mkdir $num
    cd $num
    # make files named in var_filenames on all directory
    cat /vagrant/var_filenames | xargs touch
    # make brumhack.txt on specified directory given in brum_loc
    if [ "$brum_loc" -eq "$num" ]
    then
	touch brumhack.txt
	echo "$brum_text" >> brumhack.txt
        echo "num is $num"
    fi

    # make mobilefun file on specified directories given in mob_loc
    for num1 in {0..100}; do
	    if [ "${mob_loc[$num1]}" == "$num" ]
	    then
		echo "num1: $num1, num: $num, echo: ${mob_loc[$num1]}, mob_loc array: ${#mob_loc[@]}"
		usermod -g root gaben
		touch mobilefun
	    fi
	
	    if [ "${magic42_loc[$num1]}" == "$num" ]
	    then
		magic42_line=$num1+1
		echo "magic42 line is $magic42_line"
		echo "magic42 location is ${magic42_loc[$num1]}"
		sed -n $magic42_line"p" /vagrant/var_magic42names | xargs touch
	    fi
    done

    cd /home/gaben/Game
done 
    vmstat -s | head -1 | sed 's/K total memory//;s/ //' | tr -d '[[:space:]]' 
    mob_tot=$(find . -name mobilefun | wc -l)
    win_key=$brum_text$mob_tot$magic42_tot$vm_memory

    echo "mob tot: $mob_tot"
    cd /home/gaben/Game
    touch .win
    echo "$win_key" >> .win
#    rm .win 
    
    echo ".win password is $win_key" 

    rar a -p$win_key .win.rar .win 
    cd /home/gaben/ 
#    rar a -pcedric Game.rar Game/* 

    rm /home/gaben/Game/.win
    
    echo "root:cedricgumpic619"|chpasswd


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

