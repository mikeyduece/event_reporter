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

end
