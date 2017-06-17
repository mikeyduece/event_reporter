require 'colorize'
require './lib/queue'
require './lib/event_message'
require './lib/commands'

class EventReporter
  include EventMessages

  attr_reader :queue, :start, :commands, :input, :first_command, :second_command,
              :third_command

  def initialize
    @queue          = Queue.new(self)
    @commands       = Commands.new
    @first_command  = nil
    @second_command = nil
    @third_command  = nil
    @input = input
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
    get_cmd
    case input
    when "queue" then queue_commands(second_command, third_command)
    when "help"  then help
    when "find"  then queue.finder(attribute,criteria)
    when "print" then queue.printer
    when "load"  then load_csv
      start
    end
  end

  def load_csv
    queue.loader
    loaded
    queue_commands
  end

  def queue_commands(second_command=nil,third_command=nil)
    queue_start
    get_cmd
    case command
    when "count" then print_count(queue.count)
    when "clear" then queue.clear; puts "The queue is now empty."
    when "find"  then queue.finder
    end
  end

  def get_cmd
    user_input = input.gets.chomp
    commands.change_commands(user_input)
    set_commands
  end

  def set_commands
    @first_command = commands.first_command
    @second_command = string_format(commands.second_command) if !second_command.nil?
    @third_command = commands.third_command if !third_command.nil?
  end

  def string_format(string)
    string.gsub(/\s+/, "_").downcase
  end
end
start = EventReporter.new
start.start
