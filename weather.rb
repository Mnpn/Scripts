#!/usr/bin/env ruby

# __        __         _   _               
# \ \      / /__  __ _| |_| |__   ___ _ __ 
#  \ \ /\ / / _ \/ _` | __| '_ \ / _ \ '__|
#   \ V  V /  __/ (_| | |_| | | |  __/ |   
#    \_/\_/ \___|\__,_|\__|_| |_|\___|_|
# Mnpn, 2018 - A simple script that prints the current weather.

require "weather-api"
require "colorize" # Colours!

if ARGV[0] == nil
	puts "No location specified. Usage: `#{$0} <zip/name>`"
	exit
end

begin
	zip = Integer(ARGV[0])
	if zip >= 0 && zip <= 47 || zip == 3200
		event.respond "The Zip-code is invalid."
		exit
	end
	response = Weather.lookup(zip, Weather::Units::CELSIUS)
	# I'll be using Celsius for the time being because it's what I normally use.
	# Change this to Fahrenheit, or even Kelvin if you prefer that.
rescue
	begin
		response = Weather.lookup_by_location(ARGV.join(" "), Weather::Units::CELSIUS)
	rescue
		puts "That location was not found.".colorize(:red)
		exit
	end
end

puts "==== Weather ====".colorize(:green).center(50)
puts response.title.colorize(:blue)
puts "Temperature: ".colorize(:yellow) + "#{response.condition.temp}°C"
#puts "With a high of #{response.forecasts.high}°C and a low of #{response.forecasts}°C."
puts "Wind: ".colorize(:yellow) + "#{response.wind.direction}° at #{response.wind.speed}km/h, with a chill of #{response.wind.chill}°F."
puts "Sun: ".colorize(:yellow) + "Rises at #{response.astronomy.sunrise.strftime("%I:%M")} and sets at #{response.astronomy.sunset.strftime("%I:%M")}."
puts "Humidity: ".colorize(:yellow) + "#{response.atmosphere.humidity}%."
puts "Visibility: ".colorize(:yellow) + "#{response.atmosphere.visibility}km."
puts "Pressure: ".colorize(:yellow) + "#{response.atmosphere.pressure}mbar."
puts "Barometer: ".colorize(:yellow) + "#{response.atmosphere.barometer}."
puts "It's #{response.condition.text.downcase}."
puts "=================".colorize(:green).center(50)

__END__
This was removed due to it taking up a lot of space for little info.

puts "\nUpcoming:".colorize(:blue)
response.forecasts.each do |forecast|
	forecast.day.length == 3
	puts "#{forecast.date.strftime("%B %e")}: High/Low #{forecast.high}°/#{forecast.low}°."
end