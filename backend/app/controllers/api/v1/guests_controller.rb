class Api::V1::GuestsController < ApplicationController
  def create
    random_value = SecureRandom.hex(2)
    user_params = {
      name: "guest_#{random_value}",
      email: "guest_#{random_value}@guest.com",
      birth_place: '北海道',
      birth_year: 1992,
      birth_month: 4,
      birth_day: 4,
      password: 'password',
      password_confirmation: 'password',
      guest: true
    }
    user = User.create!(user_params)
    render json: { email: user.email, password: user.password }
  end
end
