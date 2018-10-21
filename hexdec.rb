#!/usr/bin/env ruby

#  _   _           ____            
# | | | | _____  _|  _ \  ___  ___ 
# | |_| |/ _ \ \/ / | | |/ _ \/ __|
# |  _  |  __/>  <| |_| |  __/ (__ 
# |_| |_|\___/_/\_\____/ \___|\___|
# Takes Hexadecimal and converts it to other bases.
# Mnpn, 2018 - Check out the faster, safer and more feature-rich HexDec that also includes DecHex:
# https://github.com/Mnpn03/HexDec

# Let's start by getting the first argument from the user (ARGV[0], counting starts at 0).
input = ARGV[0]

# Make sure the input even exists.
if input == nil
    # If it doesn't, let the user know what they've done wrong,
    puts "No argument provided. Usage: `#{$0} <hex>`"
    # and exit the program.
    exit
end

# If the hex string starts with # or 0x, remove it.
if input.start_with?("#")
    input = input[1..-1]
elsif input.start_with?("0x")
    input = input[2..-1]
end

# Create a dec variable that we'll use later.
dec = input.to_i(16)

# If the input is only letters that are not used by hexadecimal, the result will be 0.
# Otherwise it will use the hexadecimal before the character.
if dec == 0
    puts "Not valid hexadecimal."
    exit
end

# Print & convert everything at once.
puts "Hexadecimal: " + dec.to_s(16).upcase
puts "Decimal: " + dec.to_s
puts "Binary: " + dec.to_s(2)
puts "Octal: " + dec.to_s(8)
# A4 => {"A4", "164", "10100100", "244"}