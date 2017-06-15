require './lib/attendee_repo'

class Queue
  attr_reader :attendees

  def initialize(data)
    @attendees = AttendeeRepo.new
    @queued = []
  end

  def count
    @queued.count
  end

  def load
    if File.exists?
  end
end
