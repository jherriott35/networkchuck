#!/bin/bash

echo "Welcome to Shell Football"

###########################################################################################
#                           loop until difficulty is chosen                               #
###########################################################################################
function computer_difficulty {
while true; do

	echo "Please choose the difficulty: Easy / Medium / Hard "
	read difficulty

	if [[ $difficulty == "Easy" || $difficulty == "easy" ]]; then
		echo "You have chosen easy. Better not get beat on this mode!"
		op_pass="25"
		op_run="50"
		op_fg="60"
		break

	elif [[ $difficulty == "Medium" || $difficulty == "medium" ]]; then
	        echo "You have chosen medium. Try hard next time!"
		op_pass="45"
		op_run="75"
		op_fg="85"
		break

	elif [[ $difficulty == "Hard" || $difficulty == "hard" ]]; then
	        echo "You have chosen hard. Good luck is all I'm saying."
		op_pass="55"
		op_run="85"
		op_fg="99"
		break

	else echo "Incorrect difficulty. Please type 'Easy', 'Medium', or 'Hard'."

	fi
done
}


###########################################################################################
#                              loop until team is chosen                                  #
###########################################################################################
function choose_team {
while true; do
	echo "Now choose your Team (Titans / Chiefs / Patriots):
	Titans:
	Passing: 58%
	Running: 89%
	Field Goals: 81%

	Chiefs:
	Passing: 56%
	Running: 90%
	Field Goals: 83%

	Patriots:
	Passing: 62%
	Running: 88%
	Field Goals: 82%
	"
	read team

	# Set team shooting percentages
	if [[ $team == "Titans" || $team == "titans" ]]; then
                echo "You have chosen the Titans. Let the games begin!"
                team_pass="58"
                team_run="89"
                team_fg="81"
                break

	elif [[ $team == "Chiefs" || $team == "chiefs" ]]; then
                echo "You have chosen the Chiefs. Let the games begin!"
                team_pass="56"
                team_run="90"
                team_fg="83"
                break

	elif [[ $team == "Patriots" || $team == "patriots" ]]; then
                echo "You have chosen the Patriots. Let the games begin!"
                team_pass="62"
                team_run="88"
                team_fg="82"
                break

	elif [[ $team == "Coffee" || $team == "coffee" ]]; then
		echo "You have chosen coffee. Nothing beats coffee!"
		team_pass="100"
		team_run="100"
		team_fg="100"
		break

	else echo "Incorrect team. Pleasy type 'Titans', 'Chiefs', or 'Patriots'."

	fi
done
}


while true; do
        echo "Select number of players (1 or 2)"
        read game_mode

        if [[ $game_mode == "2" ]]; then
                echo "Player 1 - Choose your team..."
		choose_team
		p1_team=$team
		p1_pass=$team_pass
		p1_run=$team_run
		p1_fg=$team_fg
		echo ""
		echo "Player 2 - Choose your team..."
		choose_team
		p2_team=$team
                p2_pass=$team_pass
                p2_run=$team_run
                p2_fg=$team_fg
		break

        elif [[ $game_mode == "1" ]]; then
                echo "Player 1 - Choose your team..."
		choose_team
		p1_team=$team
                p1_pass=$team_pass
                p1_run=$team_run
                p1_fg=$team_fg
		computer_difficulty
		p2_team="Computer"
                p2_pass=$op_pass
                p2_run=$op_run
                p2_fg=$op_fg
		break

        else echo "Incorrect selection."
        fi
done


p1_score=0
p2_score=0


###########################################################################################
#                                        Coin Toss                                        #
###########################################################################################
echo "Heads - $p1_team gets the ball."
echo "Tails - $p2_team gets the ball."
echo "The coin is tossed in the air ..."
sleep 1

cointoss=$(($RANDOM % 2))
if [ $cointoss == 0 ]; then
	echo "It is heads!"
	echo "$p1_team gets the ball!"
	possession=1
else echo "It is tails!"
	echo "$p2_team gets the ball!"
	possession=0
fi

echo ""


###########################################################################################
#                                Generate computer drive                                  #
###########################################################################################

function computer_drive {
	down=1
	yard=20
	yards_to_go=10
	while true; do
		if [[ $down -lt 4 ]]; then
			play=$(($RANDOM % 2))
			if [[ $play == 0 ]]; then
				echo ""
				echo "Computer is passing!"
				success_chance=$(($RANDOM % 100))
				if [[ $success_chance -le $p2_pass ]]; then
					echo "Pass is complete!"
					yard=$(($yard + 8))
					if [[ $yard -ge 100 ]]; then
						echo ""
						echo "TOUCHDOWN Computer!"
						p2_score=$(($p2_score + 7))
						possession=1
						break
					fi
					yards_to_go=$(($yards_to_go - 8))
					if [[ $yards_to_go -le 0 ]]; then
						echo "First down!"
						down=1
						yards_to_go=10
					else down=$(($down + 1))
					fi
				else echo "Pass incomplete"
					down=$(($down + 1))
				fi
			elif [[ $play = 1 ]]; then
				echo ""
				echo "Computer is running"
				success_chance=$(($RANDOM % 100))
				if [[ $success_chance -le $p2_run ]]; then
					echo "Computer ran for a gain!"
					yard=$(($yard + 5))
					if [[ $yard -ge 100 ]]; then
						echo ""
						echo "TOUCHDOWN Computer!"
						p2_score=$(($p2_score + 7))
						possession=1
						break
					fi
					yards_to_go=$(($yards_to_go - 5))
					if [[ $yards_to_go -le 0 ]]; then
						echo "First down!"
						down=1
						yards_to_go=10
					else down=$(($down + 1))
					fi
				else echo "Run is stopped at the line of scrimmage."
					down=$(($down + 1))
				fi
			fi
	
		elif [[ $down == 4 ]]; then
			if [[ $yard -ge 70 ]]; then
				echo ""
				echo "Computer is attempting a field goal!"
				success_chance=$((RANDOM % 100))
				if [[ $success_chance -le $p2_fg ]]; then
					echo "The kick is good!"
					computer_score=$(($p2_score + 3))
					possession=1
					break
				else echo "The kick is no good!"
					echo "Receiving team has caught and fielded the field goal to the 20 yard line."
					break
				fi
			else echo ""
				echo "Computer has decided to punt."
				echo "Punt has went out of bounds at the 20 yard line."
				possession=1
				break
			fi
		fi
	sleep 2
	done
}


