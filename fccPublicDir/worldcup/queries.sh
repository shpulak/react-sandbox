#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals + opponent_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) from games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals), 2) from games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "select AVG(winner_goals + opponent_goals) from games")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "select winner_goals from games order by winner_goals desc limit 1")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "select COUNT(game_id) from games where winner_goals > 2")"

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "select t.name from games as g inner join teams as t on g.winner_id=t.team_id where round='Final' and year='2018'")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT res.name FROM (SELECT t.name, year, round from games as g inner join teams as t on g.winner_id = t.team_id UNION SELECT teams.name, year, round from games inner join teams on games.opponent_id = teams.team_id) as res where res.year=2014 and res.round='Eighth-Final'")"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "select DISTINCT t.name from games as g inner join teams as t on t.team_id=g.winner_id order by t.name")"

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "select g.year, t.name from games as g inner join teams as t on t.team_id=g.winner_id where round='Final' order by year")"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT name from teams where name like 'Co%'")"
