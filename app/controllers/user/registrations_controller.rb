# frozen_string_literal: true

class User::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  skip_before_action :require_no_authentication, only: [:new, :edit, :create]
  before_action :authenticate_user!, except:  [:new, :edit, :create]
  before_action :check_admin
  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    @user = User.new(email: params[:user][:email], password: params[:user][:password], company_id: params[:Company][:id], admin: params[:admin])
    if @user.save!
      flash[:notice] = "User Created"
      @company = Company.find(params[:Company][:id]).update(is_active: true)
      redirect_to dashboard_path
    else
      flash[:notice] = @user.errors
      redirect_to dashboard_path
    end
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  def check_admin
    if current_user.admin? == false
      redirect_to dashboard_path\
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end