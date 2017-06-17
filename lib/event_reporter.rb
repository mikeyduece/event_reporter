require 'colorize'
require './lib/queue'
require './lib/event_message'

class EventReporter
  include EventMessages

  attr_reader :queue, :start

  def initialize
    @queue = Queue.new(self)
  end


  def help(command=nil)
    commands if command == nil
    case command
    when "queue"      then queue_help
    when "find"       then find_help
    when "attributes" then attribute_help
    when "print"      then print_help
    end
    start
  end

  def start(attribute=nil,criteria=nil)
    welcome
    input = gets.chomp.downcase
    case input
    when "help" then help
    when "find" then queue.finder(attribute,criteria)
    when "print" then queue.printer
    when "load" then load_csv
      start
    end
  end

  def load_csv
    queue.loader
    loaded
    queue_commands
  end

  def queue_commands(command=nil)
    queue_start
    input = gets.chomp.downcase
    case command
    when "count" then print_count(queue.count)
    when "clear" then queue.clear; puts "The queue is now empty."
    when "find" then queue.finder
    end
  end
end
start = EventReporter.new
start.start
