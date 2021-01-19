class ContactUsMailer < ApplicationMailer
  default from: "theeufj@gmail.com"

  def send_contact(params)
    @first_name =  params[:first_name]
    @last_name = params[:last_name]
    @email = params[:email]
    @message = params[:message]
    @phone_number = params[:phone_number]
    mail(to:"theeufj@gmail.com", subject: "contact us")
  end

  def request_company(params)
    @first_name = params[:first_name]
    @company_name = Company.find_by(id: params[:company_id]).name
    @phone_number = params[:phone_number]
    mail(to:"theeufj@gmail.com", subject: "Request Company")
  end
end
