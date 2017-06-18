require 'colorize'
require './lib/queue'
require './lib/event_messages'
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
    @loaded = false
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
    when "queue"      then queue_help(third_command)
    when "find"       then find_help
    when "attributes" then attribute_help
    when "print"      then print_help
    else help_commands
    end
    start_commands(first_command)
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
    when "find"  then find(second_command,third_command)
    when "print" then queue.printer
      start
    end
  end

  def quit_commands(command)
    %w(q Q quit Quit QUIT).include?(command)
  end

  def load_csv
    queue.loader
    loaded
    @loaded = true
    start
  end

  def queue_commands(command,third_command=nil)
    case command
    when "count" then print_count(queue.count)
    when "clear" then queue.clear; puts "The queue is now empty."
    end
  end

  def find(second_command, third_command)
    # if second_command == nil || third_command == nil
    #     wrong_number_of_args
    #     start
    if @loaded == false
      puts "Please load file before searching the queue."
      start
    elsif @loaded == true
      search = queue.finder(second_command, third_command)
      search_results(search.count)
    end
  end

  def get_input
    user_input = gets.chomp
    commands.change_commands(user_input)
    set_commands
  end

  def set_commands
    @first_command = commands.first_command
    @second_command = commands.second_command if commands.second_command != nil
    @third_command = commands.third_command if commands.third_command != nil
  end

  # def string_format(string)
  #   string.gsub!(/\s+/, "_").downcase
  # end
end
start = EventReporter.new
start.start
