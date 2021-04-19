#!/bin/bash 

SCALE=.95                                       # main timeout - adjust to taste
D2B=({○,●}{○,●}{○,●}{○,●}{○,●}{○,●})            # array via brace expansion
tput civis                                      # hide the cursor
xdotool key Ctrl+0 key --repeat 5 Ctrl+plus     # set the font size
sleep .1                                        # let the virtual key pressing catch up
printf '\033[8;6;6t'                            # set the terminal size
clear

if [ $(date +%P) = "am" ]; then tput setaf 9; else tput setaf 10; fi

echo "┌──────┐"
echo "│○○○○○○│"
echo "│○○○○○○│"
echo "│○○○○○○│"
echo "└──────┘"

CUR_TIME=$(date "+%s")

###################################################################
function timeout {
    read -n 1 -t $SCALE                         # check for user key press, but only wait .95 seconds (set by SCALE variable)
    if [ $? == 0 ]; then                        # check return code of read command
        tput cnorm                              # if key pressed, reactivate cursor and exit
        echo
        exit
    fi
}

function wait_for_it {
    LOOP_START=$CUR_TIME                        # This check will loop for a very short time (1 second minus the timeout)
    while [ $CUR_TIME -eq $LOOP_START ];        # Adjust the read/delay in the timeout function (via SCALE variable) if the rest
    do                                          # of the code takes longer than one second minus the timeout.
        CUR_TIME=$(date "+%s")
    done
}

function update_clock {
    let NEXT_SEC=CUR_TIME+1
    SS=$(expr $(date -d @$NEXT_SEC +"%S") + 0)
    MM=$(expr $(date -d @$NEXT_SEC +"%M") + 0)
    HH=$(expr $(date -d @$NEXT_SEC +"%H") + 0)

    if [ $HH -ge 12 ]                           # if PM, set color and subtract 12
        then                                    
            tput setaf 10
            let HH=HH-12
        else 
            tput setaf 9
    fi
    if [ $HH -eq 0 ]; then HH=12; fi            # if either midnight or noon HH will equal zero, so adjust it

    HRS=${D2B[$HH]}
    MIN=${D2B[$MM]}
    SEC=${D2B[$SS]}

    CLOCK="\e[H┌──────┐\n│$HRS│\n│$MIN│\n│$SEC│\n└──────┘"
}
###################################################################

# main

while true
do
    update_clock
    wait_for_it
    printf $CLOCK
    timeout
done
