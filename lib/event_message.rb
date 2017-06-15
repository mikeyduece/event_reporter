module EventMessages
  def queue_help(command=nil)
    puts "The queue holds the stored search results form previous searches.
    It is not cleared until the user enters the queue clear command or starts
    a new seach.
      The queue related commands are: count, clear, print, print_by<attribute>,
      and print_by<filename.csv>"
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
end
