class Api::V1::CategoriesController < ApplicationController
  def index
    categories = Category.all
    render json: categories.to_json(only: [:id, :name])
  end

  def create
    # if current_user.admin
    category = Category.new(category_params)
    if category.save
      categories = Category.all
      render json: categories.to_json(only: [:id, :name])
    else
      render json: category.errors.full_messages, status: 422
    end
  end

  private

  def category_params
    params.permit(:name)
  end
end
