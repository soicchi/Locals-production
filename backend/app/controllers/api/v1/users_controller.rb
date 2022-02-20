class Api::V1::UsersController < ApplicationController
  def show
    user = User.includes(:following, :followers, :book_mark_posts).find(params[:id])
    render json: user.to_json(include: [:following, :followers, :book_mark_posts])
  end

  def user_posts
    user = User.find(params[:id]) # with_attached_avatar付ける
    posts = user.posts
    render json: posts.to_json(include: :user)
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

  def book_mark_posts
    user = User.includes(:book_mark_posts).find(current_user.id)
    posts = current_user.book_mark_posts
    render json: posts.to_json(include: :user)
  end
end
