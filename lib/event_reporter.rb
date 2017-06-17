require 'colorize'
require './lib/queue'
require './lib/event_message'

class EventReporter
  include EventMessages

  attr_reader :queue

  def initialize
    @queue = Queue.new
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
    when "load" then queue.loader
    when "queue count" then queue.count
    when "queue clear" then queue.clear
      start
    end

  end
end
start = EventReporter.new
start.start
