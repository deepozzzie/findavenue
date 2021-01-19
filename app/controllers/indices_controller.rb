class IndicesController < ApplicationController
  before_action :authenticate_user!, except: [:home, :add_patron_to_venue]
  # GET /indices
  # GET /indices.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: CompanyDatatable.new(params)}
    end
  end

  def redirect_to_path
      path = case current_user.admin
    when true
      indices_path
    else
      company_path(current_user.company_id)
      # If you want to raise an exception or have a default root for users without roles
    end
    redirect_to path
  end

  def home
    render(:layout => "layouts/landingpage")
  end

  def contact_us
    ContactUsMailer.send_contact(params).deliver_now
  end

  def request_company
    ContactUsMailer.request_company(params).deliver_now
  end

  def add_patron_to_venue
    @patron = Patron.new(first_name: params[:first_name], phone_number: params[:phone_number], company_id: params[:company_id])
    if @patron.save
      respond_to do |format|
        format.html
        format.js { render js: "alert('added to waitlist')"}
      end
    end
  end

end
