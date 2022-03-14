class Api::V1::CurrentUsersController < ApplicationController
  before_action :authenticate_user!

  def index
    user = User.find(current_user.id)
    render json: user.to_json(
      include: [
        { following: { only: :id } },
        { liked_posts: { only: :id } },
        { disliked_posts: { only: :id } },
        { book_mark_posts: { only: :id } },
        { tastes: { only: [:id, :content] } }
      ],
      only: [
        :id,
        :name,
        :following,
        :liked_posts,
        :disliked_posts,
        :book_mark_posts,
        :guest,
        :admin,
        :tastes
      ]
    )
  end
end
