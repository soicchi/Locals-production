class Api::V1::BookMarksController < ApplicationController
  before_action :user_signed_in?

  def create
    post = Post.find(params[:post_id])
    current_user.book_mark(post) if post.user_id != current_user.id
    render json: { message: 'ブックマークしました' }
  end

  def destroy
    post = Post.find(params[:id])
    book_mark = current_user.book_marks.find_by(post_id: post.id)
    current_user.remove_book_mark(post) if book_mark
    render json: { message: 'ブックマークを解除しました' }
  end
end
