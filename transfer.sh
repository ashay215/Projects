#!/bin/bash

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
			echo "Enter 1 to delete, 0 to exit."
			read option
			if [ $option -eq 1 ]; then
				rmdir $FILE
				echo "Removed directory "$FILE
				exit
			else
				echo "Did not delete."
				exit
			fi
	   fi

	else
	   echo "SUCCESS: The File '$FILE' Does Not Exist in rcf-93. Enter 1 to continue to linkage, 0 to exit. Then press [ENTER]"
	   read option
	   if [ $option -eq 1 ]; then
			ln -s /staging/ejr/shared/data/spc/hmi/$FILE $FILE
			echo "linked"
			chgrp astr-ejr $FILE
			chmod 775 $FILE
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




