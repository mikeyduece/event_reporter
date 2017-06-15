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

  def test_queue_count_zero_by_default
    assert_equal 0, queue.count
  end

  def test_it_can_find_johns
    assert_equal 63, queue.find_first_name("John").count
    assert_equal 63, queue.count
  end

  def test_it_can_clear_queue
    queue.find_first_name("John")
    assert_equal 63, queue.count
    queue.clear
    assert_equal 0, queue.count
  end

  def test_can_it_give_district_info
    queue.find_first_name("Audrey")
    assert_equal 3, queue.count
    queue.district
    
  end


end
