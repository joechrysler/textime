require "rubygems"
require "test/unit"

require "./textime"

class TextimeTest < Test::Unit::TestCase
	def setup
		@t = Textime.new
	end

	def test_seperates_weeks
		assert("\n".seperates_weeks?)
	end

	def test_hours_worked
		assert_equal(7.5, @t.hours_worked('8/15  8:30 12:00 12:30 16:30'))
	end

	def test_to_time
		assert_equal(' 7:30', 7.5.to_time)
		assert_equal('12:00', 12.0.to_time)
	end
end
