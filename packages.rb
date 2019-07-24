## Take all installed packages and put them in a .txt, on Debian-based machines.
## Made for me so I can keep track of my packages when I reinstall.

fs = ""
am = 0

`apt list --installed >> tmp.txt`
f = File.open("tmp.txt", "r")
f.each_line { |line|
	if am != 0 # bodge
		new_str = line.slice(0..(line.index("/")))
		fs << " #{new_str}"[0...-1]
	end
	am+=1
}

File.open("packages.txt", "w") { |file| file.write(fs) }

puts "Finished exporting. ~#{am} packages found"
