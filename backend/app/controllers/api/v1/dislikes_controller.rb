class Api::V1::DislikesController < ApplicationController
  before_action :user_signed_in?

  def create
    post = Post.find(params[:post_id])
    if current_user.id != post.user_id && !current_user.disliked?(post)
      current_user.dislike(post)
      current_user.unlike(post) if current_user.liked?(post)
    else
      render json: { message: 'う〜んを付けれませんでした' }, status: 400
    end
  end

  def destroy
    post = Post.find(params[:id])
    dislike = current_user.dislikes.find_by(post_id: post.id)
    if dislike
      current_user.undislike(post)
    else
      render json: { message: '元からう〜んを付けていません' }, status: 400
    end
  end
end
