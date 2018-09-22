class ApplicationController < ActionController::API
  before_action :authenticate_user!

  respond_to :json

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { error: e.message }, status: :not_found
  end
end
