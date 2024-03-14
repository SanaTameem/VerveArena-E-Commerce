class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  # rubocop:disable Lint/DuplicateHashKey
  def respond_with(resource, _options = {})
    if resource.persisted?
      render json: {
        status: { code: 200, message: 'Signed up successfully!', data: resource }
      }, status: :ok
    else
      render json: {
        status: { message: 'User can not be created!',
                  errors: resource.errors.full_messages }, status: :unprocessable_entity
        # rubocop:enable Lint/DuplicateHashKey
      }
    end
  end
end
