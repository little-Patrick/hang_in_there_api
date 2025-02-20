class Api::V1::PostersController < ApplicationController
  def show
    # render json: Poster.find(params[:id])
    poster = Poster.find(params[:id])
    render json: PosterSerializer.format_poster(poster)
  end

  def create
    poster = Poster.create(poster_params)
    render json: PosterSerializer.format_poster(poster)
  end

  def update
    render json: Poster.update(params[:id], poster_params)
  end

  def destroy
    render json: Poster.delete(params[:id])
  end

  def index
    # render json: Poster.all
    poster = Poster.all
    render json: {
      data: [
        {
          id: poster.id.to_s,
          type: "poster",
          attributes: {
            name: poster.name, 
            description: poster.name, 
            price: poster.price, 
            year: poster.year, 
            vintage: poster.vintage, 
            img_url: poster.img_url, 
          }
        }
      ]
    }
  end

  private

  def poster_params
    params.require(:poster).permit(:name, :type, :description, :price, :year, :vintage, :img_url)
  end
end
