class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :check_admin, except: [:index, :edit, :show, :destroy]
  layout "venues", :only => [ :venue_capcity]
  # GET /companies
  # GET /companies.json
  def index
    if current_user.admin == true
      @companies = Company.all
      @patrons = Patron.where(waitlist: true)
    else
      @companies = Company.where(id: current_user.company_id)
      @patrons = Patron.where(company_id: current_user.company_id, waitlist: true)
    end
  end

  def message_patron
    @patron = Patron.find_by(params[:id])
    if @patron.text_details(@patron.phone_number)
      respond_to do |format|
          format.js { render js: "" }
        end
    end

  end

  def check_admin
    if current_user.admin? == false
      redirect_to root_path
    end
  end
  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  def audit
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
    if current_user.admin == true
    elsif current_user.company_id != params[:id].to_i
      redirect_to root_path
    end
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
        @company = Company.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to root_url, :flash => { :alert => "Record not found." }
    end

    # Only allow a list of trusted parameters through.
    def company_params
      params.require(:company).permit(:name, :address, :lat, :lng, :phone_number, :link, :capacity)
    end
end
