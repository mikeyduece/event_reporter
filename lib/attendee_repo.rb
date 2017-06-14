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

  def find_all_by_first_name(fname)
    first_names = all.find_all do |attendee|
      attendee.first_name.downcase.include?(fname.downcase)
    end
    return [] if first_names.empty?
    return first_names
  end

  def find_all_by_last_name(lname)
    last_names = all.find_all do |attendee|
      attendee.last_name.downcase.include?(lname.downcase)
    end
    return [] if last_names.empty?
    return last_names
  end

  def find_by_phone(phone_num)
    all.map do |attendee|
      if attendee.home_phone == phone_num
        return attendee
      end
      nil
    end
  end

  def find_by_street(addy)
    streets = all.find_all do |attendee|
      attendee.street.downcase.include?(addy.downcase)
    end
    return [] if streets.empty?
    return streets
  end



end
