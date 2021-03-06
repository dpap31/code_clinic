
require 'date'
require 'readline'
require 'open-uri'

#Test arrays
wind_speed = [1,2,3,4,5,9,6,7,8]
air_temp = [40, 50, 60, 50, 40, 70, 80, 90, 60]
barometric = [55, 60, 80, 1000, 14, 12, 50, 80]

#Mean method takes array as arguement
mean_med = []
def mean(arr, mean_med)
	length = arr.length
	value = 0
	sum = 0
	arr.each do |x|
		sum = sum + x
		mean = sum/length
		puts mean
	end
end

#Median method takes array as arguement
def median(arr, mean_med)
	sorted = arr.sort {|a,b| a <=> b}
	length = sorted.length

	if length % 2 == 1 #odd
		half_length = length/2
		median_position = half_length + 0.5
		mean_med << [median_position]
	else
		half_length == length/2 #even
		low_position = half_length.to_i - 1
		high_postion = half_length.to_i + 1
		median = (high_postion + low_position)/2
		mean_med << median
	end
end
puts barometric.count
median(barometric, mean_med)
puts mean_med

#Prompt User for dates and add to array
def user_input(dates)
	puts "Please enter a start date as YYYY-MM-DD"
	start_date = Date.parse("2014-07-14") #Date.parse(gets.chomp)
	dates << start_date

	puts "Please enter ok now enter an end date as YYYY-MM-DD"
	end_date = Date.parse("2014-07-20") #(gets.chomp)

	dates << end_date
end

# Turn dates from string into properly formatted date for the API, this includes paring out the year.
def parse_dates(dates, parsed_dates)
	dates.each do |date|
		parsed_dates << date.strftime('%Y_%m_%d')
		parsed_dates << date.strftime('%Y')
	end
end

#construct Start and End date URI, call to API and parse response to array based on spaces
def api_call (types, start_uri, end_uri, types_arr)
	urls = []
	types.each do |type|
		urls << start_uri + type
		urls << end_uri + type
	end
	urls.each do |x|
		puts x
		data = open(x).readlines
		readings = data.map do |line|
			line_items = line.chomp.split(" ")
			reading = line_items[2].to_f
		end
		  types_arr << readings
	end
end


#parse dates
dates = []
user_input(dates)

parsed_dates = []
base_url = 'http://lpo.dt.navy.mil/data/DM/'
parse_dates(dates, parsed_dates)
start_year = parsed_dates[1].to_s
end_year = parsed_dates[3].to_s
start_date = parsed_dates[0].to_s
end_date = parsed_dates[2].to_s
start_uri = "#{base_url}#{start_year}/#{start_date}/"
end_uri = "#{base_url}#{end_year}/#{end_date}/"
types = ['Wind_Speed', 'Air_Temp', 'Barometric_Press']
types_arr = []

api_call(types, start_uri, end_uri, types_arr)

types_arr.each do |x|
	median(x)
end


