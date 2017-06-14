require './test/test_helper'
require './lib/attendee'

class AttendeeTest < Minitest::Test
  attr_reader :attendee
  def setup
    @attendee = Attendee.new({regdate: Time.now,first_name: "Allison",
      last_name: "Nguyen", email_address: "arannon@jumpstartlab.com",
      homephone: "6154385000", street: "3155 19th St NW",
      city: "Washington", state: "DC", zipcode: 20010})
  end

  def test_its_a_thing
    assert_instance_of Attendee, attendee
  end

  def test_it_can_see_reg_date
    assert_instance_of Time, attendee.reg_date
  end

  def test_it_can_see_first_name
    assert_equal "Allison".downcase, attendee.first_name
  end

  def test_it_can_see_last_name
    assert_equal "Nguyen".downcase, attendee.last_name
  end

  def test_it_can_see_email
    assert_equal "arannon@jumpstartlab.com", attendee.email
  end

  def test_it_can_see_phone_num
    assert_equal 6154385000, attendee.home_phone
  end

  def test_it_can_see_the_street
    assert_equal "3155 19th St NW", attendee.street
  end

  def test_it_can_see_city
    assert_equal "Washington", attendee.city
  end

  def test_it_can_see_state
    assert_equal "DC", attendee.state
  end

  def test_it_can_see_zipcode
    assert_equal 20010, attendee.zipcode
  end

end
