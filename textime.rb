#!/usr/bin/env ruby

require "./config"

class String
	def to_hours()
		times = self.split(':')
		times[0].to_f + times[1].to_f/60
	end

	def seperates_weeks?
		return self.length == 1
	end
end

class Float
	def to_time(duration=false)
		integer_part = self.floor
		decimal_part = self - self.floor
		(integer_part).to_s.rjust(2, ' ') + ':' + (decimal_part*60).round.to_s.rjust(2, '0')
	end
end


class Textime
	attr_accessor :days_so_far, :total

	def initialize
		@days_so_far = 0
		@total = 0.0
	end

	def process
		input_file = ARGV[0] || $config[:timecard_path]

		IO.foreach input_file do |today|
			if today.seperates_weeks?
				process_last_week
			else
				t = hours_worked today
				puts "#{today[0..-2]} #{t.to_time}"
				@total += t
				@days_so_far += 1
			end
		end

		summarize
	end

	def hours_worked day
		times = day.split(' ')
		duration = 0

		if times[0] =~ /\d+\/\d+/
			arrive = times[1].to_hours
			lunchtime = times[2].to_hours
			backToWork = times[3].to_hours
			leave = times[4].to_hours

			duration = (lunchtime - arrive) + (leave - backToWork)
		end
		return duration
	end

	def process_last_week
		puts "Total: #{@total.to_time(true)}".rjust(34)
		puts " ".rjust(34)
		@total = 0.0
		@days_so_far = 0
	end

	def summarize
		total_remaining = $config[:hoursInAWeek] - @total
		remaining_days = $config[:daysInAWeek] - @days_so_far

		if remaining_days == 0
			daily_remaining = total_remaining
			puts "Total: #{@total.to_time(true)}".rjust(34)

		else
			daily_remaining = total_remaining / remaining_days
			puts "Remaining: #{Float(total_remaining).to_time(true)}".rjust(34)
			puts "Each day: #{daily_remaining.to_time(true)}".rjust(34)
		end
	end
end

Textime.new.process
