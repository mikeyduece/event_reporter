require './lib/attendee_repo'
require 'sunlight/congress'

class Queue
  Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"
  attr_reader :attendees

  def initialize
    @attendees = AttendeeRepo.new("./data/full_event_attendees.csv",self)
    @queued = []
  end

  def count
    @queued.count
  end

  def find_first_name(name)
    names = @queued << attendees.find_all_by_first_name(name)
    return names.flatten!
  end

  def clear
    @queued = []
  end

  def legislators_by_zipcode(zipcode)
    legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)

    require "pry"; binding.pry
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

  # def print
  #   @queued.each do |attendee|
  #
  #
  # end

  # def loaded
  #   attendees.open_file("./data/event_attendees.csv")
  # end
end
