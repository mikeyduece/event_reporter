require './lib/attendee_repo'

class Queue
  attr_reader :attendees, :loaded

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

  # def loaded
  #   attendees.open_file("./data/event_attendees.csv")
  # end
end
