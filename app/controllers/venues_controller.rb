class VenuesController < ApplicationController
  before_action :authenticate_user!


  # GET /venues
  # GET /venues.json
  def index
    render(:layout => "layouts/default")
    flash[:notice] = current_user.company.name
  end

  def set_company_capacity
    if current_user.company.update(percentage_full:params[:venue_capacity])
      respond_to do |format|
        format.html
        format.js { render js: ""}
      end
    end
  end

  def show
    render(:layout => "layouts/default")
    flash[:notice] = current_user.company.name
  end

  def change_page_percentage_full
    if current_user.company.percentage_full == 0
      respond_to do |format|
        format.html
        format.js { render js: "document.getElementById('available').style='display: block;'
          document.getElementById('almost_out').style='display: none;'
          document.getElementById('out').style='display: none;'"}
        end
    elsif current_user.company.percentage_full == 50
      respond_to do |format|
        format.html
        format.js { render js: "document.getElementById('available').style='display: none;'
          document.getElementById('almost_out').style='display: block;'
          document.getElementById('out').style='display: none;'"}
        end
    else
      respond_to do |format|
        format.html
        format.js { render js: "document.getElementById('available').style='display: none;'
          document.getElementById('almost_out').style='display: none;'
          document.getElementById('out').style='display: block;'"}
        end
      end
  end

  def return_all_venues

    @venues = Company.all

    @userlist = @venues.map do |u|
        link = "https://demo.findavenue.io/venue/patron/new/"

        link = "https://venues.findavenue.io/venue/patron/new/"

      @max_cap = u.capacity
      @per_full = (u.percentage_full)
      @percentage = @per_full
      if @percentage == 100
        @color = "red"
      elsif @percentage == 50
        @color = "orange"
      else
        @color = "green"
      end
      { :name => u.name, :phone_number => u.phone_number, :address => u.address, :capacity => @percentage, :link => link, :color=>@color, long: u.lng, lat: u.lat }
    end
    @json = @userlist.to_json
    respond_to do |format|
      format.html { render json: @json, status: 200 }
      format.json {render json: @json, status: 200}
    end


  end
end
