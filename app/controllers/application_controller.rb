class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :role, :address])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :role, :address])
  end
end
