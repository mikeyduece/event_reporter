require 'csv'
require 'json'
require 'erb'
require 'gyoku'
require 'yaml'
require './lib/attendee_repo'
require './lib/event_messages'

class Queue
  include EventMessages
  attr_reader :attendees, :all_attendees, :er, :queued

  def initialize(parent=nil)
    @er        = parent
    @queued    = []
  end

  def count
    @queued.count
  end

  def finder(attribute, criteria)
    clear
    @queued << er.attendees.all.find_all do |attendee|
      attendee.send(attribute.to_sym).to_s.downcase == criteria.to_s.downcase
    end
    queued.flatten!
  end

  def clear
    @queued = []
  end

  def save_to(filename)
    if er.third_command.include?(".csv")
      save_csv(filename)
    elsif er.third_command.include?(".html")
      save_html(filename)
    elsif er.third_command.include?(".txt")
      save_txt(filename)
    elsif er.third_command.include?(".json")
      save_json(filename)
    elsif er.third_command.include?(".xml")
      save_xml(filename)
    elsif er.third_command.include?(".yml")
      save_yml(filename)
    end
  end

  def save_html(filename)
    template_letter = File.read "template.erb"
    erb_letter      = ERB.new template_letter
    form_letter     = erb_letter.result(binding)

    Dir.mkdir("html") unless Dir.exists? "html"
    file = "html/#{filename}"

    File.open(file,"w") do |file|
      file.puts form_letter
    end
  end

  def save_txt(filename)
    Dir.mkdir("txt") unless Dir.exists? "txt"
    file = "txt/#{filename}"

    File.open("#{file}","w") do |file|
      format = '%-12s %-10s %-35s %-7s %-22s %-6s %-38s %s'
      file.puts format % table_header
      queued.map do |att|
        attributes = [att.last_name.capitalize, att.first_name.capitalize,
                      att.email, att.zipcode,
                      att.city.split.map(&:capitalize)*' ', att.state,
                      att.street, att.phone]
        file.puts format % attributes
      end
    end

  end

  def save_csv(filename)
    Dir.mkdir("csv_output") unless Dir.exists? "csv_output"
    file    = "csv_output/#{filename}"

    headers = [:id,:reg_date,:first_name,:last_name,:email,:phone,:street,
               :city,:state,:zipcode]
    CSV.open("#{file}","w") do |csv|
      csv << headers
      queued.map do |att|
        csv << [att.id, att.reg_date, att.first_name, att.last_name, att.email,
                att.phone, att.street, att.city, att.state,
                att.zipcode]
      end
    end
  end

  def save_json(filename)
    Dir.mkdir("json") unless Dir.exists? "json"
    file = "json/#{filename}"

    File.open("#{file}","w") do |file|
      queued.map do |att|
        temp_hash = {
        last_name: att.last_name.capitalize, first_name: att.first_name.capitalize,
        email: att.email, zipcode: att.zipcode, city: att.city.split.map(&:capitalize)*' ',
        street: att.street, state: att.state, phone: att.phone}
        file.puts temp_hash.to_json
      end
    end
  end

  def save_xml(filename)
    Dir.mkdir("xml") unless Dir.exists? "xml"
    file = "xml/#{filename}"

    File.open("#{file}","w") do |file|
      queued.map do |att|
        temp_hash={attendee: {last_name: att.last_name.capitalize, first_name: att.first_name.capitalize,
        email: att.email, zipcode: att.zipcode, city: att.city.split.map(&:capitalize)*' ',
        street: att.street, state: att.state, phone: att.phone}}
        file.puts Gyoku.xml(temp_hash)
      end
    end
  end

  def save_yml(filename)
    Dir.mkdir("yml") unless Dir.exists? "yml"
    file = "yml/#{filename}"

    File.open("#{file}","w") do |file|
      queued.map do |att|
        temp_hash={last_name: att.last_name.capitalize, first_name: att.first_name.capitalize,
        email: att.email, zipcode: att.zipcode, city: att.city.split.map(&:capitalize)*' ',
        street: att.street, state: att.state, phone: att.phone}
        file.puts temp_hash.to_yaml
      end
    end
  end

end
