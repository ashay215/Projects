#!/bin/bash

#Ashay Vipinkumar
#vipinkum@usc.edu

filename='ranges.dat'
filelines=`cat $filename`
echo Start
for line in $filelines ; do
   # echo $line
    goto1='/home/rcf-93/data/spc/hmi/'
    goto2='dpirlrr'
    gotofinal=$goto1$line$goto2
    #echo $gotofinal
    cd $gotofinal
		dr=$line

		if [ $PWD != /home/rcf-93/data/spc/hmi/${dr}dpirlrr ]; then
			echo "ERROR:Should be /home/rcf-93/data/spc/hmi/${dr}dpirlrr. Instead it is: " $PWD
			exit
		fi

		count=$( (ls | wc) | awk '{print $1}' )
		#echo $count
		#echo $i
		if [ "$count" -eq 2003 ]; then
			echo "Daterange "${dr}" complete!"
		else
			echo "Error! Daterange "${dr}" did not produce 2003 files from conversion!"
		fi
done
