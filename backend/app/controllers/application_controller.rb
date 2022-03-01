class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :introduction, :avatar])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :birth_place, :birth_year, :birth_month, :birth_day])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end
end
