require './test/test_helper'
require './lib/commands'

class CommandsTest < Minitest::Test
  attr_reader :q, :com

  def setup
    @q = Queue.new
    @com = Commands.new
  end

  def test_its_a_thing
    assert_instance_of Commands, com
  end

  def test_can_change_join_second_entry_into_one
    q.loader
    var      = ("find first name John").split
    actual   = com.long_entry(var)
    expected = ["find","first_name","John"]
    assert_equal expected, actual
  end

end
