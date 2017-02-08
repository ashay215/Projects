#!/bin/bash

#Ashay Vipinkumar
#vipinkum@usc.edu

cd /home/rcf-93/data/spc/hmi/convert_fits_move-scratch_PBSFILES
echo -en "\n"
input=$1
if [ $# -ne "1" ]; then
	echo "Usage: ./conversion-run_XX-dr_YYMMDDtoMMDD YYMMDDtoMMDD, where the argument is the daterange you want."
	exit
fi

echo "raw input: "$input
echo -n "Starting directory:"
pwd

cd /home/rcf-93/data/spc/hmi/convert_fits_move-scratch_PBSFILES
if [ $PWD != /home/rcf-93/data/spc/hmi/convert_fits_move-scratch_PBSFILES ]; then
	echo "ERROR:Should be /home/rcf-93/data/spc/hmi/convert_fits_move-scratch_PBSFILES. Instead it is: " $PWD
	exit
else
  echo "Successfully moved to: /home/rcf-93/data/spc/hmi/convert_fits_move-scratch_PBSFILES "
fi

./convert_fits_move-scratch-YYMMDDtoMMDD.sh $input

./conversion-run_XX-dr_YYMMDDtoMMDD_check $input
