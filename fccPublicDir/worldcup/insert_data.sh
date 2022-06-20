#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

$PSQL "TRUNCATE teams, games"
echo Truncating tables successful

# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]]
  then 
    # get WINNER_ID
    WINNER_ID=$($PSQL "SELECT team_id from teams where name='$WINNER'")
    # if not found
    if [[ -z $WINNER_ID ]]
    then
    # insert new team
      INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams(name) values('$WINNER')")
    # get new winner_id
      if [[ $INSERT_WINNER_RESULT == 'INSERT 0 1' ]]
      then 
        echo Inserted $WINNER team successfully
        WINNER_ID=$($PSQL "SELECT team_id from teams where name='$WINNER'")
      fi
    fi
    
    # get OPPONENT_ID
    OPPONENT_ID=$($PSQL "SELECT team_id from teams where name='$OPPONENT'")
    # if not found
    if [[ -z $OPPONENT_ID ]]
    then
    # insert new team
      INSERT_OPPONENT_RESULT=$($PSQL "INSERT INTO teams(name) values('$OPPONENT')")
    # get new OPPONENT_ID
      if [[ $INSERT_OPPONENT_RESULT == 'INSERT 0 1' ]]
      then 
        echo Inserted $OPPONENT team successfully
        OPPONENT_ID=$($PSQL "SELECT team_id from teams where name='$OPPONENT'")
      fi
    fi

    # insert new game entry
    INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) values($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)") 
      if [[ $INSERT_GAME_RESULT == 'INSERT 0 1' ]]
      then 
        echo Inserted Game entry $YEAR - $ROUND successfully
      fi

  fi
done