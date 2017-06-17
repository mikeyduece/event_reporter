require 'colorize'
module EventMessages
  def queue_help(command)
    case command
    when "count" then puts "Displays amount of current entries in queue.".white.bold
    when "clear" then puts "Clears the current queue of all entries.".white.bold
    when "print" then print_help
    end
    # puts "The queue holds the stored search results form previous searches.
    # It is not cleared until the user enters the queue clear command or starts
    # a new seach.
    #   The queue related commands are: queue count, queue clear, queue print,
    #   queue print_by<attribute>, and queue print_by<filename.csv>"
  end

  def attribute_help
    "The criteria you can search for are:
      - last_name
      - first_name
      - email
      - zipcode
      - city
      - state
      - street
      - city
      - state
      - home_phone"
  end

  def find_help
    puts "The find command searches the attendees matching your search criteria.
      Search format is as follows
      find <attribute> <criteria>."
  end

  def print_help
    puts "Print out a tab-delimited data table with a header row following this format:"
    puts "LAST NAME  FIRST NAME  EMAIL  ZIPCODE  CITY  STATE  ADDRESS  PHONE  DISTRICT".bold.underline
  end

  def welcome
    puts "Welcome to Event Reporter. Type 'help' for a list of commands. Or enter command to begin.".cyan.bold.underline
  end

  def table_header
    puts "LAST NAME"+" "*5+"FIRST NAME"+" "*5+"EMAIL"+" "*5+"ZIPCODE"+" "*5+
    "CITY"+" "*5+"STATE"+" "*5+"ADDRESS"+" "*5+"PHONE".cyan.bold
  end

  def help_commands
    puts "Commands:
            -load <filename>
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
end
