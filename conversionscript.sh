#!/bin/bash

#Ashay Vipinkumar
#vipinkum@usc.edu

#The MDI (Michelson Doppler Imager) is an instrument on the NASA/ESA spacecraft
#SOHO(Solar and Heliospheric Observatory), currently orbiting the Earth-Sun
#Lagrangian Point L1. The SOHO measures velocity and magnetic fields
#in the Sun's photosphere.
#This script converts MDI number (used to keep track of batches of data dumps)
#to YYMMDD date and vice versa,allowing for aid in calculation, quick reference
#to either value, or aid in further processing. 
#Takes an optional second argument with MDI number, daterange length
#and then returns the YYMMDDtoMMDD format

mdistart="6328"
startyear="10"
startmonth="4"
startday="30"
input=$1
leapyear=false
month31=false
dat3="0"

function leapcheck {
    raw=$1
    year2=${raw:0:2}
    year="20"
    year+=$year2
	
    let year4="$year % 4"
	let year100="$year % 100"
	let year400="$year % 400"
	
    if [ "$year4" -ne "0" ]; then
        leapyear=false
    elif [ "$year100" -ne "0" ]; then
        leapyear=true
    elif [ "$year400" -ne "0" ]; then
        leapyear=false
    else
        leapyear=true
    fi
}
function monthcheck {
    month=$1
    let month2="$month % 2"
	if [[ "$month" -lt "8" ]]; then
		if [[ "$month2" -eq "0" ]]; then
			month31=false
		else
			month31=true
		fi
	else
		if [[ "$month2" -eq "0" ]]; then
			month31=true
		else
			month31=false
		fi
	fi
}
function febcheck {
	if [[ "$MM" -eq "2" ]]; then
		leapcheck $YY 	
		if [[ "$leapyear" = false ]]; then
			if [[ "$DD" -gt "28" ]]; then
				MM="3"
				DD="1"
			fi
		else
			if [[ "$DD" -gt "29" ]]; then
				MM="3"
				DD="1"
			fi	
		fi		
	fi
}

function mdif {
	if [[ "$1" -lt "6328" ]]; then
		echo "Invalid day number."
		exit
	fi	
	let mdidiff="($1 - $mdistart)"
	counter=$mdidiff
	YY=$startyear
	MM=$startmonth
	DD=$startday
	while [[ "$counter" -ne "0" ]]; do
		if [[ "$MM" -le "12" ]]; then #checking for year
			#checking for other months
			monthcheck $MM
			if [[ "$month31" = true ]]; then
				if [[ "$DD" -le "31" ]]; then 			
					let DD="$DD + 1"
					let counter="$counter - 1"
					if [[ "$DD" -gt "31" ]]; then
						let MM="$MM + 1" 
						DD="1"
					fi
					if [[ "$MM" -gt "12" ]]; then
						let YY="$YY + 1"
						MM="1"
						DD="1"
					fi
				else
					let MM="$MM + 1" 
					DD="1"
				fi	
			else
			
				if [[ "$DD" -le "30" ]]; then
					let DD="$DD + 1"
					let counter="$counter - 1"
					if [[ "$DD" -gt "30" ]]; then
						let MM="$MM + 1" 
						DD="1"
					fi
				else
					let MM="$MM + 1" 
					DD="1"
				fi	
			fi
		else
			let YY="$YY + 1"
			MM="1"
			DD="1"	
		fi
		
		febcheck
	done	
	
	if [[ ${#DD} -ne "2" ]]; then
		DD="0"$DD
	fi	
	if [[ ${#MM} -ne "2" ]]; then
		MM="0"$MM
	fi	
	
	dat3=$YY$MM$DD
}
function datef {
	dat=$1
	count="0"
	dat2="temp"
	mdidate="10430"
	
	YY=${dat:0:2}
	MM=${dat:2:2}
	if [[ ${MM:0:1} -eq "0" ]]; then
		MM="${MM:1:1}"
	fi	
	DD=${dat:4:2}
	if [[ ${DD:0:1} -eq "0" ]]; then
		DD="${DD:1:1}"
	fi
	
	if [[ "$YY$MM$DD" = "$mdidate" ]]; then
		echo "MDI Day Number:"$mdistart
		exit
	fi
	if [[ "$YY" -le "10" && "$MM" -le "4" && "$DD" -le "29" ]]; then
		echo "Invalid date."
		exit
	fi
	
	
	
	while [[ "$dat2" != "$mdidate" ]]; do
		let DD="$DD - 1"
		let count="$count + 1"
		monthcheck $MM
		if [[ "$month31" = true ]]; then
			if [[ "$DD" -lt "1" ]]; then
				if [[ "$MM" -eq "8" ]]; then #for August
					let MM="$MM - 1"
					DD="31"
				
				elif [[ "$MM" -eq "3" ]]; then #for February
					let MM="$MM - 1"
					leapcheck $YY
					if [[ "$leapyear" = true ]]; then
						DD="29"
					else
						DD="28"
					fi
				else 					
					let MM="$MM - 1"
					if [[ "$MM" -lt "1" ]]; then
						let YY="$YY - 1"
						MM="12"
						DD="31"
					else
						DD="30"
					fi
				fi	
			fi
		else #30 days in this month
			if [[ "$DD" -lt "1" ]]; then
				let MM="$MM - 1"			
				DD="31"
			fi	
		fi
		
		dat2=$YY$MM$DD
		
	done
	
	let mdi="$mdistart + $count"
}

if [ ${#input} = "4" ]; then
#MDI to YYMMDD
    mdif $input 
	echo "YYMMDD:"$dat3
	
else
#YYMMDD to MDI
	datef $input  
	echo "MDI Day Number:"$mdi
	exit
fi

if [ $# -eq "2" ]; then
	length=$2
	let newmdi="$input + $length - 1"
	olddat=$dat3
	mdif $newmdi
	newdat=${dat3:2:4}
	echo "Daterange:" $olddat"to"$newdat
fi

