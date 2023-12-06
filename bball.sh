#!/bin/bash

echo "Welcome to shell basketball!"

###########################################################################################
#                           loop until difficulty is chosen                               #
###########################################################################################
function computer_difficulty {
while true; do

	echo "Please choose the difficulty: Easy / Medium / Hard "
	read difficulty

	if [[ $difficulty == "Easy" || $difficulty == "easy" ]]; then
		echo "You have chosen easy. Better not get beat on this mode!"
		op_threes="25"
		op_twos="50"
		op_ft="60"
		break

	elif [[ $difficulty == "Medium" || $difficulty == "medium" ]]; then
	        echo "You have chosen medium. Try hard next time!"
		op_threes="45"
		op_twos="75"
		op_ft="85"
		break

	elif [[ $difficulty == "Hard" || $difficulty == "hard" ]]; then
	        echo "You have chosen hard. Good luck is all I'm saying."
		op_threes="55"
		op_twos="85"
		op_ft="99"
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
	echo "Now choose your Team (Lakers / Bulls / Celtics):
	Lakers:
	3s: 38%
	2s: 69%
	Free Throws: 81%

	Bulls:
	3s:36%
	2s:70%
	Free Throws:83%

	Celtics:
	3s:42%
	2s:68%
	Free Throws:82%
	"
	read team

	# Set team shooting percentages
	if [[ $team == "Lakers" || $team == "lakers" ]]; then
                echo "You have chosen the Lakers. Let the games begin!"
                team_threes="38"
                team_twos="69"
                team_ft="81"
                break

	elif [[ $team == "Bulls" || $team == "bulls" ]]; then
                echo "You have chosen the Bulls. Let the games begin!"
                team_threes="36"
                team_twos="70"
                team_ft="83"
                break

	elif [[ $team == "Celtics" || $team == "celtics" ]]; then
                echo "You have chosen the Celtics. Let the games begin!"
                team_threes="42"
                team_twos="68"
                team_ft="82"
                break

	elif [[ $team == "Coffee" || $team == "coffee" ]]; then
		echo "You have chosen coffee. Nothing beats coffee!"
		team_threes="100"
		team_twos="100"
		team_ft="100"
		break

	else echo "Incorrect team. Pleasy type 'Lakers', 'Bulls', or 'Celtics'."

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
		p1_threes=$team_threes
		p1_twos=$team_twos
		p1_ft=$team_ft
		echo ""
		echo "Player 2 - Choose your team..."
		choose_team
		p2_team=$team
                p2_threes=$team_threes
                p2_twos=$team_twos
                p2_ft=$team_ft
		break

        elif [[ $game_mode == "1" ]]; then
                echo "Player 1 - Choose your team..."
		choose_team
		p1_team=$team
                p1_threes=$team_threes
                p1_twos=$team_twos
                p1_ft=$team_ft
		computer_difficulty
		p2_team="Computer"
                p2_threes=$op_threes
                p2_twos=$op_twos
                p2_ft=$op_ft
		break

        else echo "Incorrect selection."
        fi
done


p1_score=0
p2_score=0

###########################################################################################
#                                        Tip Off                                          #
###########################################################################################
echo "Tip off in ..."
echo "3"
sleep 1
echo "2"
sleep 1
echo "1"
echo ""

tipoff=$(($RANDOM % 2))
if [ $tipoff == 0 ]; then
	echo "$p2_team got the tipoff!"
	possession=0
else echo "$p1_team got the tipoff!"
	possession=1
fi

echo ""


###########################################################################################
#                           Generate computer shooting chances                            #
###########################################################################################
function computer_shot {
	shot=$(($RANDOM % 100))
	if [[ $shot -ge 80 ]]; then
		echo ""
		echo "Opponent shoots a 3!"
		sleep 1
		shot_chance=$(($RANDOM % 100))
		if [ $shot_chance -le $computer_threes ]; then
			echo ""
			echo "The shot was good!"
			computer_score=$(($computer_score + 3))
		else echo ""
			echo "The shot was no good!"
		fi
	elif [[ $shot -ge 10 && shot -le 79 ]]; then
		echo ""
		echo "Opponent shoots a 2!"
		sleep 1
		shot_chance=$(($RANDOM % 100))
		if [[ $shot_chance -le $computer_twos ]]; then
			echo ""
			echo "The shot was good!"
			computer_score=$(($computer_score + 2))
		else echo ""
			echo "The shot was no good!"
		fi
	elif [[ $shot -le 9 ]]; then
		echo ""
		echo "Opponent shoots a free throw!"
		sleep 1
		shot_chance=$(($RANDOM % 100))
		if [ $shot_chance -le $computer_ft ]; then
			echo ""
			echo "The shot was good!"
			computer_score=$(($computer_score + 1))
		else echo ""
			echo "The shot was no good!"
		fi
	fi
}


###########################################################################################
#                            Generate player shooting chances                             #
###########################################################################################
function player_shot {
	echo ""
	echo "$player_team - choose the shot you want to take ....
	0 = 3 pointer
	1 = 2 pointer
	2 = Free Throw
	Anything else will result in a turnover."
	read shot
	if [[ $shot == 0 ]]; then
		echo ""
                echo "You shoot a 3!"
		sleep 1
                shot_chance=$(($RANDOM % 100))
                if [ $shot_chance -le $player_threes ]; then
			echo ""
                        echo "The shot was good!"
                        player_score=$(($player_score + 3))
                else echo ""
		     echo "The shot was no good!"
                fi
        elif [[ $shot == 1 ]]; then
		echo ""
                echo "You shoot a 2!"
		sleep 1
                shot_chance=$(($RANDOM % 100))
                if [[ $shot_chance -le $player_twos ]]; then
			echo ""
                        echo "The shot was good!"
                        player_score=$(($player_score + 2))
                else echo ""
			echo "The shot was no good!"
                fi
        elif [[ $shot == 2 ]]; then
		echo ""
                echo "You shoot a free throw!"
		sleep 1
                shot_chance=$(($RANDOM % 100))
                if [ $shot_chance -le $player_ft ]; then
			echo ""
                        echo "The shot was good!"
                        player_score=$(($player_score + 1))
                else echo ""
			echo "The shot was no good!"
                fi
	else echo ""
		echo "TURNOVER! Choose to shoot instead next time!"
		sleep 1
       fi
}

###########################################################################################
#                  Loop until one of the teams score at least 50 points                   #
###########################################################################################
until [[ $p1_score -ge 50 || $p2_score -ge 50 ]]; do
	if [[ $possession == 0 ]]; then
		if [[ $p2_team == "Computer" ]]; then
			computer_score=$p2_score
			computer_threes=$p2_threes
			computer_twos=$p2_twos
			computer_ft=$p2_ft
			computer_shot
			p2_score=$computer_score
		else
			player_team=$p2_team
			player_score=$p2_score
	                player_threes=$p2_threes
	                player_twos=$p2_twos
	                player_ft=$p2_ft
	                player_shot
	                p2_score=$player_score
		fi
		possession=1
		sleep 1

	elif [[ $possession == 1 ]]; then
		player_team=$p1_team
		player_score=$p1_score
		player_threes=$p1_threes
		player_twos=$p1_twos
		player_ft=$p1_ft
		player_shot
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
	echo "networkchuck.com/coffee"
fi
