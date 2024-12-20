PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

if [[ ! $1 ]]
then 
  echo "Please provide an element as an argument."
else


# if the parameter is a number
if [[ $1 ]]
then 
  
  ATOMIC_NUMBER=$1
  RESULTS=$($PSQL="SELECT e.name, e.symbol, t.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius FROM elements AS e INNER JOIN properties AS p ON e.atomic_number = p.atomic_number INNER JOIN types AS t ON t.type_id = p.type_id WHERE atomic_number = $ATOMIC_NUMBER")
  echo $RESULTS | while read
  do
    # Display message  
    echo "The element with atomic number "1" is "Hydrogen" ("H"). It's a "nonmetal", with a mass of "1.008" amu. "Hydrogen" has a melting point of "-259.1" celsius and a boiling point of "-252.9" celsius."
  done
  

fi




fi
