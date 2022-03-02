class Api::V1::GuestsController < ApplicationController
  def create
    random_value = SecureRandom.hex(2)
    random_pass = SecureRandom.hex(4)
    user_params = {
      name: "guest_#{random_value}",
      email: "guest_#{random_value}@guest.com",
      birth_place: '北海道',
      birth_year: 1992,
      birth_month: 4,
      birth_day: 4,
      password: "#{random_pass}",
      password_confirmation: "#{random_pass}",
      guest: true
    }
    user = User.create!(user_params)
    render json: { email: user.email, password: user.password }
  end
end
