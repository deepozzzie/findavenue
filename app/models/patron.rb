require 'twilio-ruby'
class Patron < ApplicationRecord
  belongs_to :company
  def text_details(to_number)
    if to_number[1].to_i == 4
      to_number[0] = "+61"
    end
    account_sid = ENV['twilio_account_ssid']
    auth_token = ENV['twilio_auth_token']
    client = Twilio::REST::Client.new(account_sid, auth_token)
    from = ENV['twilio_phone_number'] # Your Twilio number
    if to_number.nil?
      to = '+61423934037' # Your mobile phone number
    else
      to = to_number
    end
    @company = self.company.name
    @message = "Hi #{self.first_name} your table is now ready at #{@company}. We will hold the table for 10 minutes."
    begin
        @messages =  client.messages.create(
        from: from,
        to: to,
        body: @message
        )
      return true
    rescue Twilio::REST::RestError => error
      @error = error
      return false
    end
    byebug
  end

  def text_waitlist(current_user)
    @venue = current_user.company
    @max_to_invite = (@venue.capacity.to_i - (@venue.capacity.to_i*(@venue.percentage_full/100)))
    @patrons = Patron.all.where(waitlist: true, company_id: @venue.id, created_at:  (Time.now - 3.hours)..Time.now).order(created_at: :desc).limit(@max_to_invite)
    @patrons.each do |p|
      if (@venue.capacity.to_i > (@venue.capacity.to_i*(@venue.percentage_full/100)))
        p.text_details(p.phone_number)
        p.update(waitlist: false)
      end
    end
  end

end
