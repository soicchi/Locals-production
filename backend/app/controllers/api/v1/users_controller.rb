class Api::V1::UsersController < ApplicationController
  def show
    user = User.includes(:following, :followers, :book_mark_posts, :liked_posts).find(params[:id])
    render json: user.to_json(include: [:following, :followers, :book_mark_posts, :liked_posts])
  end

  def user_posts
    user = User.includes(:posts).find(params[:id]) # with_attached_avatar付ける
    posts = user.posts
    render json: posts.to_json(include: [:user, :like_users, :dislike_users])
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
    render json: posts.to_json(include: [:user, :like_users, :dislike_users])
  end

  def book_mark_posts
    user = User.includes(:book_mark_posts).find(current_user.id)
    posts = current_user.book_mark_posts
    render json: posts.to_json(include: [:user, :like_users, :dislike_users])
  end

  def liked_posts_ids
    user = User.includes(:liked_posts).find(current_user.id)
    posts_ids = user.liked_posts.ids
    render json: posts_ids
  end

  def disliked_posts_ids
    user = User.includes(:disliked_posts).find(current_user.id)
    posts_ids = user.disliked_posts.ids
    render json: posts_ids
  end

  def liked_posts
    user = User.includes(:liked_posts).find(params[:id])
    posts = user.liked_posts
    render json: posts.to_json(include: [:user, :like_users, :dislike_users])
  end
end
