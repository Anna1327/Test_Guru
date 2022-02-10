# frozen_string_literal: true

class ApplicationController < ActionController::Base
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  def after_sign_in_path(resource)
    flash.now[:notice] = "Hello, #{current_user.first_name} #{current_user.last_name}!" if resource.sign_in_count == 1
    resource.admin? ? admin_tests_path : root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:name, :email, :password, :password_confirmation)
    end
  end
end
