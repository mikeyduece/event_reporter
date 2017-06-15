require './test/test_helper'
require './lib/queue'

class QueueTest < Minitest::Test
  attr_reader :data
  def setup
    @data = Queue.new
  end

  def test_its_a_thing
    assert_instance_of Queue, data
  end

  def test_queue_count_zero_by_default
    assert_equal 0, queue.count
  end

end
