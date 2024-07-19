# Number Guessing Game

This project is a simple number guessing game where the user tries to guess a randomly generated number between 1 and 1000. The game keeps track of the user's statistics, including the number of games played and their best game (fewest guesses).

## Project Overview

The bash script generates a random number and prompts the user to guess it. It provides feedback if the guess is too high or too low and records the user's statistics in a PostgreSQL database.


## Database Setup

1. Create and populate the PostgreSQL database using the provided dump file. Run the following commands:

    ```sh
    psql -U postgres -f number_guess.sql
    ```

2. The database `number_guess` will be created with the following table:
   - `user_info`: Contains user ID, name, games played, and best game (fewest guesses).

## Bash Script

The bash script `number_guess.sh` runs the number guessing game and interacts with the PostgreSQL database to store and retrieve user statistics.

### Usage

```sh
./number_guess.sh
```

### Example

```
~~~~~~ Welcome to the Guessing Number Game ~~~~~~

Enter your username:
JohnDoe

Welcome back, JohnDoe! You have played 3 games, and your best game took 10 guesses.

Guess the secret number between 1 and 1000:
500
It's higher than that, guess again:
750
It's lower than that, guess again:
...

You guessed it in 5 tries. The secret number was 620. Nice job!
```

## Script Details

The script uses the `psql` command-line tool to interact with the PostgreSQL database. It defines several functions to handle input validation, game logic, and database operations:

1. `is_integer`: Checks if the input is a valid integer.
2. `check_number`: Provides feedback on the user's guess.
3. `not_player_read_number_input`: Handles input for new users.
4. `player_read_number_input`: Handles input for returning users and updates their statistics.
5. `RANDOM_NUMBER`: Generates a random number between 1 and 1000.

### Database Operations

- **New User**: Inserts a new record with the user's name, games played, and best game.
- **Returning User**: Updates the record with the user's latest game statistics.

## Conclusion

This project demonstrates the ability to design, implement, and manage a complex relational database in PostgreSQL. It showcases data modeling skills, knowledge of SQL, and understanding of database constraints and normalization.

Feel free to explore the database and modify it as needed for your purposes.