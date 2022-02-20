class Api::V1::LikesController < ApplicationController
  before_action :user_signed_in?

  def create
    post = Post.find(params[:post_id])
    if !current_user.liked?(post) && current_user.id != post.user_id
      current_user.like(post)
      current_user.undislike(post) if current_user.disliked?(post)
    else
      render json: { message: 'いいねができませんでした' }, status: 400
    end
  end

  def destroy
    post = Post.find(params[:id])
    like = current_user.likes.find_by(post_id: post.id)
    if like
      current_user.unlike(post)
    else
      render json: { message: '元からいいねされていません' }, status: 400
    end
  end
end
