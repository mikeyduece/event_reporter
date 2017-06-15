require './lib/attendee_repo'

class Queue
  attr_reader :attendees, :loaded

  def initialize
    @attendees = AttendeeRepo.new("./data/event_attendees.csv",self)
    @queued = []
  end

  def count
    @queued.count
  end

  def loaded
    attendees.open_file("./data/event_attendees.csv")
  end
end
