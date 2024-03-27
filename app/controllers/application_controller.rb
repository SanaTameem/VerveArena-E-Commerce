class ApplicationController < ActionController::API
  include CanCan::ControllerAdditions
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |_exception|
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username role address])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username role address])
  end
end
