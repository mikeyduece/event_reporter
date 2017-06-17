require './test/test_helper'
require './lib/queue'

class QueueTest < Minitest::Test
  attr_reader :queue
  def setup
    @queue = Queue.new
  end

  def test_its_a_thing
    assert_instance_of Queue, queue
  end

  def test_does_it_load_file
    queue.loader
    assert File.exists?("./data/full_event_attendees.csv")
  end

  def test_queue_count_zero_by_default
    queue.loader
    assert_equal 0, queue.count
  end

  def test_it_can_find_johns
    queue.loader
    queue.finder("first_name","John")
    assert_equal 63, queue.count
  end

  def test_it_can_clear_queue
    queue.loader
    queue.finder("first_name","John")
    assert_equal 63, queue.count
    queue.clear
    assert_equal 0, queue.count
  end

  def test_it_can_find_by_street
    queue.loader
    assert_equal 2, queue.finder("street","3024 Cranbrook Ct").count
    assert_instance_of Array, queue.finder("street","3024 Cranbrook Ct")
    assert_instance_of Attendee, queue.finder("street","3024 Cranbrook Ct")[0]
  end

  def test_it_can_find_by_last_name
    queue.loader
    assert_equal 3, queue.finder("last_name","Nguyen").count
    assert_instance_of Array, queue.finder("last_name","Nguyen")
    assert_instance_of Attendee, queue.finder("last_name","Nguyen")[0]
   end

   def test_it_can_find_by_street
     queue.loader
     assert_equal 2, queue.finder("street","3024 Cranbrook Ct").count
     assert_instance_of Array, queue.finder("street","3024 Cranbrook Ct")
     assert_instance_of Attendee, queue.finder("street","3024 Cranbrook Ct")[0]
   end

   def test_it_can_find_by_state
     queue.loader
     assert_equal 181, queue.finder("state","CA").count
     assert_instance_of Array, queue.finder("state","CA")
     assert_instance_of Attendee, queue.finder("state","CA")[0]
   end

   def test_it_can_find_by_zipcode
     queue.loader
     assert_equal 1, queue.finder("zipcode", "95667").count
     assert_instance_of Array, queue.finder("zipcode", "95667")
     assert_instance_of Attendee, queue.finder("zipcode", "95667")[0]
   end

   def test_it_can_find_by_phone_number
     queue.loader
     assert_equal 1, queue.finder("phone", "787-295-0000").count
     assert_instance_of Array, queue.finder("phone", "787-295-0000")
     assert_instance_of Attendee, queue.finder("phone", "787-295-0000")[0]
   end

end
