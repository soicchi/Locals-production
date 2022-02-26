class Api::V1::UsersController < ApplicationController
  def show
    user = User.includes(posts: { images_attachments: :blob }).find(params[:id])
    render json: user.to_json(include:
      [
        { posts: {
            include: [
              { user: { methods: :avatar_url } },
              :like_users,
              :dislike_users,
              { categories: { only: :name } }
            ],
            methods: :image_url
          }
        },
        :following,
        :followers,
        :liked_posts
      ],
                              methods: :avatar_url
    )
  end

  def book_mark_posts
    user = User.find(current_user.id)
    posts = user.book_mark_posts.includes(
      { user: { avatar_attachment: :blob } },
      :like_users,
      :dislike_users,
      :categories
    ).with_attached_images
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
    user = User.find(current_user.id)
    posts = user.following_feed.includes(
      { user: { avatar_attachment: :blob } },
      :like_users,
      :dislike_users,
      :categories
    ).with_attached_images
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
    user = User.find(params[:id])
    posts = user.liked_posts.includes(
      { user: { avatar_attachment: :blob } },
      :like_users,
      :dislike_users,
      :categories
    ).with_attached_images
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
