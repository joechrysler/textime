#!/usr/bin/env ruby

class String
	def to_hours()
		times = self.split(':')
		times[0].to_f + times[1].to_f/60
	end
end

class Float
	def to_time(duration=false)
		integer_part = self.floor
		decimal_part = self - self.floor
		(integer_part).to_s.rjust(2, ' ') + ':' + (decimal_part*60).round.to_s.rjust(2, '0')
	end
end

last_time = 0.0
days_so_far = 0
total = 0.0

input_file = ARGV[0] || 'sample.txt'

IO.foreach input_file do |line|
	fields = line.split(' ')
	if fields.length == 0
		puts "Total: #{total.to_time(true)}".rjust(34)
		puts " ".rjust(34)
		last_time = total
		total = 0.0
		days_so_far = 0 if days_so_far == 5 or days_so_far == 3
	end
	if fields[0] =~ /\d+\/\d+/
		print fields[0] + ' '
		clock_in  = fields[1].to_hours
		lunch_out = fields[2].to_hours
		back_in   = fields[3].to_hours
		clock_out  = fields[4].to_hours

		duration = (lunch_out - clock_in) + (clock_out - back_in)
		total += duration

		puts clock_in.to_time + ' ' + lunch_out.to_time + ' ' + back_in.to_time + ' ' + clock_out.to_time + ' ' + duration.to_time.rjust(5, ' ')
		days_so_far += 1
	end

end

if days_so_far < 3 
	total_remaining = 30 - last_time
	daily_remaining = total_remaining / (3 - days_so_far)
else
	total_remaining = 40 - last_time
	daily_remaining = total_remaining / (5 - days_so_far)
end

print "Remaining: #{total_remaining.to_time(true)}".rjust(34) + "\n"
print "Each day: #{daily_remaining.to_time(true)}".rjust(34) + "\n"
