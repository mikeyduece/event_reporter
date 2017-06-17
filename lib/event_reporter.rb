require 'colorize'
require './lib/queue'
require './lib/event_message'
require './lib/commands'

class EventReporter
  include EventMessages

  attr_reader :queue, :start, :commands

  def initialize
    @queue          = Queue.new(self)
    @commands       = Commands.new
    @first_command  = nil
    @second_command = nil
    @third_command  = nil
  end

  def first_command
    @first_command
  end

  def second_command
    @second_command
  end

  def third_command
    @third_command
  end


  def help(command)
    help_commands if command == nil
    # require "pry"; binding.pry
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
    get_input
    if quit_commands(first_command)
      exit
    else
      start_commands(first_command)
    end
  end

  def start_commands(command)
    case command
    when "queue" then queue_commands(second_command, third_command)
    when "help"  then help(second_command)
    when "load"  then load_csv
    # when "find"  then queue.finder(attribute,criteria)
    # when "print" then queue.printer
      start
    end
  end

  def quit_commands(command)
    %w(q Q quit Quit QUIT).include?(command)
  end

  def load_csv
    queue.loader
    loaded
    start
  end

  def queue_commands(second_command=nil,third_command=nil)
    queue_start
    case command
    when "count" then print_count(queue.count)
    when "clear" then queue.clear; puts "The queue is now empty."
    when "find"  then queue.finder
    end
  end

  def get_input
    user_input = gets.chomp
    commands.change_commands(user_input)
    set_commands
    # require "pry"; binding.pry
  end

  def set_commands
    @first_command = commands.first_command
    @second_command = string_format(commands.second_command) if commands.second_command != nil
    @third_command = commands.third_command if commands.third_command != nil
  end

  def string_format(string)
    string.gsub(/\s+/, "_").downcase
  end
end
start = EventReporter.new
start.start
