#!/bin/bash

#Ashay Vipinkumar
#vipinkum@usc.edu

echo -en "\n"
input=$1
if [ $# -ne "1" ]; then
	echo "Usage: $0 YYMMDDtoMMDD, where the argument is the daterange you want."
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
#copy the above file and rename to auto, have it call the new 3day script
#qsubs convertpbs
#change end of pbs file to qsub the check file, in the tempdir if statement in the 3day file
#copy the file name and rename to .auto
#copy over PBS file library imports from the top of 3day
