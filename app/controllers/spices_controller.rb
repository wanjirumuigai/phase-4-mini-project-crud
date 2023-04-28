class SpicesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  def index
    spices = Spice.all
    render json: spices, only: %i[id title image description notes rating]
  end

  def create
    spice = Spice.create(update_params)
    render json: spice, status: :created
  end

  def update
    spice = Spice.find_by(id: params[:id])
    spice.update(update_params)
    render json: spice
  end

  def destroy
    spice = Spice.find_by(id: params[:id])
    spice.destroy
    render json: {}
  end

  private

  def update_params
    params.permit(:title, :image, :description, :notes, :rating)
  end
  def render_not_found_response
    render json: { error: "spice not found" }, status: :not_found
  end
end
