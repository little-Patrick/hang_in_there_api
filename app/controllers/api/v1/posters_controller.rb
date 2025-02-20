class Api::V1::PostersController < ApplicationController
  def show
    render json: Poster.find(params[:id])
  end

  def create
    render json: Poster.create(poster_params)
  end

  def update
    render json: Poster.update(params[:id], poster_params)
  end

  def destroy
    render json: Poster.delete(params[:id])
  end

  def index
    render json: Poster.all
  end

  private

  def poster_params
    params.require(:poster).permit(:name, :description, :price, :year, :vintage, :img_url)
  end
end
