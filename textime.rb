IO.foreach 'worktime.txt' do |line|
	fields = line.split(' ')
	fields.each do |field|
		print field + ' '
	end
	print "\n"
end