require './lib/attendee_repo'
require 'sunlight/congress'

class Queue
  Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"
  attr_reader :attendees, :all_attendees, :er, :queued

  def initialize(parent=nil)
    @attendees = AttendeeRepo.new
    @er        = parent
    @queued    = []
  end

  def count
    @queued.count
  end

  def all_attendees
    attendees.all
  end

  def finder(attribute, criteria)
    clear
    criteria.delete("-") if attribute == "phone"
    @queued << all_attendees.find_all do |attendee|
      attendee.send(attribute.to_sym).to_s.downcase == criteria.to_s.downcase
    end
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


  def loader
    filename = "./data/full_event_attendees.csv"
    attendees.open_file(filename)
  end
  # def district
  #   if count < 10 && !@queued.empty?
  #     @queued.each do |attendee|
  #       first       = attendee.first_name.capitalize
  #       last        = attendee.last_name.capitalize
  #       name        = "#{first} #{last}"
  #       zipcode     = attendee.zipcode
  #       legislators = legislators_by_zipcode(zipcode)
  #       puts "#{name} #{zipcode} #{legislators}"
  #     end
  #   else
  #     nil
  #   end
  # end
  # def print
  #   @queued.each do |attendee|
  #
  #
  #
  # end

end
