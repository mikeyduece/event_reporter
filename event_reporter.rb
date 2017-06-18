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
    when "print" then printer
    end
    start
  end

  def find(second_command, third_command)
    if second_command == nil || third_command == nil
        wrong_number_of_args
        start
    elsif @loaded == false
      puts "Please load file before searching the queue.".red.bold
      start
    elsif @loaded == true
      search = queue.finder(second_command, third_command)
      search_results(search.count)
      start
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

  def printer
    if queue.count == 0
      puts "Please load file and search for something to print."
    else
      format = '%-10s %-10s %-30s %-7s %-15s %-6s %-28s %s'
      puts format % ['LAST NAME','FIRST NAME','EMAIL','ZIPCODE','CITY','STATE',
        'ADDRESS','PHONE']
        queue.queued.map do |attendee|
          last = attendee.last_name.capitalize
          first = attendee.first_name.capitalize
          email = attendee.email
          zip = attendee.zipcode
          city = attendee.city
          state = attendee.state
          addy = attendee.street
          phone = attendee.phone
          puts format % [last,first,email,zip,city,state,addy,phone]
        end
    end
    start
  end

end
start = EventReporter.new
start.start
