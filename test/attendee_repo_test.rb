require './test/test_helper'
require './lib/attendee'

class AttendeeTest < Minitest::Test
  def setup
    attendee = Attendee.new("./data/event_attendees.csv")
  end

end
