#!/bin/bash

#PSQL variable
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

#generates a random number between 1 - 1000
RANDOM_NUMBER=$(( 1 + $RANDOM % 1000 ))

is_integer() {
  [[ $1 =~ ^[0-9]+$ ]]
}

# guides for user's attemps and check input
check_number() { 

  if [[ $1 < $RANDOM_NUMBER ]]
  then
    echo -e "\nIt's lower than that, guess again:"
    return 1
  elif [[ $1 > $RANDOM_NUMBER ]]
  then
    echo -e "\nIt's higher than that, guess again:"
    return 1
  elif [[ $1 = $RANDOM_NUMBER ]]
  then
    return 0
  fi
}

not_player_read_number_input(){

  COUNT=0  # counter for attemps

  while :; do
    
    read GUESS_NUMBER

    # validate the input to be a integer
    if is_integer $GUESS_NUMBER; then
      ((COUNT++))
      
      # Condition to break the loop
      if check_number $GUESS_NUMBER; then
      
        # insert new user info into DB  
        GAMES_PLAYED="$($PSQL "SELECT games_played FROM user_info WHERE name='$1'")"
        ((GAMES_PLAYED++))

        INSERT_NEW_USER_RESULT="$($PSQL "INSERT INTO user_info(name, games_played, best_game) VALUES('$1', $GAMES_PLAYED, $COUNT)")"

        echo -e "\nYou guessed it in $COUNT tries. The secret number was $RANDOM_NUMBER. Nice job!"
        
        break

      fi
    else

      echo -e "\nThat is not an integer, guess again:"
      
    fi

  done

}

player_read_number_input() {
  
  COUNT=0  # counter for attemps

  while :; do
    
    read GUESS_NUMBER

    # validate the input to be a integer
    if is_integer $GUESS_NUMBER; then

      ((COUNT++))
      
      # Condition to break the loop
      if check_number $GUESS_NUMBER; then
      
        # if number guessed, insert new user info into DB 
        
        GAMES_PLAYED="$($PSQL "SELECT games_played FROM user_info WHERE name='$1'")"
        ((GAMES_PLAYED++))
        
        BEST_GAME="$($PSQL "SELECT best_game FROM user_info WHERE name='$1'")"
        
        # compare and upload best game 
        if [[ $COUNT -le $BEST_GAME ]]; then
          BEST_GAME=$COUNT
        fi

        UPDATE_USER_INFO_RESULT="$($PSQL "UPDATE user_info SET games_played = $GAMES_PLAYED , best_game = $BEST_GAME WHERE name='$1'")"

        echo -e "\nYou guessed it in $COUNT tries. The secret number was $RANDOM_NUMBER. Nice job!"
        
        break

      fi
      
    else

      echo -e "\nThat is not an integer, guess again:"
      
    fi
  done
}


echo -e "\n~~~~~~ Welcome to the Guessing Number Game ~~~~~~"

echo -e "\nEnter your username:"

read USER_NAME

USER_ID="$($PSQL "SELECT user_id FROM user_info WHERE name='$USER_NAME'")"

# check if the user already in the DB 
if [[ -z $USER_ID ]]
then

  echo -e "\nWelcome, $USER_NAME! It looks like this is your first time here."
  echo -e "\nGuess the secret number between 1 and 1000:"

  not_player_read_number_input $USER_NAME

else
  
  # get games_played and best_game from DB.
  GAMES_PLAYED="$($PSQL "SELECT games_played FROM user_info WHERE name='$USER_NAME'")"
  BEST_GAME="$($PSQL "SELECT best_game FROM user_info WHERE name='$USER_NAME'")"
  echo -e "\nWelcome back, $USER_NAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  echo -e "\nGuess the secret number between 1 and 1000:"

  player_read_number_input $USER_NAME

fi

