#!/bin/bash

#Ashay Vipinkumar
#vipinkum@usc.edu

#The MDI (Michelson Doppler Imager) is an instrument on the NASA/ESA spacecraft
#SOHO(Solar and Heliospheric Observatory), currently orbiting the Earth-Sun
#Lagrangian Point L1. The SOHO measures velocity and magnetic fields
#in the Sun's photosphere.
#This script automates several vital tasks in the data processing undertaken
#by the Helioseismology research group headed by Dr. Edward Joseph Rhodes at
#the USC department of Physics and Astronomy.

echo -en "\n"
input=$1
if [ $# -ne "1" ]; then
	echo "Provide daterange"
	exit
fi

echo "raw input: "$input
FILE=$input"dpirlrr"
#change to DIRNAME
echo "desired directory: " $FILE

echo -n "Starting directory:"
pwd

function exist {
	if [ -e $input* ]; then
	   echo "ERROR: File '$FILE' Exists in staging. Enter 1 to delete, 0 to exit. "
	   read option
	   if [ $option -eq 1 ]; then
			rmdir $FILE
			echo "Removed directory "$FILE
			exit
	   else
			echo "Did not delete."
			exit
	   fi
	else
	   echo "The File '$FILE' Does Not Exist in staging. Enter 1 to create, 0 to exit. Then press [ENTER]"
	   read option
	   if [ $option -eq 1 ]; then
			mkdir $FILE
			chmod ug+rw $FILE
			echo "Created directory "$FILE
	   else
			echo "Did not create."
			exit
	   fi
	fi
}
function exist2 {

	if [ -e $input* ]; then
	   echo "ERROR: File '$FILE' Exists in rcf-93."
	   if test "$(ls -A "$FILE")"; then
			echo "NOT EMPTY. HUMAN OVERSIGHT REQUIRED."
			exit
		else
			echo "EMPTY"
			echo "THIS NEEDS TO BE UNLINKED. ONLY CONTINUE IF YOU KNOW WHAT YOU ARE DOING. ENTER 100 to UNLINK, 0 to exit."
			read option
			if [ $option -eq 100 ]; then
				unlink $FILE
				echo "Unlinked directory "$FILE
				exit
			else
				echo "Did not delete."
				exit
			fi
	   fi

	else
	   echo "SUCCESS: No variation of '$input' exists in rcf-93. Enter 1 to continue to linkage, 0 to exit. Then press [ENTER]"
	   read option
	   if [ $option -eq 1 ]; then
			ln -s /staging/ejr/shared/data/spc/hmi/$FILE $FILE
			echo "linked"
			chgrp astr-ejr $FILE
			echo "chgrp done"
			chmod 775 $FILE
			echo "chmod 775 done"
			exit
	   else
			echo "did nothing. exiting."
			exit
	   fi
	fi
}

cd /staging/ejr/shared/data/spc/hmi
echo "Now in: "$PWD
if [ $PWD != /staging/ejr/shared/data/spc/hmi ]; then
	echo "ERROR:Should be /staging/ejr/shared/data/spc/hmi. Instead it is: " $PWD
	exit
fi

exist

cd /home/rcf-93/data/spc/hmi
echo "Now in: "$PWD
if [ $PWD != /home/rcf-93/data/spc/hmi ]; then
	echo "ERROR:Should be /home/rcf-93/data/spc/hmi. Instead it is: " $PWD
	exit
fi

exist2
