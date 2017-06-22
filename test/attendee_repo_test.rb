require './test/test_helper'
require './lib/attendee_repo'

class AttendeeRepoTest < Minitest::Test
  attr_reader :ar, :ee

  def setup
    @ar = AttendeeRepo.new
  end

  def test_its_a_thing
    assert_instance_of AttendeeRepo, ar
  end

  def test_it_can_clean_zipcode
    zip_1 = "967"
    zip_2 = ""
    zip_3 = 12345656
    assert_equal "00967", ar.clean_zipcode(zip_1)
    assert_equal "00000", ar.clean_zipcode(zip_2)
    assert_equal "12345", ar.clean_zipcode(zip_3)
  end

  def test_it_can_clean_phone
    phone_1 = ""
    phone_2 = "(58x.840)356"
    phone_3 = "345"
    assert_equal "0000000000", ar.clean_phone(phone_1)
    assert_equal "5884035600", ar.clean_phone(phone_2)
    assert_equal "3450000000", ar.clean_phone(phone_3)
  end

  def test_it_can_see_all_attendees
    ar.open_file("./data/full_event_attendees.csv")
    assert_equal 5175, ar.all.count
  end
end
