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
#print hotel_hash["Hotel_name"], " next\n"
    @name = hotel_hash["Hotel_name"]
    @rate = hotel_hash["rate"].to_i
    if hotel_hash["seasonal_rates"]
      @seasonal_rates = []
      hotel_hash["seasonal_rates"].each { |seasonal_rate| @seasonal_rates << Season.new(seasonal_rate) }
    end
    @tax = hotel_hash["tax"]
  end
  def seasonal_rates
    print @seasonal_rates
  end
  def show
    print "\nname:#{@name}, rate:#{@rate}"
    @seasonal_rates.each { |season| season.show } if @seasonal_rates
    print "\ntax:#{@tax}\n" if @tax
  end
  def show_cost (checkin_date, checkout_date)
    print "\nhotel: #{@name}\n"
    total_seasonal_days = 0
    total_cost = 0
#puts (checkout_date - checkin_date).to_f * @rate
    if @seasonal_rates
      start_year = checkin_date.year - 1
      end_year = checkout_date.year + 1  
      @seasonal_rates.each do |season|
        start_year.upto(end_year) do |year|
          start_date = to_date(season.start_date, year)
        #print start_date, " "
          season_name = ""
          seasonal_days = 0
          end_date = to_date(season.end_date, year)
        #print end_date, " ;"
 #       <<-doc
          if start_date > end_date
            if checkin_date.month == 1
              start_date <<= 12
            else
              end_date >>= 12
            end
          end
          if start_date <= checkin_date && checkin_date <= end_date
            season_name = season.name
            if end_date >= checkout_date  
              seasonal_days = (checkout_date - checkin_date + 1).to_i
            else
              seasonal_days = (end_date - checkin_date + 1).to_i
            end
          end
          if start_date > checkin_date
            if checkout_date >= start_date
              if checkout_date <= end_date
                seasonal_days = (checkout_date - start_date + 1).to_i
              else
                seasonal_days = (end_date - start_date + 1).to_i
              end  
            season_name = season.name
            end
          end
       
#doc
       
          if season_name == season.name
            print "seasonal days = #{seasonal_days} in #{season_name} @ #{season.rate}\n" 
            print  "season start date: #{start_date}, season end_date: #{end_date}\n"
            total_cost += season.rate * seasonal_days
            total_seasonal_days += seasonal_days
          end
        end

     #if seasonal_days
      end
    end
    total_days = (checkout_date - checkin_date + 1).to_i
    normal_days = total_days - total_seasonal_days
    total_cost += normal_days * @rate
    print "normal days = #{normal_days} @ #{@rate}\n"
    print "total cost = #{total_cost}\n"
  end
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
#print hotel_json.seasonal_rates
#print hotels[0]["seasonal_rates"][0], "\n"
#puts hash_of_hotels[0]["seasonal_rates"]
hotel_objects = []

#hotels.each { |hotel| print hotel, "\n" }
hotels.each { |hotel| hotel_objects << Hotel.new(hotel) }
hotel_objects.each { |hotel_object| hotel_object.show }
#hotel_objects[0].show

checkin_date = "in".input_date
checkout_date = "out".input_date
raise RuntimeError, "checkout date cannot come before checkin date" if checkin_date > checkout_date

#puts checkin_date.year
hotel_objects.each { |hotel_object| hotel_object.show_cost(checkin_date, checkout_date) }
print "\n"
