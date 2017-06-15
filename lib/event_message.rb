module EventMessages
  def queue_help(command=nil)
    puts "The queue holds the stored search results form previous searches.\n
    It is not cleared until the user enters the queue clear command or starts\n
    a new seach.\n
      \tThe queue related commands are: count, clear, print,\n
      \tprint_by<attribute>, and print_by<filename.csv>"
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
end
