class Attendee
  attr_reader :id, :reg_date, :first_name, :last_name, :email,
              :home_phone, :street, :city, :state, :zipcode

  def initialize(params=nil)
    @id = params[:id]
    @reg_date = params[:regdate]
    @first_name = params[:first_name].downcase
    @last_name = params[:last_name].downcase
    @email = params[:email_address]
    @home_phone = params[:homephone]
    @street = params[:street]
    @city = params[:city]
    @state = params[:state]
    @zipcode = params[:zipcode]
  end
end
