require './test/test_helper'
require './lib/attendee_repo'

class AttendeeRepoTest < Minitest::Test
  attr_reader :ar

  def setup
    @ar = AttendeeRepo.new("./data/event_attendees.csv")
  end

  def test_its_a_thing
    assert_instance_of AttendeeRepo, ar
  end

  def test_it_can_find_all_attendees
    assert_equal 19, ar.all.count
  end

  def test_it_can_find_by_id
    assert_instance_of Attendee, ar.find_by_id(1)
  end

end
