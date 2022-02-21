class Api::V1::SearchesController < ApplicationController
  def search
    category_ids = params[:category_ids]
    if category_ids.nil?
      posts = Post.includes(:user, :like_users, :dislike_users, :categories).all
      render json: posts.to_json(include:
        [
          :user,
          :like_users,
          :dislike_users,
          { categories: { only: [:id, :name] } }
        ]
      )
    else
      # カテゴリーに合致した投稿のIDを取得
      post_ids = Classification.match_all_categories(category_ids)
      posts = Post.where(id: post_ids).includes(:user, :like_users, :dislike_users, :categories)
      if !posts.blank?
        render json: posts.to_json(include:
          [
            :user,
            :like_users,
            :dislike_users,
            { categories: { only: [:id, :name] } }
          ]
        )
      else
        render json: { message: '該当する投稿はありませんでした' }, status: 400
      end
    end
  end
end
