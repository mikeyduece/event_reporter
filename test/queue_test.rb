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
    queue.finder("first_name","John")
    assert_equal 63, queue.count
  end

  def test_it_can_clear_queue
    queue.finder("first_name","John")
    assert_equal 63, queue.count
    queue.clear
    assert_equal 0, queue.count
  end

end
