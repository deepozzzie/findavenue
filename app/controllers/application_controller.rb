class ApplicationController < ActionController::Base
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:company_id, :admin)
    devise_parameter_sanitizer.for(:edit).push(:company_id, :admin)
  end
end
