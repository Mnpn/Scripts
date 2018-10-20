#!/usr/bin/env ruby

#  _  __           ____                _       
# | |/ /___ _   _ / ___|_ __ ___  __ _| |_ ___ 
# | ' // _ \ | | | |   | '__/ _ \/ _` | __/ _ \
# | . \  __/ |_| | |___| | |  __/ (_| | ||  __/
# |_|\_\___|\__, |\____|_|  \___|\__,_|\__\___|
#           |___/                              
# Mnpn, 2018

# Let's check the first argument (ARGV[0], we count from 0).
# Is the argument nil (does it even exist?),
#    is it a string (string_without_any_ints.to_i == 0)
#    and is the int larger than 1000? (Let's have a limit.)
if ARGV[0] == nil || ARGV[0].to_i == 0 || ARGV[0].to_i > 1000
	# Then let's tell the user they've done it wrong and how to correctly do it,
	print "No proper integer of keys to create entered. Usage: `#{$0} <number of keys (1-1000)>`"
	# and exit the program.
	exit
end

# Create an array that we'll later add all the keys to.
keys = []

ARGV[0].to_i.times do # Let's loop this the amount of times/keys the user wants.
	# Create a randomly generated 30-char long string, make it UPPERCASE and add dashes to every fifth character
	# and add it to the keys array.
	keys.push Array.new(15) { rand(256) }.pack('C*').unpack('H*').first.upcase.gsub(/(.{5})(?=.)/, '\1-\2')
end

# Print all the keys in the array, splitting it with a newline.
print keys.join("\n")
# => ABCDE-01234-KLMNO-56789-PQRST-01234
#    BBF4B-A2E84-632C0-8CC52-F7E7D-09581
#    etc.
