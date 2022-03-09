class Api::V1::CategoriesController < ApplicationController
  def index
    categories = Category.all
    render json: categories.to_json(only: [:id, :name])
  end

  def create
    if current_user.admin
      category = Category.create!(category_params)
      categories = Category.all
      render json: categories.to_json(
        only: [:id, :name]
      )
    else
      render json: { message: '管理者でないと作成できません' }, status: 401
    end
  end

  private

  def category_params
    params.permit(:name)
  end
end
