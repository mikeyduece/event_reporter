require 'csv'
require './lib/attendee'
class AttendeeRepo

  attr_reader :all

  def initialize(filename)
    @all_attendees = []
    open_file(filename)
  end

  def open_file(filename)
    CSV.foreach filename, headers: true, header_converters: :symbol do |row|
      @all_attendees << Attendee.new(row, self)
      id = row[0]
    end
  end

  def all
    @all_attendees
  end

  def find_by_id(id)
    all.find do |attendee|
      if attendee.id == id
        return attendee
      end
      nil
    end
  end
end
