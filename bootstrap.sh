#!/usr/bin/env bash
# A) In file named brumhack.txt
#Brumhack file location
brum_loc=4
#Brumhack contents
brum_text="dg"

# B) Total number files called mobilefun
#mobilefun file location
mob_loc=(1 8 38 12 1 2)
#mobilefun total files
mob_tot=6

# C) Total number files Magic*42
#magic42 file location
magic42_loc=(4 9 8 2 1 4 2)
#magic42 total files
magic42_tot=8

# D) Total Memory
#Set memory to:
vm_memory=501708

# key for win will be:
win_key=$brum_text$mob_tot$magic42_tot$vm_memory


mkdir /home/vagrant/Game
cd /home/vagrant/Game
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
    fi
    # make mobilefun file on specified directories given in mob_loc
    if [ "$mob_loc" -eq "$num" ]
    then
	touch mobilefun
    fi

    cd /home/vagrant/Game
    echo $win_key
done


#apt-get update
#apt-get install -y apache2
#if ! [ -L /var/www ]; then
#  rm -rf /var/www
#  ln -fs /vagrant /var/www
#fi

