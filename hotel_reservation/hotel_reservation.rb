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
  def name
    @name
  end
  def start_date
    @start_date
  end
  def end_date
    @end_date
  end
  def rate
    @rate
  end
end

class Hotel
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
  def seasonal_rates
    print @seasonal_rates
  end
  def show
    print "\nname:#{@name}, rate:#{@rate}"
    # show the details for every season
    @seasonal_rates.each { |season| season.show } if @seasonal_rates
    print "\ntax:#{@tax}\n" if @tax
  end

  def count_seasonal_days(start_date, checkin_date, end_date, checkout_date)
    seasonal_days = 0
    # checkin date lies between start date and end date
    if start_date <= checkin_date && checkin_date <= end_date
    # checkout is before end of season
      if end_date >= checkout_date
        seasonal_days = (checkout_date - checkin_date + 1).to_i
      # checkout is after end of season
      else
        seasonal_days = (end_date - checkin_date + 1).to_i
      end
    end
    # checkin is done before start of season
    if start_date > checkin_date
      # if the checkout is done before start of season that means no day comes under the season
      if checkout_date >= start_date
        # days of season would end at end date or checkout date, whichever comes earlier
        if checkout_date <= end_date
          seasonal_days = (checkout_date - start_date + 1).to_i
        else
          seasonal_days = (end_date - start_date + 1).to_i
        end
      end
    end
    seasonal_days
  end

  def show_total_cost(checkout_date, checkin_date, total_seasonal_days, total_cost)
    total_days = (checkout_date - checkin_date + 1).to_i
    normal_days = total_days - total_seasonal_days
    total_cost += normal_days * @rate
    print "normal days = #{normal_days} @ #{@rate}\n"
    print "total cost = #{total_cost}\n"
  end

  def generate_bills (checkin_date, checkout_date)
    print "\nhotel: #{@name}\n"
    # initialize the variables to 0
    total_seasonal_days = 0
    total_cost = 0
    # we need only calculate seasons if seasonal data exists
    if @seasonal_rates
      start_year = checkin_date.year - 1
      end_year = checkout_date.year + 1
      # iterate for all seasons in a hotel
      @seasonal_rates.each do |season|
        # cover all the years for an input of multiple years
        start_year.upto(end_year) do |year|
          start_date = to_date(season.start_date, year)
          season_name = ""
          #seasonal_days = 0
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
          seasonal_days = count_seasonal_days(start_date, checkin_date, end_date, checkout_date)
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
    show_total_cost(checkout_date, checkin_date, total_seasonal_days, total_cost)
  end

  # append the year to season dates and make it a complete date object
  def to_date(date, year)
    Date.parse("#{date}-#{year}")
  end
end

class String
  def input_date
    print "\nenter check #{self} date(YYYY-MM-DD): "
    date = gets.chomp
    Date.parse(date)
  end
end

hotel_json = File.read("hotel_reservation.json")
hotels = JSON.parse(hotel_json)
hotel_objects = []

#create hotel object for each hotel and push to hotels array
hotels.each { |hotel| hotel_objects << Hotel.new(hotel) }
hotel_objects.each { |hotel_object| hotel_object.show }

checkin_date = "in".input_date
checkout_date = "out".input_date
raise RuntimeError, "checkout date cannot come before checkin date" if checkin_date > checkout_date

#calculate and show the cost
hotel_objects.each { |hotel_object| hotel_object.generate_bills(checkin_date, checkout_date) }
print "\n"
