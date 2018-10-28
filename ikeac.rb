#!/usr/bin/env ruby

#  ___ _  _______    _    ____ 
# |_ _| |/ / ____|  / \  / ___|
#  | || ' /|  _|   / _ \| |    
#  | || . \| |___ / ___ \ |___ 
# |___|_|\_\_____/_/   \_\____|           
# Mnpn, 2018 - A simple IKEA availability checker. Thanks jD91mZM2 for helping me figure out how Nokogiri actually works.
# Find your store ID by going to the product's page and pressing CTRL-U, and then CTRL-F to search for your city.

# Load all of the required gems.
require "nokogiri"
require "open-uri"
require "colorize"

# Are all the required arguments provided? Is the store ID actually an int?
if ARGV[1].to_i == 0 || ARGV.length < 3
	# If not, let's tell the user they've done it wrong and how to correctly do it.
	puts "Usage: `#{$0.yellow} <" + "country (e.g. se/sv)".yellow + "> <" + "store ID (e.g. ".yellow + "001".blue + ")".yellow + "> <" +
	"prod. ID 1 (e.g. ".yellow + "802.334.30".blue + ")".yellow + "> <" + "prod. ID 2".yellow + "> <" + "etc.".yellow + ">`"
	# I am so sorry for this ^ Hopefully it looks decent.
	puts "Find your store ID by going to the product's page and pressing CTRL-U, and then CTRL-F to search for your city."
	# Exit the program.
	exit
end

# Print the program's name.
puts "--- IKEA Store Availability Checker ---".green

# Create an array that we'll later add all the items to.
statuses = []
# The items are the provided IDs, and the user can provide as many as they want.
# Here we drop the first two arguments, the country and the store ID, as they are not items.
items = ARGV.drop(2)

i = 1
(ARGV.length-2).times do # Do this for as many items as we have
	begin
		# Get the page for the item with Nokogiri. Here we also provide the country and the item ID, without any dots.
		ikea = Nokogiri::HTML(open("https://www.ikea.com/#{ARGV[0]}/iows/catalog/availability/#{items.first.gsub(".", "")}"))
	rescue => e # Something went wrong. Probably a 404, but we don't know because we haven't checked.
		# We don't have to, as we'll print the error either way.
		puts "Error (#{i}): #{e}".red
		# Remove the item and do the next (if it exists).
		items.shift
		i += 1
		next
	end
	# Get the status from the page.
	status = ikea.css("actionresponse").css("msg").inner_text
	if status != "OK" # The status is not "OK", it's most likely a 404 page (in which case the status would be "") or "Service unavailable".
		puts "Error: Service unavailable. Response: #{status}" # Let the user know,
		# and exit the program.
		exit
	else # The status is OK!
		# Create variables.
		stock = "Unknown"
		sold = false
		ikea.css("localstore").each { |node| # Get all nodes called "localStore" from the page. For some reason Nokogiri reads it all in lowercase.
			if node["bucode"] == ARGV[1] # If a node's buCode (store ID) matches the one the user has provided
				stock = node.css("availablestock").first.inner_text # Get the amount of items
				sold = node.css("issoldinstore").inner_text # and if it's sold in store. This will probably always be true if there are items available.
			end
		}
		# Print the store availability.
		if sold == "true"
			statuses.push "Store availability for #{items.first.blue}: #{stock.yellow}, is sold in store."
		else
			statuses.push "Store availability for #{items.first.blue}: #{stock.yellow}, is not sold in store."
		end
		# Remove the item and keep going.
		items.shift
		i = i+1
	end
end

# Print all the products in the array, splitting it with a newline.
if !statuses.empty? # If the statuses array isn't empty, print the statuses.
	puts statuses.join("\n")
else
	# If there's nothing to print something has gone wrong. Let's tell the user.
	puts "Are you sure you've selected the right store and/or country?".yellow
	puts "You can find your store ID by going to the product's page and pressing CTRL-U, and then CTRL-F to search for your city."
	puts "The country is in the link, e.g. 'se/sv'."
end