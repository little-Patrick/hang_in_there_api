class Api::V1::PostersController < ApplicationController
  def index
    sort = params[:sort]
    posters = Poster.poster_sorting(sort)
    render json: PosterSerializer.format_posters(posters)
  end
  
  def show
    poster = Poster.find(params[:id])
    render json: PosterSerializer.format(poster)
  end

  def create
    poster = Poster.create(poster_params)
    render json: PosterSerializer.format(poster)
  end

  def update
    render json: Poster.update(params[:id], poster_params)
  end

  def destroy
    render json: Poster.delete(params[:id])
  end

  private

  def poster_params
    params.require(:poster).permit(:name, :type, :description, :price, :year, :vintage, :img_url)
  end
end
