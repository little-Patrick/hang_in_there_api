class Api::V1::PostersController < ApplicationController
  def index
    if params[:name]
      posters = Poster.sort_names(params[:name])
      render json: PosterSerializer.format_posters(posters)
    elsif params[:max_price]
      posters = Poster.max_price(params[:max_price])
      render json: PosterSerializer.format_posters(posters)
    elsif params[:min_price]
      posters = Poster.min_price(params[:min_price])
      render json: PosterSerializer.format_posters(posters)
    else
      sort = params[:sort]
      posters = Poster.poster_sorting(sort)
      render json: PosterSerializer.format_posters(posters)
    end
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
    poster = Poster.update(params[:id], poster_params)
    render json: PosterSerializer.format(poster)
  end

  def destroy
    render json: Poster.delete(params[:id])
    head :no_content
  end

  private

  def poster_params
    params.require(:poster).permit(:name, :type, :description, :price, :year, :vintage, :img_url)
  end
end
