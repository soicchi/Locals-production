class Api::V1::CategoriesController < ApplicationController
  def index
    categories = Category.all
    render json: categories.to_json(only: [:id, :name])
  end
end
