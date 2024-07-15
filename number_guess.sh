#!/bin/bash


#generates a random number between 1 - 1000
RANDOM_NUMBER=$(( 1 + $RANDOM % 1000 ))

echo -e "\n~~~~~~ Welcome to the Guessing Number Game ~~~~~~"

echo -e "\nEnter your username:"

read USER_NAME

echo "Your name is: $USER_NAME"


#display the number generated
echo -e "Number generated: $RANDOM_NUMBER"
