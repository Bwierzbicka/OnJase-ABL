class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit::Authorization

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username display_name avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username display_name avatar])
  end
end
