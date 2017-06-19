require 'colorize'
module EventMessages
  def queue_help(command)
    error_message if command == nil
    case command
    when "count" then puts "Displays amount of current entries in queue.".white.bold
    when "clear" then puts "Clears the current queue of all entries.".white.bold
    when "print" then print_help
    end
  end

  def error_message
    puts "Please enter criteria you would like help with.
    i.e. 'help queue count'.".pink
  end

  def attribute_help
    puts "The criteria you can search for are:
      - last_name
      - first_name
      - email
      - zipcode
      - city
      - state
      - street
      - city
      - state
      - home_phone".white
  end

  def find_help
    puts "The find command searches the attendees matching your search criteria.
      Search format is as follows
      'find fist name john'."
  end

  def print_help
    puts "Print out a tab-delimited data table with a header row following this format:"
    puts "LAST NAME  FIRST NAME  EMAIL  ZIPCODE  CITY  STATE  ADDRESS  PHONE".bold.underline
  end

  def welcome
    puts "Welcome to Event Reporter. Type 'help' for a list of commands. Or enter command to begin.".cyan.bold.underline
  end

  def table_header
    ['LAST NAME','FIRST NAME','EMAIL','ZIPCODE','CITY','STATE','ADDRESS','PHONE']
    # puts ("LAST NAME"+" "*5+"FIRST NAME"+" "*5+"EMAIL"+" "*5+"ZIPCODE"+" "*5+
    # "CITY"+" "*5+"STATE"+" "*5+"ADDRESS"+" "*5+"PHONE").white.bold.underline
  end

  def print_table
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

  def help_commands
    puts "Commands:
            -load
            -queue count
            -queue clear
            -help
            -help <command>
            -print
            -print by <attribute>
            -save to <filename.csv>
            -export html <filename.csv>
            -find <attribute> <criteria>".yellow.bold
  end

  def loaded
    puts "File loaded.".bold
  end

  def print_count(count)
    puts "There are #{count} records currently in the queue".bold
  end

  def search_results(search)
    puts "There are #{search} matches."
  end

  def wrong_number_of_args
    if second_command != nil && third_command == nil
      puts "Wrong number of aruments. Given: 1 Expected: 2"
    elsif second_command == nil && third_command == nil
      puts "Wrong number of arguments. Given: 0 Expecting: 2"
    end
  end

end