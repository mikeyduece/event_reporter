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

  def test_it_can_find_by_first_name
    assert_equal 2, ar.find_all_by_first_name("Sarah").count
    assert_instance_of Array, ar.find_all_by_first_name("Sarah")
    assert_instance_of Attendee, ar.find_all_by_first_name("Sarah")[0]
  end

  def test_it_can_find_by_last_name
    assert_equal 1, ar.find_all_by_last_name("Nguyen").count
    assert_instance_of Array, ar.find_all_by_last_name("Nguyen")
    assert_instance_of Attendee, ar.find_all_by_last_name("Nguyen")[0]
  end

  def test_it_can_find_by_phone_number
    assert_instance_of Attendee, ar.find_by_phone(6154385000)
  end

  def test_it_can_find_by_street
    assert_equal 1, ar.find_by_street("3024 Cranbrook Ct").count
    assert_instance_of Array, ar.find_by_street("3024 Cranbrook Ct")
    assert_instance_of Attendee, ar.find_by_street("3024 Cranbrook Ct")[0]
  end

  def test_it_can_find_by_state
    assert_equal 3, ar.find_by_state("CA").count
    assert_instance_of Array, ar.find_by_state("CA")
    assert_instance_of Attendee, ar.find_by_state("CA")[0]
  end

  def test_it_can_find_by_zipcode
    assert_equal 1, ar.find_by_zipcode(95667).count
    assert_instance_of Array, ar.find_by_zipcode(95667)
    assert_instance_of Attendee, ar.find_by_zipcode(95667)[0]
  end


end
