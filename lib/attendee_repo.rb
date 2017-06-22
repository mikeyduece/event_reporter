require 'csv'
require './lib/attendee'
class AttendeeRepo

  attr_reader :all, :find, :open_file

  def initialize(parent=nil)
    @all_attendees = []
  end

  def open_file(filename)
    CSV.foreach filename, headers: true, header_converters: :symbol do |row|
      row[:zipcode]= clean_zipcode(row[:zipcode])
      homephone    = clean_phone(row[:homephone])
      @all_attendees << Attendee.new(row)
      id           = row[0]
    end
  end

  def clean_zipcode(zipcode)
    zipcode.to_s.rjust(5,"0")[0..4]
  end

  def clean_phone(homephone)
    homephone.gsub!(/[x.()' '-]/, "")
    homephone[0] = "" if homephone.start_with?("1")
    homephone.to_s.ljust(10,"0")[0..9]
  end

  def all
    @all_attendees
  end

end
