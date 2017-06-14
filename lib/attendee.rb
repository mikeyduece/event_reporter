class Attendee
  attr_reader :id, :reg_date, :first_name, :last_name, :email,
              :home_phone, :street, :city, :state, :zipcode

  def initialize(params=nil, repo=nil)
    @id = params[0].to_i
    @reg_date = params[:regdate]
    @first_name = params[:first_name].downcase
    @last_name = params[:last_name].downcase
    @email = params[:email_address]
    @home_phone = params[:homephone].to_i
    @street = params[:street]
    @city = params[:city]
    @state = params[:state]
    @zipcode = params[:zipcode].to_i
  end
end
