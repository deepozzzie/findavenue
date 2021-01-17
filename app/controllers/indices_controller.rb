class IndicesController < ApplicationController
  before_action :authenticate_user!, except: [:home]
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

end
