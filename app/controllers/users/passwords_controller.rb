class Users::PasswordsController < ApplicationController
  skip_before_action :authenticate_user!
  respond_to :json

  skip_load_and_authorize_resource

  def forgot
    user = User.find_by(email: params[:user][:email])
    if user
      user.generate_reset_password_token
      user.save
      # Send email with reset password instructions (not implemented here)
      render json: {
        status: { code: 200, message: 'Reset password instructions sent successfully!' }
      }, status: :ok
    else
      render json: {
        status: { message: 'User not found with the provided email!' }
      }, status: :not_found
    end
  end

  def reset
    user = User.find_by(reset_password_token: params[:reset_password_token])
    if user && user.reset_password_sent_at > 1.hour.ago
      user.update(password: params[:password], reset_password_token: nil)
      render json: {
        status: { code: 200, message: 'Password reset successfully!' }
      }, status: :ok
    else
      render json: {
        status: { message: 'Invalid or expired reset password token!' }
      }, status: :unprocessable_entity
    end
  end
end
