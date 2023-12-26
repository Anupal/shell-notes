#!/bin/bash

#####################################################################
# Script Name: control.sh
# Description: This script demonstrates control sequences in bash.
# Author: Anupal Mishra
# Date: December 26, 2023
#####################################################################

echo ":EXAMPLE: IF/ELSE STRING"
read -p "Enter your name: " USER_INPUT
if [ "$USER_INPUT" == "Anupal" ]; then
    echo "Hello, Anupal"
elif [ $USER_INPUT = "Anupal Mishra" ]; then
    echo "Hello, Anupal Mishra"
else
    echo "You're not Anupal"
fi

echo -e "\n:EXAMPLE: IF/ELSE NUMBERS"
read -p "Enter a number: " USER_INPUT
if [ $USER_INPUT -eq 0 ]; then
    echo "Number is 0"
elif [ $USER_INPUT -lt 0 ]; then
    echo "Number is negative"
elif [ $USER_INPUT -gt 0 ] && [ $USER_INPUT -le 100 ]; then
    echo "Number is between 1 - 99"
elif [ $USER_INPUT -gt 100 ]; then
    echo "Number > 100"
fi

echo -e "\n:EXAMPLE: WHILE COUNT LOOP"
read -p "Enter number of times you want me to loop: " USER_INPUT
count=0
while [ $count -lt $USER_INPUT ]; do
    echo "Loop: $count"
    ((count++))
done

echo -e "\n:EXAMPLE: FOR IN LIST"
read -p "Enter a list of items with space as a separator: " USER_INPUT
for item in $USER_INPUT; do
    echo "$item"
done