###########################################################################################
#                                 Generate player drive                                   #
###########################################################################################

function player_drive {
	down=1
	yard=20
	yards_to_go=10
	while true; do
		if [[ $down -lt 4 ]]; then
			echo ""
			echo "Would you like to pass(0) or run(1)?"
			read play
			if [[ $play == "0" ]]; then
				echo ""
				echo "$player_team is passing!"
				success_chance=$(($RANDOM % 100))
				if [[ $success_chance -le $player_pass ]]; then
					echo "Pass is complete!"
					yard=$(($yard + 8))
					if [[ $yard -ge 100 ]]; then
						echo ""
						echo "TOUCHDOWN $player_team!"
						player_score=$(($player_score + 7))
						possession=0
						break
					fi
					yards_to_go=$(($yards_to_go - 8))
					if [[ $yards_to_go -le 0 ]]; then
						echo "First down!"
						down=1
						yards_to_go=10
					else down=$(($down + 1))
					fi
				else echo "Pass incomplete"
					down=$(($down + 1))
				fi
			elif [[ $play = "1" ]]; then
				echo ""
				echo "$player_team is running"
				success_chance=$(($RANDOM % 100))
				if [[ $success_chance -le $player_run ]]; then
					echo "$player_team ran for a gain!"
					yard=$(($yard + 5))
					if [[ $yard -ge 100 ]]; then
						echo ""
						echo "TOUCHDOWN $player_team!"
						player_score=$(($player_score + 7))
						possession=0
						break
					fi
					yards_to_go=$(($yards_to_go - 5))
					if [[ $yards_to_go -le 0 ]]; then
						echo "First down!"
						down=1
						yards_to_go=10
					else down=$(($down + 1))
					fi
				else echo "Run is stopped at the line of scrimmage."
					down=$(($down + 1))
				fi
			fi
	
		elif [[ $down == 4 ]]; then
			if [[ $yard -ge 70 ]]; then
				echo ""
				echo "$player_team is attempting a field goal!"
				success_chance=$((RANDOM % 100))
				if [[ $success_chance -le $player_fg ]]; then
					echo "The kick is good!"
					player_score=$(($player_score + 3))
					possession=0
					break
				else echo "The kick is no good!"
					echo "Receiving team has caught and fielded the field goal to the 20 yard line."
					break
				fi
			else echo ""
				echo "$player_team has decided to punt."
				echo "Punt has went out of bounds at the 20 yard line."
				possession=0
				break
			fi
		fi
	sleep 2
	done
}


###########################################################################################
#                  Loop until one of the teams score at least 50 points                   #
###########################################################################################
until [[ $p1_score -ge 25 || $p2_score -ge 25 ]]; do
	if [[ $possession == 0 ]]; then
		if [[ $p2_team == "Computer" ]]; then
			computer_score=$p2_score
			computer_pass=$p2_pass
			computer_run=$p2_run
			computer_fg=$p2_fg
			computer_drive
			p2_score=$computer_score
		else
			player_team=$p2_team
			player_score=$p2_score
	                player_pass=$p2_pass
	                player_run=$p2_run
	                player_fg=$p2_fg
	                player_drive
	                p2_score=$player_score
		fi
		possession=1
		sleep 1

	elif [[ $possession == 1 ]]; then
		player_team=$p1_team
		player_score=$p1_score
		player_pass=$p1_pass
		player_run=$p1_run
		player_fg=$p1_fg
		player_drive
		p1_score=$player_score
		possession=0
		sleep 1
	fi

	echo ""
	echo "#########################"
	echo "#"
	echo "#     $p1_team: $p1_score"
	echo "#     $p2_team: $p2_score"
	echo "#"
	echo "#########################"
done

echo ""

###########################################################################################
#                                 End of game message                                     #
###########################################################################################
if [[ $p1_score -ge 50 ]]; then
	echo "$p1_team wins!"
elif [[ $p2_score -ge 50 ]]; then
	echo "$p2_team wins!"
fi

if [[ $team == "Coffee" || $team == "coffee" ]]; then
	echo ""
	echo "Nothing beats coffee!!!"
	echo "networkchuck.coffee"
fi
