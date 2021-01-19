require 'twilio-ruby'
class Patron < ApplicationRecord
  belongs_to :company
  def text_details(to_number)
    if to_number[0].to_i == 0
      to_number[0] = "+61"
    end
    account_sid = 'ACb2ba7874efa096dd396a0db02f691000'
    auth_token = '0cd1d125555ad7022023baa64f3fcfba'
    client = Twilio::REST::Client.new(account_sid, auth_token)
    from = '+12057915340' # Your Twilio number
    if to_number.nil?
      to = '+61423934037' # Your mobile phone number
    else
      to = to_number
    end
    @company = self.company.name
    @message = "Hi #{self.first_name} your table is now ready at #{@venue}. We will hold the table for 10 minutes."
    client.messages.create(
    from: from,
    to: to,
    body: @message
    )
  end

  def text_waitlist(current_user)
    @venue = current_user.company
    @patrons = Patron.all.where(waitlist: false, company_id: @venue.id).order(:desc)
    @patrons.each do |p|
      if @venue.capacity.to_i > (@venue.capacity.to_i*@venue.percentage_full)
        p.text_details(p.phone_number)
        p.update(waitlist: false)
      end
    end
  end

end
