class Api::V1::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]

  def index
    posts = Post.includes(
      { user: { avatar_attachment: :blob } },
      :like_users,
      :dislike_users,
      :categories,
      :tastes
    ).with_attached_images.all
    render json: posts.to_json(
      include: [
        { user: { methods: :avatar_url, only: [:id, :name, :avatar_url] } },
        { categories: { only: :name } },
        { tastes: { only: [:id, :content] } }
      ],
      methods: [:image_url, :like_percentage],
      except: :updated_at
    )
  end

  def show
    post = Post.with_attached_images.find(params[:id])
    render json: post.to_json(
      include: [
        { user: { methods: :avatar_url, only: [:id, :name, :avatar_url] } },
        { like_users: { only: :id } },
        { dislike_users: { only: :id } },
        { categories: { only: [:name] } },
        { tastes: { only: [:id, :content] } }
      ],
      methods: [
        :image_url,
        :liked_age_group,
        :disliked_age_group,
        :like_percentage,
        :favorite_rate_group
      ],
      except: [:updated_at]
    )
  end

  def create
    post = current_user.posts.build(post_params)
    if post.save
      render json: { message: '投稿が作成されました' }, status: 200
    else
      render json: post.errors.full_messages, status: 400
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.images.purge
    post.destroy
    render json: { message: '投稿が削除されました' }
  end

  private

  def post_params
    params.permit(:comment, :restaurant_name, :station, images: [], category_ids: [], taste_ids: [])
  end

  def correct_user
    post = current_user.posts.find(params[:id])
    return if post.nil?
  end
end
