require 'date'
require 'readline'
require 'open-uri'

wind_speed = [1,2,3,4,5,9,6,7,8]
air_temp = [40, 50, 60, 50, 40, 70, 80, 90, 60]
barometric = [55, 60, 80, 1000, 14, 12, 50, 80]

def mean(arr)
	length = arr.length
	value = 0
	sum = 0
	arr.each do |x|
		sum = sum + x
		mean = sum/length
	end
	puts mean
end

def median(arr)
	sorted = arr.sort {|a,b| a <=> b}
	length = sorted.length

	if length % 2 == 1 #odd
		half_length = length/2
		median_position = half_length + 0.5
		puts arr[median_position]
	else
		half_length == length/2 #even
		low_position = half_length - 1
		high_postion = half_length + 1
		median = (arr[high_postion] + arr[low_position])/2
		puts median
	end
end


def user_input(dates)
	puts "Please enter a start date as YYYY-MM-DD"
	start_date = Date.parse("2014-07-14") #Date.parse(gets.chomp)
	dates << start_date

	puts "Please enter ok now enter an end date as YYYY-MM-DD"
	end_date = Date.parse("2014-07-20") #(gets.chomp)

	dates << end_date
end


def parse_dates(dates, parsed_dates)
		dates.each do |date|
		  parsed_dates << date.strftime('%Y_%m_%d')
		  parsed_dates << date.strftime('%Y')
	  	end
end

def api_call (types, start_uri, end_uri)
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
      print readings
   end
end

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

api_call(types, start_uri, end_uri)





