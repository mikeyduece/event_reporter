require './lib/attendee_repo'
require 'sunlight/congress'

class Queue
  Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"
  attr_reader :attendees, :all_attendees

  def initialize
    @attendees = AttendeeRepo.new("./data/full_event_attendees.csv",self)
    @queued = []
  end

  def count
    @queued.count
  end

  def all_attendees
    attendees.all
  end

  def finder(attribute, criteria)
    clear
    @queued << attendees.find(attribute, criteria)
    return @queued.flatten!
  end

  def clear
    @queued = []
  end

  def legislators_by_zipcode(zipcode)
    legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)

    legislator_names = legislators.collect do |legislator|
    "#{legislator.first_name} #{legislator.last_name}"
    end
    legislator_names.join(", ")
  end

  def district
    if count < 10 && !@queued.empty?
      @queued.each do |attendee|
        first       = attendee.first_name.capitalize
        last        = attendee.last_name.capitalize
        name        = "#{first} #{last}"
        zipcode     = attendee.zipcode
        legislators = legislators_by_zipcode(zipcode)
        puts "#{name} #{zipcode} #{legislators}"
      end
    else
      nil
    end
  end

  def loader
    filename ||="./data/event_attendees.csv"
    attendees.open_file(filename)
  end
  # def print
  #   @queued.each do |attendee|
  #
  #
  #
  # end

end
