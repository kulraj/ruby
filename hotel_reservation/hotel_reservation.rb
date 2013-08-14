=begin
The ABC Propertiers company manages various hotels across various hill stations. They want to implement a customer-reservation system.
They'd like their customers to know prices across various hotels in various hill stations -
The prices are determined by a basic rate or a special season rate.
Some units have seasonal rates (e.g. a new year rate and a summer rate)

Write a program that parses a list of rentals in json format and outputs with their names.

When the user enters their period of reservation, the total cost for the reservation period is displayed, grouped by normal rate period and any season period days in between.
=end

require "json"
require "date"

class Season
  attr_reader :name, :start_date, :end_date, :rate

  def initialize(season)
    season.each do |key, value|
      @name = key
      @start_date = value["start"]
      @end_date = value["end"]
      @rate = value["rate"].to_i
    end
  end
  def show
    print "\nspecial season: #{@name}, start date: #{@start_date}, end date: #{@end_date}, rate: #{@rate}"
  end
end

class Hotel
  @@list = []
  attr_reader :name, :rate, :tax, :seasonal_rates

  def self.load_json(filename)
    path_to_json_file = File.dirname($0) + "/" + filename
    hotel_json = File.read(path_to_json_file)
    hotels = JSON.parse(hotel_json)
    hotels.each { |hotel| @@list << Hotel.new(hotel) }
  end

  def initialize(hotel_hash)
    # get info from the json data parsed into a hash
    @name = hotel_hash["Hotel_name"]
    @rate = hotel_hash["rate"].to_i
    if hotel_hash["seasonal_rates"]
      @seasonal_rates = []
      # seasonal rates is array of season objects, which we push one by one
      hotel_hash["seasonal_rates"].each { |seasonal_rate| @seasonal_rates << Season.new(seasonal_rate) }
    end
    @tax = hotel_hash["tax"]
  end

  def self.show
    @@list.each { |hotel| hotel.show_details }
  end

  def show_details
    print "\nname:#{name}, rate:#{rate}"
    # show the details for every season
    seasonal_rates.each { |season| print season.show } if seasonal_rates
    print "\ntax:#{tax}\n" if tax
  end

  def self.list
    @@list
  end
  
end

class Reservation
  attr_reader :checkin_date, :checkout_date

  def initialize(checkin_date, checkout_date)
    @checkin_date = checkin_date
    @checkout_date = checkout_date
  end

  def calculate_rents
    hotel_list = Hotel.list
    hotel_list.each { |hotel| calculate_rent(hotel) }
  end

  def count_seasonal_days(start_date, end_date)
    # we create arrays for the season and stay and take common dates
    stay_dates = (checkin_date..checkout_date).to_a
    season_dates = (start_date..end_date).to_a
    #the length of intersection gives us the number of days in the given season
    (stay_dates & season_dates).length
  end

  def show_total_cost(total_seasonal_days, total_cost, hotel)
    total_days = (checkout_date - checkin_date + 1).to_i
    normal_days = total_days - total_seasonal_days
    total_cost += normal_days * hotel.rate
    print "normal days = #{normal_days} @ #{hotel.rate}\n"
    print "Total = #{total_cost}\n"
    if hotel.tax then
      cost_including_tax = total_cost * (1 + hotel.tax.to_f/100)
      print "Total cost(including tax @#{hotel.tax}% ) = #{cost_including_tax.round}\n"
    end
  end

  def generate_start_and_end_dates_for_season(season, year)
    start_date = to_date(season.start_date, year)
    end_date = to_date(season.end_date, year)
    # condition for a season starting in one year and ending in next, like new year season
    if start_date > end_date
      # if the month is january then we shift the start date back by one year  
      if checkin_date.month == 1
        start_date <<= 12
        #else the end date is shifted forward one year
      else
        end_date >>= 12
      end
    end
    return start_date, end_date
  end

  def calculate_rent (hotel)
    print "\nhotel: #{hotel.name}\n"
    # initialize the variables to 0
    total_seasonal_days = 0
    total_cost = 0
    # we need only calculate seasons if seasonal data exists
    if hotel.seasonal_rates
      start_year = checkin_date.year - 1
      end_year = checkout_date.year + 1
      # iterate for all seasons in a hotel, each loop not used since that prints seasonal rates and skips the inner block
      hotel.seasonal_rates.each do |season|
        # cover all the years for an input of multiple years
        start_year.upto(end_year) do |year|
          start_date, end_date = generate_start_and_end_dates_for_season(season, year)
          seasonal_days = count_seasonal_days(start_date, end_date)
          # add to cost and to seasonal days
          if seasonal_days > 0
            print "seasonal days = #{seasonal_days} in #{season.name} @ #{season.rate}\n" 
            print  "season start date: #{start_date}, season end_date: #{end_date}\n"
            total_cost += season.rate * seasonal_days
            total_seasonal_days += seasonal_days
          end
        end
      end
    end
    show_total_cost(total_seasonal_days, total_cost, hotel)
  end

  # append the year to season dates and make it a complete date object
  def to_date(date, year)
    Date.parse("#{date}-#{year}")
  end
end

def input_date(in_out)
  print "\nenter check #{in_out} date(YYYY-MM-DD): "
  date = gets.chomp
  Date.parse(date)
end

Hotel.load_json("hotel_reservation.json")
Hotel.show
checkin_date = input_date("in")
checkout_date = input_date("out")
raise RuntimeError, "checkout date cannot come before checkin date" if checkin_date > checkout_date

reservation = Reservation.new(checkin_date, checkout_date)
reservation.calculate_rents