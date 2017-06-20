require 'csv'
require 'erb'
require './lib/attendee_repo'
# require 'sunlight/congress'

class Queue
  # Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"
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
    criteria.delete("-") if attribute == "phone"
    @queued << er.attendees.all.find_all do |attendee|
      attendee.send(attribute.to_sym).to_s.downcase == criteria.to_s.downcase
    end
    queued.flatten!
  end

  def clear
    @queued = []
  end

  def legislators_by_zipcode(zipcode)
    legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)

    legislator_names = legislators.collect do |legislator|
    "#{legislator.first_name} #{legislator.last_name}"
    end
    legislator_names.join(", ")
  end

  def save_to(filename)
    if er.third_command.include?(".csv")
      save_csv(filename)
    elsif er.third_command.include?(".html")
      save_html(filename)
    end
  end

  def save_html(filename)
    template_letter = File.read "template.erb"
    erb_letter = ERB.new template_letter
    form_letter = erb_letter.result(binding)

    Dir.mkdir("html") unless Dir.exists? "html"
    file = "html/#{filename}"

    File.open(file,"w") do |file|
      @headers = [:id,:reg_date,:first_name,:last_name,:email,:phone,:street,
        :city,:state,:zipcode]
      # queued.map do |att|
      #   file << [att.id, att.reg_date, att.first_name, att.last_name, att.email,
      #           att.phone, att.street, att.city, att.state, att.zipcode]
      # end
      file.puts form_letter
    end
  end

  def save_csv(filename)
    Dir.mkdir("csv_output") unless Dir.exists? "csv_output"
    file = "csv_output/#{filename}"

    headers = [:id,:reg_date,:first_name,:last_name,:email,:phone,:street,
               :city,:state,:zipcode]
    CSV.open("#{file}","w") do |csv|
      csv << headers
      queued.map do |att|
        csv << [att.id, att.reg_date, att.first_name, att.last_name, att.email,
                att.phone, att.street, att.city, att.state, att.zipcode]
      end
    end
  end

end
