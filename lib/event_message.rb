require 'colorize'
module EventMessages
  def queue_help(command=nil)
    puts "The queue holds the stored search results form previous searches.
    It is not cleared until the user enters the queue clear command or starts
    a new seach.
      The queue related commands are: count, clear, print,
      print_by<attribute>, and print_by<filename.csv>"
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
      find(attribute, criteria)."
  end

  def print_help
    puts "Print out a tab-delimited data table with a header row following this format:

      LAST NAME  FIRST NAME  EMAIL  ZIPCODE  CITY  STATE  ADDRESS  PHONE  DISTRICT"
  end

  def welcome
    puts ("_"*62).bold.underline
    puts "Welcome to Event Reporter. Type 'help' for a list of commands.".bold.underline
  end

  def table_header
    puts "LAST NAME"+" "*5+"FIRST NAME"+" "*5+"EMAIL"+" "*5+"ZIPCODE"+" "*5+
    "CITY"+" "*5+"STATE"+" "*5+"ADDRESS"+" "*5+"PHONE".cyan.bold
  end

  def commands
    puts "Commands:
            -load <filename>
            -help
            -help <command>
            -print
            -print by <attribute>
            -save to <filename.csv>
            -export html <filename.csv>
            -find <attribute> <criteria>".yellow.bold
  end
end
