#!/bin/bash

echo "##### Password Generator #####"
echo "##### Created by: Aman Arya #####"
echo "##### Linkedin: https://www.linkedin.com/in/aman-arya-0/ #####"
echo "##### Website: https://amnrya.blogspot.com/ #####"

#Important Variables
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
selector=0; qurun=0; mgn='\033[0;35m'; red='\033[0;31m' nc='\033[0m'; optnif1=0; optnif2=0; pg=0
# selector = for running options and plen
# qurun = question run for running try_again function
# mgn = magenta
# red = red
# nc = no color
# optnif1 = optional if for echo 
# optnif2 = optional if for clear screen
# pg = password generated 0 for not generated and 1 for generated 
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

##Try Again Function
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
try_again(){
	while [ $qurun -eq 0 ]
	do
		if [ $optnif1 -eq 0 ]
		then
			echo -ne "\e[1mDo you want to try again(t) or quit(q)\e[0m: "
                	read tqselect
                	echo
			if [ $pg -eq 1 ]
			then
				echo -e "Do you want to clear screen?\nPress \e[31m1\e[0m for clear or any digit for don't"
                		read -p "$(echo -e ": ${red}")" optnif2
                		echo -e "${nc}"
			fi
		else
			echo -e "\e[31mYou haven't entered right $paragraph \e[0m"
			echo -ne "\e[1mDo you want to try again(t) or quit(q)\e[0m: "
			read tqselect
			echo
		fi	
		
		#this echo will add new line
		
		if [[ $tqselect == 't' ]]
		then
			eval $varChoice=0
			
			if [ $optnif2 -eq 1 ]
			then
				clear
				pgmen
			elif [ $optnif1 -eq 0 ]
			then
				pgmen
			fi

			break
		elif [[ $tqselect == 'q' ]]
		then 
			if [ $optnif2 -eq 1 ]
			then
				clear
			fi
			echo "Quitting..........."
			eval $varChoice=1
			break
		else 
			echo -e "\e[31mYou didn't choose between t and q\e[0m"
		      	echo -e "Try again!\n"
			continue
		fi
	done	
}
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

##Password Length Selector Function
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
passlgn(){
	
	#*inner function to reach try_again function
	#===========================================
	try_reach(){
		 	paragraph="digit"
                        varChoice="selector"
                        optnif1=1
			try_again
		}
	#===========================================

	
	while [ $selector -eq 0 ]
	do
		read -p "$(echo -e "Enter desired digit for lenght of password: ${mgn}")" plen #plen = password length
		echo -e "${nc}"
	
		if [[ "$plen" =~ ^[0-9]+$ ]] && [ $plen -gt 0 ]
		then
			case $strength in
				s)
					paswrd=$(openssl rand -base64 48 | tr -dc 'a-zA-Z' | cut -c1-$plen) #paswrd = password
					pg=1
					break
					;;
				m)
					if [ $plen -lt 5 ]
					then
						echo -e "\033[38;5;208mFor medium stregth password lenght should be greater than 5\033[0m"
						echo -e "Try entering appropriate password length\n"
						try_reach
					else 
						paswrd=$(openssl rand -base64 48 | tr -dc 'a-zA-Z0-9' | cut -c1-$plen) #paswrd = password
						pg=1
						break
					fi
					;;
				h)
					if [ $plen -lt 5 ]
                        		then
                                		echo -e "\033[38;5;208mFor medium stregth password lenght should be greater than 5\033[0m"
                                		echo -e "Try entering appropriate password length\n"
						try_reach
                                	else                             
						paswrd=$(openssl rand -base64 48 | tr -dc 'a-zA-Z0-9!@#$%^&*()_+-=' | cut -c1-$plen) #paswrd = password
						pg=1
						break
					fi
					;;
			esac 
		else			
			try_reach
		fi
	done
}
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

##Password Generator Function
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
pgmen(){

	while [ $selector -eq 0 ]
	do
		echo -e "\n\nPassword Generator - 's' for Simple, 'm' for Medium, 'h' for Hard" 
		echo -e "Make sure that input for strenght should be in small letters\n" 
		echo "=============================================================================="

		echo -n "Your Entered Letter for Strength: "
		read strength

		if [ $strength = 's' ]
		then
			echo "-----------------------------------------------"
			echo -e "$strength: \e[33mGenerated Password Will be Simple\e[0m"
			echo "-----------------------------------------------"
			passlgn
			selector=1
		elif [ $strength = 'm' ]	
		then
			echo "-----------------------------------------------"
			echo -e "$strength: \e[36mGenerated Password Will be Medium\e[0m"
			echo "-----------------------------------------------"
			passlgn
			selector=1
		elif [ $strength = 'h' ]
		then
  			echo "-----------------------------------------------"
    			echo -e "$strength: \e[33mGenerated Password Will be Hard\e[0m"
     			echo "-----------------------------------------------"
			passlgn
			selector=1
		else
			paragraph="letter from s or m or h"
			varChoice="selector"
			optnif1=1
			try_again
		fi
	done
	
	if [ $pg -eq 1 ]
	then
		echo -e "\033[1;35m---------------------------------------\033[0m"
		echo -e "\e[34mGenerated Password: \e[0m $paswrd"
		echo -e "\033[1;35m---------------------------------------\033[0m"
		echo
		echo "=============================================================================="
        	optnif1=0
        	varChoice="selector"
        	try_again
	fi
}
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

pgmen #password generator menu# #to start the script 
