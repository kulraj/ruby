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
      @rate = value["rate"]
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
#puts (checkout_date - checkin_date).to_f * @rate
    if @seasonal_rates
      @seasonal_rates.each do |season|
        start_date = to_date(season.start_date, checkin_date.year)
        #print start_date, " "
        end_date = to_date(season.end_date, checkout_date.year)
        #print end_date, " ;"
        if start_date > end_date
          if checkin_date.month == 1
            start_date.year -= 1
          else
            end_date.year += 1
        end
      end
    end
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
