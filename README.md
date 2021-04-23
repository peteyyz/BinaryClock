# BinaryClock

A binary clock, written in BASH.  Favors accuracy over aesthetics.
Requires xdotool, ncurses and xterm.
Aims to be an accurate clock by pre-drawing the clock face and refreshing upon the start of a new second.

Main loop:
* The clock face for the next second is computed and stored before the time check (wait_for_it) occurs.
* The function wait_for_it checks the time until the next second is reached.  By default it loops for only .05 seconds, using much less CPU.
* The already rendered clock face is printed.
* The main timeout is a wait for keypress read, default of .95 seconds.  Adjust as needed for slower systems.


Screengrab of the clock at 2:16:47 PM.


![binclock_2pm16m47s](https://user-images.githubusercontent.com/73159111/115932292-82d8ae00-a441-11eb-9da7-513a110fcecc.png)
