class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  include SessionsHelper

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit(:name, :email,
      :password, :date_of_birth, :avatar)}
    devise_parameter_sanitizer.permit(:account_update) {|u| u.permit(:name,
      :email, :password, :current_password, :date_of_birth, :avatar)}
  end
end
