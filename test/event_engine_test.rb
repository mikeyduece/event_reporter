require './test/test_helper'
require './lib/event_engine'

class EventEngineTest < Minitest::Test
  attr_reader :ee

  def setup
    @ee = EventEngine.new
  end

  def test_its_a_thing
    assert_instance_of EventEngine, ee
  end

end
