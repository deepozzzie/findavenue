require 'net/http'
require 'uri'
class VenuesController < ApplicationController
  before_action :authenticate_user!, except: [:return_all_venues]


  # GET /venues
  # GET /venues.json
  def index
    render(:layout => "layouts/default")
    flash[:notice] = current_user.company.name
  end

  def set_company_capacity
    if current_user.company.update(percentage_full:params[:venue_capacity])
        # this function we need to take in the param of 1, 2, or 3. Where 1 is at capacity, 2 is filling up fast
        # 3 we are full and are about to crack a leak.
      if current_user.company.percentage_full == 0
        Patron.first.text_waitlist(current_user)
        Audit.create(venue_name: current_user.company.name, venue_capacity: 0)
      elsif current_user.company.percentage_full == 50
        Patron.first.text_waitlist(current_user)
        Audit.create(venue_name: current_user.company.name, venue_capacity: 50)
      end
      if current_user.company.percentage_full ==100
        Audit.create(venue_name: current_user.company.name, venue_capacity: 100)
      end
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
    @venues.each do |u|
      #return_open_places(u)
      if u.places_id != nil
        return_open(u.places_id)
        print u.updated_at
      end
    end
    @venues = Company.all
    @userlist = @venues.map do |u|
      if u.is_open == true
        logger.debug u.name
        link = u.link
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
        if u.is_active == false
          @color = "gray"
            { :id=>u.id, :name => u.name, :phone_number => u.phone_number, :address => u.address, :capacity => @percentage, :link => u.link, :color=>@color, long: u.lng, lat: u.lat }
        end
          { :id=>u.id, :name => u.name, :phone_number => u.phone_number, :address => u.address, :capacity => @percentage, :link => u.link, :color=>@color, long: u.lng, lat: u.lat }
      else
        if u.is_active == false
          @color = "gray"
            { :id=>u.id, :name => u.name, :phone_number => u.phone_number, :address => u.address, :capacity => @percentage, :link => u.link, :color=>@color, long: u.lng, lat: u.lat }
        else
          @color = "white"
        end
          { :id=>u.id, :name => u.name, :phone_number => u.phone_number, :address => u.address, :capacity => @percentage, :link => u.link, :color=>@color, long: u.lng, lat: u.lat }
      end
    end



    @json = @userlist.to_json
    respond_to do |format|
      format.html { render json: @json, status: 200 }
      format.json {render json: @json, status: 200}
    end
  end

  def return_open(places_id)
    logger.debug places_id
    uri = URI.parse("https://maps.googleapis.com/maps/api/place/details/json?place_id=#{places_id}&fields=name,rating,formatted_phone_number,opening_hours,formatted_address&key=AIzaSyDHvVaqvV6oKDo7E30tlWmI7D28jTU3EGQ")
    response = Net::HTTP.get_response(uri)
    @response = JSON(response.body)
    logger.debug @response
    logger.debug places_id
    if @response["status"] == "INVALID_REQUEST" or @response.empty?
      @company = Company.find_by(places_id: places_id)
      @company.update(is_open: false, update_number: @company.update_number+1);
      return false
    else
      if @response["result"]["opening_hours"].nil? == false and @response["result"]["opening_hours"]["open_now"] == true
        @company = Company.find_by(places_id: places_id)
        @company.update(is_open: true, update_number: @company.update_number+1);
      else
        @company = Company.find_by(places_id: places_id)
        @company.update(is_open: false, update_number: @company.update_number+1);
      end
      if @response["result"]["opening_hours"].nil? == true
        @company = Company.find_by(places_id: places_id)
        @company.update(is_open: true, update_number: @company.update_number+1);
      end
    end
  end

  def return_open_places(company)
    # byebug
    logger.debug company.name
    if company.monday_open.nil? == false && company.monday_closed.nil? == false  && Time.now.strftime("%H%M").to_i > company.monday_open && Time.now.strftime("%H%M").to_i < company.monday_closed
      logger.debug ("true")
      company.update(is_open: true)
      return true
    elsif company.tuesday_open.nil? == false && company.tuesday_closed.nil? == false  && Time.now.strftime("%H%M").to_i > company.tuesday_open && Time.now.strftime("%H%M").to_i < company.tuesday_closed
      logger.debug ("true")
      company.update(is_open: true)
      return true
    elsif company.wednesday_open.nil? == false && company.wednesday_closed.nil? == false  && Time.now.strftime("%H%M").to_i > company.wednesday_open && Time.now.strftime("%H%M").to_i < company.wednesday_closed
      logger.debug ("true")
      company.update(is_open: true)
      return true
    elsif company.thursday_open.nil? == false && company.thursday_closed.nil? == false  && Time.now.strftime("%H%M").to_i > company.thursday_open && Time.now.strftime("%H%M").to_i < company.thursday_closed
      logger.debug ("true")
      company.update(is_open: true)
      return true
    elsif company.friday_open.nil? == false && company.friday_closed.nil? == false  &&  Time.now.strftime("%H%M").to_i > company.friday_open && Time.now.strftime("%H%M").to_i < company.friday_closed
      logger.debug ("true")
      company.update(is_open: true)
      return true
    elsif company.saturday_open.nil? == false && company.saturday_closed.nil? == false  && Time.now.strftime("%H%M").to_i > company.saturday_open && Time.now.strftime("%H%M").to_i < company.saturday_closed
      logger.debug ("true")
      company.update(is_open: true)
      return true
    elsif company.sunday_open.nil? == false && company.sunday_closed.nil? == false  && Time.now.strftime("%H%M").to_i > company.sunday_open && Time.now.strftime("%H%M").to_i < company.sunday_closed
      logger.debug ("true")
      company.update(is_open: true)
      return true
    else
      logger.debug ('false')
      company.update(is_open: false)
      return false
    end
  end
end
