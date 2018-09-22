class BeersController < ApplicationController
  def index
    @beers = Beer.all
  end

  def show
    @beer = Beer.find(params[:id])
  end

  def create
    @beer = Beer.new
    @beer.update(beer_params)

    render :show, status: :created
  end

  def update
    @beer = Beer.find(params[:id])
    @beer.update(beer_params)

    render :show, status: :ok
  end

  def destroy
    @beer = Beer.find(params[:id])
    @beer.destroy
    head :ok
  end

  private

  def beer_params
    params.require(:beer).permit(:name, :beer_type)
  end
end
