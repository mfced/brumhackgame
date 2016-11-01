#!/usr/bin/env bash
# ======================== Goal and Rules ======================== #
#  Find all the keys that makes up the password for the password protected .win.rar file in /home/gaben/Game/

# Start the timer by running the . START file
#
# 1. Find the Game folder 
#	-log in as gaben     #Answer: eth0 IP
#       -change directory to gaben's home directory
#
# 2. The first part of the key is inside the file named brumhack.txt
#
# 3. The total number of files that is exactly called mobilefun is the next part of the key
#
# 4. The total number of files that start with Magic then ends with 42 is the next part of the key
#
# 5. The total memory of the machine is the last part of the key
#
# 6. Extract the .rar.win file and type ". END" on the file extracted to stop the timer
#
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
  
  echo "${#mob_loc[@]} mob_loc"
  #mob_loc=(1 8 38 12 99 2)

	#mobilefun total files
  mob_tot=${#mob_loc[@]}

# C) Total number files Magic*42
	#magic42 file location
  COUNTER=0
  LIMIT=$((1 + RANDOM % 100))
  while [  $COUNTER -lt $LIMIT ]; do
  	#echo The counter is $COUNTER
  	magic42_loc[$COUNTER]=$((1 + RANDOM % 100))
  	let COUNTER=COUNTER+1
  	echo $LIMIT
  done

  #magic42_loc=(88 9 8 12 1 4 2)
  #magic42 total files
  magic42_tot=${#magic42_loc[@]} #gets the size of the array as the total
  
# D) Total Memory
	#Set memory to:
  vm_memory=$(vmstat -s | head -1 | sed 's/K total memory//;s/ //' | tr -d '[[:space:]]') #This reads the current vagrant memory
  #vm_memory=501712
  
# key for win will be:  Updated on line 105 for mob_loc and magic42_loc
win_key=$brum_text$mob_tot$magic42_tot$vm_memory
  
  
  #magic42 line initate as a number
  declare -i magic42_line
# =======================================================  Script ============================================================================

# Add user that has the Game folder and a read/write access to it.
useradd -m -s /bin/bash -U gaben 

# To zip files
apt-get -y install rar

# Add gaben to root group
usermod -g root gaben

mkdir /home/gaben/Game
chmod 0770 /home/gaben/Game
cp /vagrant/START /home/gaben/
touch /home/gaben/.challenger
chmod 0777 /home/gaben/.challenger
#Change password user
echo "gaben:$gabenIP"|chpasswd


cd /home/gaben/Game
#touch .win
# 1 - 100 directories
for num in {1..100}; do

    # create and navigate to new folder
    mkdir $num
    cd $num
    # make files named in var_filenames on each directory
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
# Winning commands
    mob_tot=$(find . -name mobilefun | wc -l)
    magic42_tot=$(find . -name magic*42 | wc -l)
    win_key=$brum_text$mob_tot$magic42_tot$vm_memory

    echo "mob tot: $mob_tot"
    cd /home/gaben/Game
    
    # Generate winning key
    touch .win
    echo "$win_key" >> .win
     
    echo ".win password is $win_key" 
    
    rar a -p$win_key .win.rar /vagrant/END
    cd /home/gaben/ 

    rm /home/gaben/Game/.win

    # Hide vm as a vagrant box
#    umount /vagrant
#    usermod -l mobilefun_user -m -d /home/mobilefun_user vagrant
#    groupmod -n mobilefun_user vagrant

    #change root password 
    echo "root:cedricgumpic619"|chpasswd
