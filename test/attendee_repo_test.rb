require './test/test_helper'
require './lib/attendee_repo'

class AttendeeRepoTest < Minitest::Test
  attr_reader :ar, :q

  def setup
    @q = Queue.new
    # q.loader
    @ar = AttendeeRepo.new("./data/event_attendees.csv")
  end

  def test_its_a_thing
    assert_instance_of AttendeeRepo, ar
  end

  def test_it_can_find_all_attendees
    assert_equal 19, ar.all.count
  end

  # def test_it_can_find_by_id
  #   id = ar.find("id", 1)
  #   assert_instance_of Attendee, id.first.id
  # end
  #
  def test_it_can_find_by_first_name
    assert_equal 2, ar.find("first_name","Sarah").count
    assert_instance_of Array, ar.find("first_name","Sarah")
    assert_instance_of Attendee, ar.find("first_name","Sarah")[0]
  end

  def test_it_can_find_by_last_name
    assert_equal 1, ar.find("last_name","Nguyen").count
    assert_instance_of Array, ar.find("last_name","Nguyen")
    assert_instance_of Attendee, ar.find("last_name","Nguyen")[0]
  end

  def test_it_can_find_by_street
    assert_equal 1, ar.find("street","3024 Cranbrook Ct").count
    assert_instance_of Array, ar.find("street","3024 Cranbrook Ct")
    assert_instance_of Attendee, ar.find("street","3024 Cranbrook Ct")[0]
  end

  def test_it_can_find_by_state
    assert_equal 3, ar.find("state","CA").count
    assert_instance_of Array, ar.find("state","CA")
    assert_instance_of Attendee, ar.find("state","CA")[0]
  end

  def test_it_can_find_by_zipcode
    assert_equal 1, ar.find("zipcode", "95667").count
    assert_instance_of Array, ar.find("zipcode", "95667")
    assert_instance_of Attendee, ar.find("zipcode", "95667")[0]
  end

  def test_it_can_find_by_phone_number
    assert_equal 1, ar.find("phone", "787-295-0000").count
    assert_instance_of Array, ar.find("phone", "787-295-0000")
    assert_instance_of Attendee, ar.find("phone", "787-295-0000")[0]
  end
end
