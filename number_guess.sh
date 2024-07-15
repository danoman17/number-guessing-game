#!/bin/bash

#PSQL variable
PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"


read_number_input(){
  echo -e "\nGuess the secret number between 1 and 1000:"

  #TODO: validate the input to be a integer
  #TODO: set guides for user's attemps
  #TODO: create a counter for attemps
  read NUMBER_GUESS

  echo -e "\nThe guess is: $NUMBER_GUESS"


}


#generates a random number between 1 - 1000
RANDOM_NUMBER=$(( 1 + $RANDOM % 1000 ))

echo -e "\n~~~~~~ Welcome to the Guessing Number Game ~~~~~~"

echo -e "\nEnter your username:"

read USER_NAME

DUMP_NAME="a"

if [[ -z $DUMP_NAME ]]
then
  echo -e "\nWelcome, $USER_NAME! It looks like this is your first time here."

else
  #TODO: get games_played and best_game from DB.

  echo -e "\nWelcome back, $USER_NAME! You have played <games_played> games, and your best game took <best_game> guesses."

  read_number_input

fi
