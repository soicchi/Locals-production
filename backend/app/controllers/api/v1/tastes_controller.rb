class Api::V1::TastesController < ApplicationController
  def index
    tastes = Taste.all
    render json: tastes.to_json(only: [:id, :content])
  end
end
