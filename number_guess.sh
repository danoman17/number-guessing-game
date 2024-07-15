#!/bin/bash


#generates a random number between 1 - 1000
RANDOM_NUMBER=$(( 1 + $RANDOM % 1000 ))

#display the number generated
echo $RANDOM_NUMBER
