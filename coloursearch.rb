#!/usr/bin/env ruby

#   ____ ____  
#  / ___/ ___| 
# | |   \___ \ 
# | |___ ___) |
#  \____|____/ 	ColourSearch
# Mnpn, 2018

# A simple program for finding the amount of pixels with a specific hexadecimal colour value in an image.
# Usage: ./coloursearch #161616 ~/path/to.file

require 'chunky_png'

pixels = []
found = 0
colour = ARGV[0]
path = ARGV[1]

# Make sure that the required arguments have been provided.
# If not, they're nil.
if colour == nil || path == nil
	# Let the user know
	puts "Arguments were not provided properly. Usage: `%s #161616 ~/path/to.file`." % $0
	# Exit the program.	
	exit(1)
end

# Try to load the image from the provided path.
begin
	img = ChunkyPNG::Image.from_file(path)
rescue => e # Something went wrong. Let's tell the user,
	puts "%s.\nMake sure the file is a picture and exists, and try again." % e
	exit(1) # and exit the program.
end

height = img.dimension.height
width  = img.dimension.width

# Loop through for every pixel in the entire image
height.times do |i|
	width.times do |j|
		currentpixel = [ChunkyPNG::Color.r(img[j,i]), ChunkyPNG::Color.g(img[j,i]), ChunkyPNG::Color.b(img[j,i])]
		# Returns pixels as RGB values. ^
		pixels.push currentpixel.map {|x| x.to_s(16).rjust(2, '0')}.join.upcase # Add the pixel as Hex to the array.
	end
end

# Make the colour usable.
if colour.start_with?("#")
    colour = colour[1..-1]
elsif colour.start_with?("0x")
    colour = colour[2..-1]
end

# Repeat this for every colour in the array.
pixels.count { |c| 
	if c == colour # If the pixel matches the input
		found = found + 1
	end
}

# Print the results!
puts "Found %d matches for #%s in %s." % [found, colour, path]