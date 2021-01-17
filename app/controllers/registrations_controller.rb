class RegistrationsController < Devise::RegistrationsController

  skip_before_action :require_no_authentication, only: [:new]
  before_action :authenticate_user!
  before_action :check_admin

  def new
    super
  end

  def create
    byebug
    User.create(email: params[:email], password: params[:password], company_id: params[:company][:id])
  end

  def update
    super
  end

  def check_admin
    if current_user.admin? == false
      redirect_to dashboard_path\
    end
  end

end
