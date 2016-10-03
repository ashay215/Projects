#!/bin/bash

input=$1
echo "raw input: "$input
FILE=$input"dpirlrr"
#change to DIRNAME
echo "desired directory: " $FILE

echo -n "Starting directory:"
pwd

function exist {
	if [ -e $input* ]; then
	   echo "ERROR: File '$FILE' Exists. Enter 1 to delete, 0 to exit. "
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
	   echo "The File '$FILE' Does Not Exist. Enter 1 to create, 0 to exit. Then press [ENTER]"
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
	   echo "ERROR: File '$FILE' Exists."
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
	   echo "SUCCESS: The File '$FILE' Does Not Exist. Enter 1 to continue, 0 to exit. Then press [ENTER]"
	   read option
	   if [ $option -eq 1 ]; then

	   else

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
exist2
