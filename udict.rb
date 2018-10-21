#!/usr/bin/env ruby

#  _   _      _                 ____  _      _   
# | | | |_ __| |__   __ _ _ __ |  _ \(_) ___| |_ 
# | | | | '__| '_ \ / _` | '_ \| | | | |/ __| __|
# | |_| | |  | |_) | (_| | | | | |_| | | (__| |_ 
#  \___/|_|  |_.__/ \__,_|_| |_|____/|_|\___|\__|
# Mnpn, 2018 - This simply provides definitions from the
# Urban Dictionary and makes it CLI-friendly.

# Load the required gems.
require "urban_dict" # The Urban Dictionary
require "colorize" # Colours!

# Take all the arguments provided and make a string out of them.
# $ ./udict.rb This is the greatest plan!
# => ["This", "is", "the", "greatest", "plan!"]
todefine = ARGV.join(" ")    
# => "This is the greatest plan!"
define = if todefine != "" # If the user has provided an argument
            begin
                UrbanDict.define(todefine) # Define it.
            rescue # Something went wrong trying to define the word. It most likely does not exist.
                # Let the user know
                puts "That's not in the dictionary.".colorize(:red)
                # and exit the program.
                exit
            end
        else # Otherwise
            # Get a random definition.
            UrbanDict.random
        end    

# Define some variables for the ratings.
up = define['thumbs_up']
down = define['thumbs_down']
# Calculate the upvote percentage.
percent = ((up.to_f/(up.to_f+down.to_f))*100.0).round(2)

# Print everything, with colours!
puts "Urban Dictionary".colorize(:blue)
puts "'#{define['word']}' by #{define['author']}:"
puts "Definition: ".colorize(:blue) + define['definition']
puts "Example:\n".colorize(:blue) + define['example']
puts "#{up} Likes | #{down} Dislikes (#{percent}%)"
puts define['permalink'].colorize(:green)
# We're done here!