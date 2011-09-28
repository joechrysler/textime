#Time is precious
Don't waste it tracking itself.

textime.rb parses a simple text file of in and out timepoints into yet another plaintext report indicating how many hours you work each day, each week
and how many you have left to go (useful for hourly workers on flexible schedules).

Each day gets a total time spent working in the rightmost column, and each week gets its own Total line.

##Make it your own
Rename sample-config.rb to config.rb and add your own default timecard file so you don't have to type the path every run. daysInAWeek and hoursInAWeek are used to calculate the remaining time this week and how much time you need to log each day.

3day/30hour weeks are the default because that's what I'm working at the moment.

##Run it
./textime.rb [/path/to/timecard.txt]

Output is to stdout. Pipe away.

##Ciao
It's a quick hack, but it works.
