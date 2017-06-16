require 'colorize'
require './lib/queue'
require './lib/event_message'

class EventReporter
  include EventMessages

  attr_reader :queue, :input

  def initialize
    @queue = Queue.new
    @running = true
    @input = input
  end

  def input
    @input
  end

  def running?
    @running
  end

  def get_input
    user_input = input.gets.chomp
    input_check
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

  def start
    welcome
    input = gets.chomp.downcase
    case input
    when "help" then help
    when "find" then queue.finder
    when "print" then queue.printer
    when "load" then queue.loader
    when "queue count" then queue.count
    when "queue clear" then queue.clear
    else
      puts "Not a valid command. Please try again"
      start
    end

  end
end
start = EventReporter.new
start.start
