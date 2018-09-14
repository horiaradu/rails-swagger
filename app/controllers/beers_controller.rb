class BeersController < ApplicationController
  skip_before_action :authenticate_user!, only: :laggers

  def laggers
    render json: { laggers: 'true' }
  end

  def ipas
    render json: { ipas: 'true' }
  end
end
