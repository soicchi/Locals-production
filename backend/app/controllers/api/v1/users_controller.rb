class Api::V1::UsersController < ApplicationController
  def show
    user = User.includes(
      { following: { avatar_attachment: :blob } },
      { followers: { avatar_attachment: :blob } },
      :book_mark_posts,
      :liked_posts
    ).with_attached_avatar.find(params[:id])
    render json: user.to_json(include:
      [
        { following: { methods: :avatar_url } },
        { followers: { methods: :avatar_url } },
        :book_mark_posts,
        :liked_posts,
      ],
                              methods: :avatar_url
    )
  end

  def user_posts
    user = User.with_attached_avatar.find(params[:id])
    posts = user.posts.includes(
      { user: { avatar_attachment: :blob } },
      :like_users,
      :dislike_users,
      :categories
    )
    render json: posts.to_json(include:
      [
        { user: { methods: :avatar_url } },
        :like_users,
        :dislike_users,
        { categories: { only: :name } }
      ],
                               methods: :image_url,
                               except: [:comment, :updated_at]
    )
  end

  def following
    user = User.find(params[:id])
    render json: user.following
  end

  def followers
    user = User.find(params[:id])
    render json: user.followers
  end

  def book_mark_posts
    user = User.includes(:book_mark_posts).find(current_user.id)
    posts = user.book_mark_posts.includes(
      { user: { avatar_attachment: :blob } },
      :like_users,
      :dislike_users,
      :categories
    )
    render json: posts.to_json(include:
      [
        { user: { methods: :avatar_url } },
        :like_users,
        :dislike_users,
        { categories: { only: :name } }
      ],
                               methods: :image_url,
                               except: [:comment, :updated_at]
    )
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

  def following_posts
    user = User.includes(:following).find(current_user.id)
    posts = user.following_feed.includes(
      { user: { avatar_attachment: :blob } },
      :like_users,
      :dislike_users,
      :categories
    )
    render json: posts.to_json(include:
      [
        { user: { methods: :avatar_url } },
        :like_users,
        :dislike_users,
        { categories: { only: :name } }
      ],
                               methods: :image_url,
                               except: [:comment, :updated_at]
    )
  end

  def liked_posts
    user = User.includes(:liked_posts).find(params[:id])
    posts = user.liked_posts.includes(
      { user: { avatar_attachment: :blob } },
      :like_users,
      :dislike_users,
      :categories
    )
    render json: posts.to_json(include:
      [
        { user: { methods: :avatar_url } },
        :like_users,
        :dislike_users,
        { categories: { only: :name } }
      ],
                               methods: :image_url,
                               except: [:comment, :updated_at]
    )
  end
end
