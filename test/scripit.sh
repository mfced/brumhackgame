#!/bin/bash
COUNTER=0
LIMIT=$((1 + RANDOM % 100))
while [  $COUNTER -lt $LIMIT ]; do
        #echo The counter is $COUNTER
        let COUNTER=COUNTER+1
#	if [ "$((mob_loc[$COUNTER]
        mob_loc[$COUNTER]=$((1 + RANDOM % 100))
        echo $((mob_loc[$COUNTER]))
done

mobilefuns=$(find . -name mobilefun | wc -l)
re='^[0-9]+$'
if ! [[ $mobilefuns =~ $re ]] ; then
   echo "error: Not a number" >&2; exit 1
fi

echo "mob_loc: ${#mob_loc[@]}"
echo $mobilefuns
#if [ "$((mob_loc[1000]))
hi=""
if [ -z "$hi" ]
then
	echo "it is empty"
fi
echo $((mob_loc[1000])) 



#declare -i counter
#counter=$((1 + RANDOM % 100))
## Check number
#re='^[0-9]+$'
#if ! [[ $counter =~ $re ]] ; then
#   echo "error: Not a number" >&2; exit 1
#fi
#
#echo $counter 
#hi=5
#for mobnum in {1..$hi};do
#        mob_loc[$mobnum]=$((1 + RANDOM % 100))
#        echo $mobnum
#done;  
#echo $mob_loc
#
#magic42_line=3
#sed -n $magic42_line"p" var_magic42names
