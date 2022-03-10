class Api::V1::CategoriesController < ApplicationController
  def index
    categories = Category.order_category_list
    render json: categories.to_json(only: [:id, :name])
  end

  def create
    category = Category.new(category_params)
    if category.save # && current_user.admin ポートフォリオ上はコメントアウト
      categories = Category.order_category_list
      render json: categories.to_json(only: [:id, :name])
    else
      render json: category.errors.full_messages, status: 422
    end
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy # if current_user.admin ポートフォリオ上はコメントアウト
    render json: { message: "カテゴリーの#{category.name}を削除しました" }
  end

  private

  def category_params
    params.permit(:name)
  end
end
