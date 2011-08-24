class String
	def to_hours()
		times = self.split(':')
		times[0].to_f + times[1].to_f/60
	end	
end

class Float
	def to_time(duration=false)
		integer_part = self.floor
		integer_part = self.floor - 12 if self.floor > 12 unless duration
		decimal_part = self - self.floor
		(integer_part).to_s.rjust(2, ' ') + ':' + (decimal_part*60).round.to_s.rjust(2, '0')
	end
end


f = File.new('worktime.txt', 'r')
lines = f.readlines
total = 0.0
IO.foreach 'worktime.txt' do |line|
	fields = line.split(' ')
	if fields.length == 0
		print "Total: #{total.to_time(true)}".rjust(34) + "\n"
		total = 0.0
	end
	if fields.length >= 5
		print fields[0] + ' '
		clock_in  = fields[1].to_hours
		lunch_out = fields[2].to_hours
		back_in   = fields[3].to_hours
		clock_out  = fields[4].to_hours

		duration = (lunch_out - clock_in) + (clock_out - back_in)
		total += duration

		print clock_in.to_time + ' ' + lunch_out.to_time + ' ' + back_in.to_time + ' ' + clock_out.to_time + ' ' + duration.to_time.rjust(5, ' ')
	end

	print "\n"
end