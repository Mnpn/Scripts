## Quick countdown I have starting on login.
require "date"
daysuntil = Date.new(2019, 10, 25) - Date.today
`notify-send "#{daysuntil.to_i} days until <>" "Friday, Oct 25th 2019"`
