require 'csv'
require './lib/attendee'
class AttendeeRepo

  attr_reader :all, :find, :open_file

  def initialize(parent=nil)
    @all_attendees = []
    # open_file(filename)
  end

  def open_file(filename)
    CSV.foreach filename, headers: true, header_converters: :symbol do |row|
      @all_attendees << Attendee.new(row, self)
      id = row[0]
      zipcode = clean_zipcode(row[:zipcode])
    end
  end

  def clean_zipcode(zipcode)
    zipcode.to_s.rjust(5,"0")[0..4]
  end

  def all
    @all_attendees
  end

  # def find(attribute, criteria)
  #   criteria.delete("-") if attribute == "phone"
  #   search = all.find_all do |attendee|
  #     attendee.send(attribute.to_sym).to_s.downcase == criteria.to_s.downcase
  #   end
  #   return search
  # end

end
