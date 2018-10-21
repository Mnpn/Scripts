#!/usr/bin/env ruby

#  ____   ___    ______   ___    ______   ___  
# |___ \ / _ \  / /___ \ / _ \  / /___ \ / _ \ 
#   __) | | | |/ /  __) | | | |/ /  __) | | | |
#  / __/| |_| / /  / __/| |_| / /  / __/| |_| |
# |_____|\___/_/  |_____|\___/_/  |_____|\___/ 
# 20/20/20 is a rule that says that you should look at something 20 feet (6 metres) for 20 seconds every 20 minutes.
# This is said to relieve eye strain. Here's a script that will deliver an Ubuntu notification to remind you.

while true do # Infinite loop
	sleep 1200 # Sleep for 20 minutes
	`notify-send "20/20/20" "Look at an object 6 metres away from you until you hear a chime."` # Send a notification
	sleep 25 # Sleep for 20+5 seconds (give the user a few seconds)
	system "ffplay /usr/share/sounds/gnome/default/alerts/sonar.ogg -autoexit" # Play some default Ubuntu sound.
	`notify-send "20/20/20" "Well done!"` # Congratulate the user.
end