#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
CHARACTERS=$( echo $1 | wc -c )

if [[ ! $1 ]] # 1
then # 1
  echo "Please provide an element as an argument."
else # 1

  # if the parameter is a number
  if [[ $1 =~ ^[0-9+]$ ]] # 2
  then # 2 

    ATOMIC_NUMBER=$1
    RESULTS=$($PSQL "SELECT name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements AS e INNER JOIN properties AS p ON e.atomic_number = p.atomic_number INNER JOIN types AS t ON t.type_id = p.type_id WHERE e.atomic_number = $ATOMIC_NUMBER")
    
    if [[ -z $RESULTS ]] # 3
    then # 3
      echo "I could not find that element in the database."
    else # 3      
      echo "$RESULTS" | while IFS='|' read NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS
      do
        # Display message  
        echo "The element with atomic number $ATOMIC_NUMBER is "$NAME" (""$SYMBOL""). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
      done

    fi # 3
  # if the parameter is the element name
  elif [[ $CHARACTERS -gt 3 ]] # 2
  then # 2
    NAME=$1
    ELEMENT_RESULTS=$($PSQL "SELECT e.atomic_number, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements AS e INNER JOIN properties AS p ON e.atomic_number = p.atomic_number INNER JOIN types AS t ON t.type_id = p.type_id WHERE e.name='$NAME'")
    if [[ -z $ELEMENT_RESULTS ]] # 4
    then # 4
      echo "I could not find that element in the database."
    else # 4
      echo "$ELEMENT_RESULTS" | while IFS='|' read ATOMIC_NUMBER SYMBOL TYPE ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS
      do
        # Display message  
        echo "The element with atomic number $ATOMIC_NUMBER is "$NAME" (""$SYMBOL""). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
      done
    fi # 4
  else # 2
    SYMBOL=$1
    SYMBOL_RESULTS=$($PSQL "SELECT e.atomic_number, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements AS e INNER JOIN properties AS p ON e.atomic_number = p.atomic_number INNER JOIN types AS t ON t.type_id = p.type_id WHERE e.symbol='$SYMBOL'")
    
    if [[ -z $SYMBOL_RESULTS ]] 
    then # 5
      echo "I could not find that element in the database."
    else # 5
      echo "$SYMBOL_RESULTS" | while IFS='|' read ATOMIC_NUMBER NAME TYPE ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS
      do
      # Display message  
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
      done
    fi # 5

  fi # 2
fi # 1