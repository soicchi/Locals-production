class Api::V1::RelationshipsController < ApplicationController
  before_action :user_signed_in?

  def create
    user = User.find(params[:user_id])
    current_user.follow(user) if user.id != current_user.id
    render json: { message: 'フォローしました' }
  end

  def destroy
    user = User.find(params[:id])
    relationship = current_user.active_relationships.find_by(followed_id: user.id)
    current_user.unfollow(user) if relationship
    render json: { message: 'フォローを解除しました' }
  end
end
