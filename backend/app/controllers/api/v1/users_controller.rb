class Api::V1::UsersController < ApplicationController
  def show
    user = User.includes(:following, :followers).find(params[:id])
    render json: user.to_json(include: [:following, :followers])
  end

  def following
    user = User.find(params[:id])
    render json: user.following
  end

  def followers
    user = User.find(params[:id])
    render json: user.followers
  end

  def following_posts
    user = User.includes(:following, :posts).find(current_user.id)
    posts = user.following_feed
    render json: posts.to_json(include: :user)
  end
end
